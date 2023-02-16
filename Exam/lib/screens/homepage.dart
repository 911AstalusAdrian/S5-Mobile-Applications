import 'package:app/helpers/connectionCheck.dart';
import 'package:app/screens/topSection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../widgets/message.dart';
import '../screens/mainSection.dart';
import '../screens/progressSection.dart';

class Homepage extends StatefulWidget {

  final String _screenTitle;
  const Homepage(this. _screenTitle, {super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final channel = WebSocketChannel.connect(Uri.parse("ws://10.0.2.2:2302"));
  var logger = Logger();
  bool online = true;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._screenTitle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Main Section'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MainSection()));
              },
            ),
            ElevatedButton(
              child: const Text('Progress Section'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProgressSection()));
              },
            ),
            ElevatedButton(
              child: const Text('Top Section'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TopSection()));
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    _connectivity.disposeStream();
    super.dispose();
  }
}
