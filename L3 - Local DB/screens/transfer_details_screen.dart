import 'package:assignment_4/model/transfer.dart';
import 'package:assignment_4/services/db_helper.dart';
import 'package:assignment_4/widgets/transfer_details_widget.dart';
import 'package:flutter/material.dart';

class TransferDetailsScreen extends StatelessWidget {

  final Transfer transfer;

  TransferDetailsScreen({Key? key, required this.transfer}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final titleController = TextEditingController(text: transfer.title);
    final descriptionController = TextEditingController(text: transfer.desc);
    final typeController = TextEditingController(text: transfer.type);
    final categoryController = TextEditingController(text: transfer.category);
    final sumController = TextEditingController(text: transfer.sum.toString());
    final dateController = TextEditingController(text: transfer.date);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Modify a Transaction"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TransferDetailsWidget(transfer: transfer,
                    titleController: titleController,
                    descriptionController: descriptionController,
                    typeController: typeController,
                    categoryController: categoryController,
                    sumController: sumController,
                    dateController: dateController),
                ElevatedButton(onPressed: () async {
                  Transfer newTran = Transfer(id: transfer.id,
                      title: titleController.value.text,
                      desc: descriptionController.value.text,
                      type: typeController.value.text,
                      category: categoryController.value.text,
                      sum: int.parse(sumController.value.text),
                      date: dateController.value.text);
                  await DatabaseHelper.updateTransfer(newTran);
                  Navigator.pop(context);
                },
                    child: const Text("Edit Transaction")), // Edit Button
                ElevatedButton(onPressed: () async {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: const Text("Are you sure you want to remove this Transaction?"),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            await DatabaseHelper.deleteTransfer(transfer.id!);
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          child: const Text("Yes"),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("No"),
                        )
                      ],
                    );
                  });
                },
                    child: const Text("Delete Transaction")), // Delete Button
              ],
            )
          )
        ),
      )
    );
  }
}
