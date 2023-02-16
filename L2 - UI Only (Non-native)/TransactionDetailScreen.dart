
import 'package:flutter/material.dart';
import 'Transaction.dart';

class TransactionDetailScreen extends StatelessWidget{
  TransactionDetailScreen({super.key, required this.transaction});

  final Transaction transaction; // we get the ID correctly
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context){
    String titleValue = transaction.title;
    String descValue = transaction.desc;
    String typeValue = transaction.type;
    String catValue = transaction.category;
    String sumValue = transaction.sum;
    String dateValue = transaction.date;
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
              decoration: InputDecoration( hintText: "Transaction ID: ${transaction.id}" ),
              enabled: false,
            ),
            TextFormField(
              initialValue: transaction.title,
              validator: (value) {
                if (value == null || value.isEmpty) { return "Please enter some text"; }
                return null;
              },
              onChanged: (value) =>  titleValue = value
            ),
            TextFormField(
              initialValue: transaction.desc,
              validator: (value) {
                if (value == null || value.isEmpty) { return "Please enter some text"; }
                return null;
              },
              onChanged: (value) =>  descValue = value
            ),
            TextFormField(
              initialValue: transaction.type,
              validator: (value) {
                if (value == null || value.isEmpty) { return "Please enter some text"; }
                return null;
              },
              onChanged: (value) =>  typeValue = value
            ),
            TextFormField(
              initialValue: transaction.category,
              validator: (value) {
                if (value == null || value.isEmpty) { return "Please enter some text"; }
                return null;
              },
              onChanged: (value) =>  catValue = value
            ),
            TextFormField(
              initialValue: transaction.sum,
              validator: (value) {
                if (value == null || value.isEmpty) { return "Please enter some text"; }
                return null;
              },
              onChanged: (value) =>  sumValue = value
            ),
            TextFormField(
              initialValue: transaction.date,
              validator: (value) {
                if (value == null || value.isEmpty) { return "Please enter some text"; }
                return null;
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.green,
              ),
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  final data = {"action": "edit", "item": Transaction(transaction.id, titleValue, descValue, typeValue, catValue, sumValue, dateValue)};
                  Navigator.pop(context, data);
                }
              },
              child: const Text("Update Transaction"),
          ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.red
              ),
                onPressed: () {
                final data = {"action": "delete", "item": transaction.id};
                
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text("Are you sure you want to delete this transaction?"),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context,data);
                      }, child: const Text("yes")),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("no"),
                      )
                    ],
                  )
                );
                },
                child: const Text("Delete Transaction"))
          ],
        ),
      )
      )
    );
  }

}