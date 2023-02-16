import 'package:flutter/material.dart';

message(BuildContext context, String message, String type){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(title: Text(type), content: Text(message));
  });
}