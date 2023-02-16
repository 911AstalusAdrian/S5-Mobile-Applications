import 'package:flutter/material.dart';
import '../model/transfer.dart';

class TransferDetailsWidget extends StatelessWidget {

  final Transaction transfer;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController typeController;
  final TextEditingController categoryController;
  final TextEditingController sumController;
  final TextEditingController dateController;

  const TransferDetailsWidget({Key? key,
    required this.transfer,
    required this.titleController,
    required this.descriptionController,
    required this.typeController,
    required this.categoryController,
    required this.sumController,
    required this.dateController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            decoration: const InputDecoration(hintText: 'Title'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            validator: (value) {
              if(value == null || value.isEmpty) {return "Please enter a valid description";}
              return null;
            },
            controller: descriptionController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Description"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            validator: (value) {
              if(value == null || value.isEmpty) {return "Please enter a valid type"; }
              return null;
            },
            controller: typeController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Type"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            validator: (value) {
              if(value == null || value.isEmpty) {return "Please enter a valid category";}
              return null;
            },
            controller: categoryController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Category"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            validator: (value) {
              if(value == null || value.isEmpty) {return "Please enter a valid sum";}
              return null;
            },
            controller: sumController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Sum"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            validator: (value) {
              if(value == null || value.isEmpty) {return "Please enter a valid date";}
              return null;
            },
            controller: dateController,
            maxLines: 1,
            decoration: const InputDecoration(hintText: "Date"),
          ),
        ),
      ],
    );
  }
}
