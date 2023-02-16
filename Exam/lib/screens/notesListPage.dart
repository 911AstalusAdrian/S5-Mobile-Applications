import 'package:app/helpers/connectionCheck.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../helpers/dbHelper.dart';
import '../helpers/serverHelper.dart';
import '../model/health.dart';
import '../widgets/message.dart';

class NotesListPage extends StatefulWidget {
  final String _date;
  const NotesListPage(this._date, {super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  
  var logger = Logger();
  bool online = true;
  late List<HealthNote> notes = [];
  bool loading = false;
  Map _source = {ConnectivityResult.none : false};
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
      }
      getNotesByDate();
    });
  }

  getNotesByDate() async {
    if (!mounted) return;
    setState(() { loading = true; });
    try{
      if(online){
        notes = await ServerHelper.instance.getSymptomsByDate(widget._date);
        await DbHelper.updateDateNotes(widget._date, notes);
      } else {
        notes = await DbHelper.getNotesByDate(widget._date);
      }
    } catch (e) {
      logger.e(e);
      message(context, "Error getting data from server", "Error");
      notes = await DbHelper.getNotesByDate(widget._date);
    }
    setState(() { loading = false; });
  }

  deleteNote(HealthNote hn) async{
    if (!mounted) return;
    setState(() { loading = true; });
    try{
      if(online){
        setState(() {
          ServerHelper.instance.deleteHealthEntry(hn.id!);
          DbHelper.deleteNote(hn.id!);
          notes.remove(hn);
          Navigator.pop(context);
        });
      }
    } catch(e){
      logger.e(e);
      message(context, "Error removing note from server", "Error");
    }
    setState(() { loading = false; });
  }

  removeNote(BuildContext context, int id){
    showDialog(context: context,
        builder: ((context) => AlertDialog(
          title: const Text("Delete Health Note?"),
          content: const Text("Are you sure you want to delete this Note?"),
          actions: [
            TextButton(onPressed: () {Navigator.of(context).pop();}, child: const Text("Cancel")),
            TextButton(onPressed: () {
              deleteNote(notes.firstWhere((element) => element.id == id));
              }, child: const Text("Delete"))
          ],
        )));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget._date} | Notes"),
      ),
      body: loading
      ? const Center(child: CircularProgressIndicator())
      : Center(
        child: ListView(
        children: [
          ListView.builder(itemBuilder: ((context, index) {
            return ListTile(
              title: Text(notes[index].symptom),
              subtitle: Text("${notes[index].doctor}: ${notes[index].dosage} ${notes[index].medication} ${notes[index].notes}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () { removeNote(context, notes[index].id!);},
                color: Colors.red
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.grey, width: 1.0)
              ),
            );
    }),
          itemCount: notes.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10.0),)
    ],
    )
    )
    );
  }
}
