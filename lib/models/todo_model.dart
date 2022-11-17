// ignore_for_file: non_constant_identifier_names, unnecessary_this, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String name;
  String description;
  String date;
  Timestamp dateCreated;
  bool isComplete;
  String userId;

  // ToDo(
  //     {required this.id,
  //     required this.name,
  //     required this.description,
  //     required this.date,
  //     required this.isComplete,
  //     required this.userId});

  Todo(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.dateCreated,
      required this.isComplete,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'date': this.date,
      'dateCreated': this.dateCreated,
      'isComplete': this.isComplete,
      'userId': this.userId,
    };
  }
}
