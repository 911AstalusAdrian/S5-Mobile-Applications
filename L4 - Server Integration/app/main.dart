import 'dart:convert';

import 'package:app/model/transfer.dart';
import 'package:app/screens/transfers_list_screen.dart';
import 'package:flutter/material.dart';
import 'server/helper.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TransfersList(),
      debugShowCheckedModeBanner: false,
    );
  }
}


