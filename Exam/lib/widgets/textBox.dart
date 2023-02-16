import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final TextEditingController _ctrl;
  final String _label;

  const TextBox(this._ctrl, this._label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: _ctrl,
        decoration: InputDecoration(
          filled: true,
          labelText: _label,
          suffix: GestureDetector(
            child: const Icon(Icons.close),
            onTap: () {_ctrl.clear();},
          )
        )
      ),);
  }
}
