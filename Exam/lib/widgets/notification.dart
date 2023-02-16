import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/health.dart';
import 'message.dart';

class Notifier extends StatelessWidget {
  final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:2302'));
  Notifier({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: (context, snapshot){
      SchedulerBinding.instance.addPersistentFrameCallback((_) {
        if (snapshot.hasData){
          var item = HealthNote.fromJson(jsonDecode(snapshot.data.toString()));
          message(context, item.toString(), "Item added");
        }
      });
      return const Text('');
    },
    stream: channel.stream.asBroadcastStream());
  }
}
