import 'package:app/helpers/connectionCheck.dart';
import 'package:app/helpers/dbHelper.dart';
import 'package:app/helpers/serverHelper.dart';
import 'package:app/screens/notesListPage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../widgets/notification.dart';
import '../model/health.dart';
import '../widgets/message.dart';
import 'addNote.dart';

class MainSection extends StatefulWidget {
  const MainSection({Key? key}) : super(key: key);

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {

  var logger = Logger();
  bool online = true;
  late List<String> dates = [];
  bool loading = false;
  Map _source = {ConnectivityResult.none: false};
  final ConnectionChecker _connectivity = ConnectionChecker.instance;
  String string = '';

  @override
  void initState(){
    super.initState();
    checkConn();
  }

  void checkConn() {
    _connectivity.init();
    _connectivity.myStream.listen((source) {
      _source = source;
      logger.log(Level.info, _source);
      var newStatus = true;
      switch (_source.keys.toList()[0]){
        case ConnectivityResult.mobile:
          string = _source.values.toList()[0] ? 'Mobile - online' : 'Mobile - offline';
          break;
        case ConnectivityResult.wifi:
          string = _source.values.toList()[0] ? 'WiFi - online' : 'WiFi - offline';
          newStatus = _source.values.toList()[0] ? true : false;
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
          newStatus = false;
      }
      logger.log(Level.info, "Connection status: $online, $newStatus");
      if (online != newStatus){
        online = newStatus;
        if (newStatus) { message(context, 'Connection restored', "Info"); }
        else { message(context, 'Connection lost', "Info"); }
      }
      getDays();
    });
  }

  getDays() async {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    if (online) {
      try{
        dates = await ServerHelper.instance.getDates();
        DbHelper.updateDates(dates);
      } catch(e) {
        logger.e(e);
        message(context, "Error connecting to server", "Error");
      }
    } else {
      dates = await DbHelper.getDates();
    }

    setState(() { loading = false; });
  }

  saveHealthNote(HealthNote hn) async {
    if (!mounted) return;
    setState(() { loading = true; });
    if (online){
      try{
        final HealthNote received = await ServerHelper.instance.addHealthNote(hn);
        DbHelper.addHealthNote(received);
      } catch(e){
        logger.e(e);
        message(context, "Error connecting to server", "Error");
      }
    } else { message(context, "Operation not available offline!", "Error");}
    setState(() { loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Main section')
      ),
      body: loading
      ? const Center(child: CircularProgressIndicator())
      : Center(
        child: ListView(
          children: [
            ListView.builder(
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(dates[index]),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => NotesListPage(dates[index])
                    ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0
                    )
                  ),
                );
              }),
              itemCount: dates.length,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10.0),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!online) {
            message(context, "Operation not available", "Error");
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: ((context) => AddNote())))
          .then((value) {
            if (value != null){
              setState(() {
                saveHealthNote(value);
                getDays();
              });
            }
          });
        },
        tooltip: 'Add item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
