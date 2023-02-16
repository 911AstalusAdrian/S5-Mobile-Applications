import 'package:app/helpers/connectionCheck.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../helpers/serverHelper.dart';
import '../widgets/message.dart';

class ProgressSection extends StatefulWidget {
  const ProgressSection({Key? key}) : super(key: key);

  @override
  State<ProgressSection> createState() => _ProgressSectionState();
}

class _ProgressSectionState extends State<ProgressSection> {

  var logger = Logger();
  bool online = true;
  late Map<String, int> symptomsEachMonth = <String, int>{};
  bool isLoading = false;
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
      getList();
    });
  }
  
  getList() async {
    if (!mounted) return;
    setState(() {isLoading = true;});
    logger.log(Level.info, "Get symptoms progress");
    try{
      if(online){
        symptomsEachMonth = await ServerHelper.instance.getSymptomsForEachMonth();
      } else{
        message(context, "No internet connection", "Error");
      }
    } catch(e){
      logger.log(Level.error, e.toString());
      message(context, "No internet connection", "Error");
    }
    setState(() {isLoading = false;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Symptoms for each month"),
      ),
      body: isLoading
      ? const Center(child:  CircularProgressIndicator())
      : Center(
        child: ListView(
          children: [
            ListView.builder(itemBuilder: ((context, index) {
              return ListTile(
                title: Text("Month - ${symptomsEachMonth.keys.elementAt(index)} | Symptoms - ${symptomsEachMonth.values.elementAt(index)}")
              );
            }
            ),
            itemCount: symptomsEachMonth.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10),)
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }
}
