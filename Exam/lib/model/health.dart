import 'package:flutter/material.dart';

class HealthNote{
  int? id;
  String date;
  String symptom;
  String medication;
  String dosage;
  String doctor;
  String notes;

  HealthNote({
    this.id,
    required this.date,
    required this.symptom,
    required this.medication,
    required this.dosage,
    required this.doctor,
    required this.notes,
  });

  factory HealthNote.fromJson(Map<String, dynamic> json){
    return HealthNote(
      id: json['id'] as int?,
      date: json['date'] as String,
      symptom: json['symptom'] as String,
      medication: json['medication'] as String,
      dosage: json['dosage'] as String,
      doctor: json['doctor'] as String,
      notes: json['notes'] as String,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'date': date,
      'symptom': symptom,
      'medication': medication,
      'dosage': dosage,
      'doctor': doctor,
      'notes': notes,
    };
  }

  Map<String, dynamic> toJsonNoId(){
    return{
      'date': date,
      'symptom': symptom,
      'medication': medication,
      'dosage': dosage,
      'doctor': doctor,
      'notes': notes,
    };
  }

  HealthNote copy({
    int? id,
    String? date,
    String? symptom,
    String? medication,
    String? dosage,
    String? doctor,
    String? notes}){
    return HealthNote(
        id: id ?? this.id,
        date: date ?? this.date,
        symptom: symptom ?? this.symptom,
        medication: medication ?? this.medication,
        dosage: dosage ?? this.dosage,
        doctor: doctor ?? this.doctor,
        notes: notes ?? this.notes);
  }

  @override
  String toString() {
    return "Health Note{date - $date | symptom - $symptom | medication - $medication | dosage - $dosage | doctor - $doctor | notes - $notes}";
  }
}