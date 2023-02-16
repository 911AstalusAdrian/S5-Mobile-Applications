import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionChecker{

  ConnectionChecker._();

  static final _instance = ConnectionChecker._();
  static ConnectionChecker get instance => _instance;

  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream.asBroadcastStream();


  void init() async {
    ConnectivityResult res = await _connectivity.checkConnectivity();
    _checkStatus(res);
    _connectivity.onConnectivityChanged.listen((event) {
      print(event);
      _checkStatus(event);
    });
  }

  void _checkStatus(ConnectivityResult r) async {
    bool online = false;
    try {
      final res = await InternetAddress.lookup('google.com');
      online = res.isNotEmpty && res[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) { online = false; }
    _controller.sink.add({r: online});
  }

  void disposeStream() => _controller.close();
}