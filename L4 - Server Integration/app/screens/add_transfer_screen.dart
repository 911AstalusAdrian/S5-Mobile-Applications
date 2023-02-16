import 'package:app/server/helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../model/transfer.dart';

class AddTransferScreen extends StatelessWidget {
  AddTransferScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final typeController = TextEditingController();
    final categoryController = TextEditingController();
    final sumController = TextEditingController();
    final dateController = TextEditingController();
    final logger = Logger();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Transfer"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty) {return "Please enter a valid title";}
                        return null;
                      },
                      controller: titleController,
                      maxLines: 1,
                      decoration: const InputDecoration(hintText: 'Title'))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty) {return "Please enter a valid description";}
                        return null;
                      },
                      controller: descriptionController,
                      maxLines: 1,
                      decoration: const InputDecoration(hintText: 'Description'))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty) {return "Please enter a valid type";}
                        return null;
                      },
                      controller: typeController,
                      maxLines: 1,
                      decoration: const InputDecoration(hintText: 'Type'))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty) {return "Please enter a valid category";}
                        return null;
                      },
                      controller: categoryController,
                      maxLines: 1,
                      decoration: const InputDecoration(hintText: 'Category'))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                      validator: (value) {
                        if(value == null || value.isEmpty) {return "Please enter a valid sum";}
                        return null;
                      },
                      controller: sumController,
                      maxLines: 1,
                      decoration: const InputDecoration(hintText: 'Sum'))),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty) {return "Please enter a valid date";}
                      return null;
                    },
                    controller: dateController,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: 'Date'),
                  )),
              ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      final title = titleController.value.text;
                      final desc = descriptionController.value.text;
                      final type = typeController.value.text;
                      final category = categoryController.value.text;
                      final sum = int.parse(sumController.value.text);
                      final date = dateController.value.text;

                      final Transaction tran = Transaction(title: title, desc: desc, type: type, category: category, sum: sum, date: date);
                      ServerHelper.addTransaction(tran);
                      logger.i("A transaction has been added");
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"))
            ],
          ),
        )),
      ),
    );
  }
}
