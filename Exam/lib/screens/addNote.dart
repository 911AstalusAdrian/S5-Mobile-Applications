import 'package:app/model/health.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final _formKey = GlobalKey<FormState>();
  final logger = Logger();
  late TextEditingController dateController;
  late TextEditingController symptomController;
  late TextEditingController medicationController;
  late TextEditingController dosageController;
  late TextEditingController doctorController;
  late TextEditingController notesController;


  @override
  void initState(){
    dateController = TextEditingController();
    symptomController = TextEditingController();
    medicationController = TextEditingController();
    dosageController = TextEditingController();
    doctorController = TextEditingController();
    notesController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {return "Please enter valid date"; }
                      return null;
                   },
                    controller: dateController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today, color: Colors.deepPurpleAccent),
                        hintText: "Pick a date"),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                    lastDate: DateTime(2025));
                if(pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {dateController.text = formattedDate;});
                }
                else {pickedDate = DateTime.now();}
              },
            )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {return "Please enter a valid symptom";}
                      return null;
                    },
                    controller: symptomController,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: 'Symptom'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {return "Please enter a valid dosage";}
                      return null;
                    },
                    controller: dosageController,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: 'Dosage'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {return "Please enter a valid medication";}
                      return null;
                    },
                    controller: medicationController,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: 'Medication'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {return "Please enter a valid doctor";}
                      return null;
                    },
                    controller: doctorController,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: 'Doctor'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {return "Please enter a valid note";}
                      return null;
                    },
                    controller: notesController,
                    maxLines: 1,
                    decoration: const InputDecoration(hintText: 'Notes'),
                  ),
                ),
                ElevatedButton(onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    final date = dateController.value.text;
                    final symptom = symptomController.value.text;
                    final dosage = dosageController.value.text;
                    final medication = medicationController.value.text;
                    final doctor = doctorController.value.text;
                    final notes = notesController.value.text;

                    final HealthNote hn = HealthNote(date: date, symptom: symptom, medication: medication, dosage: dosage, doctor: doctor, notes: notes);
                    Navigator.pop(context, hn);
                  }
                } , child: const Text("Save Note"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
