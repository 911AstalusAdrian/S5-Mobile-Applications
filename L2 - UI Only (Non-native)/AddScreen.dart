
import 'package:flutter/material.dart';
import 'package:secondapp/Transaction.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key, required this.transactionId});

  final String transactionId; // we get the ID correctly
  final _formKey = GlobalKey<FormState>();

  String titleValue = "";
  String descValue = "";
  String typeValue = "";
  String catValue = "";
  String sumValue = "";
  String dateValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Transactions Manager App"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  TextFormField(
                    decoration: InputDecoration( hintText: "Transaction ID: $transactionId" ),
                    enabled: false,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) { return "Please enter some text"; }
                        return null;
                      },
                      decoration: const InputDecoration( hintText: "Title"),
                      onChanged: (value) =>  titleValue = value
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) { return "Please enter some text"; }
                        return null;
                      },
                      decoration: const InputDecoration( hintText: "Description"),
                      onChanged: (value) =>  descValue = value
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) { return "Please enter some text"; }
                        return null;
                      },
                      decoration: const InputDecoration( hintText: "Type"),
                      onChanged: (value) =>  typeValue = value
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) { return "Please enter some text"; }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Category"),
                      onChanged: (value) =>  catValue = value
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) { return "Please enter some text"; }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Sum"),
                      onChanged: (value) =>  sumValue = value
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) { return "Please enter some text"; }
                      return null;
                    },              decoration: const InputDecoration(hintText: "Date"),
                    onChanged: (value) =>  dateValue = value,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.green,
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        Transaction t = Transaction(transactionId, titleValue, descValue, typeValue, catValue, sumValue, dateValue);
                        Navigator.pop(context, t);
                      }
                    },
                    child: const Text("Add Transaction"),
                  )
                ],
              ),
            )
        )
    );
  }
}
