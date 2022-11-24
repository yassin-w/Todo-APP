// ignore_for_file: non_constant_identifier_names, unnecessary_this, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String id;
  String name;
  String description;
  String date;
  Timestamp dateCreated;
  String image;
  bool isComplete;
  String userId;
  double lat;
  double long;

  // ToDo(
  //     {required this.id,
  //     required this.name,
  //     required this.description,
  //     required this.date,
  //     required this.isComplete,
  //     required this.userId});

  TodoModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.dateCreated,
      required this.isComplete,
      required this.image,
      required this.userId,
      required this.lat,
      required this.long});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'date': this.date,
      'dateCreated': this.dateCreated,
      'isComplete': this.isComplete,
      'userId': this.userId,
      'lat': this.lat,
      'long': this.long,
    };
  }
}
