// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_collection_literals, no_leading_underscores_for_local_identifiers, avoid_print, unnecessary_overrides, unnecessary_string_interpolations, file_names, library_prefixes
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as Firebase_Storage;

import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  Rx<List<Todo>> tasks = Rx<List<Todo>>([]);
  List<Todo> get todos => tasks.value;
  String uid = AuthController.instance.auth.currentUser!.uid;
  RxList tasksByName = [].obs;
  RxList complete_tasks = [].obs;

  final Firebase_Storage.FirebaseStorage storage =
      Firebase_Storage.FirebaseStorage.instance;
  @override
  void onInit() async {
    getData(uid);

    super.onInit();
  }

  Future<void> addTodo(
      String name,
      String description,
      String date,
      bool isComplete,
      String image,
      String uid,
      double lat,
      double long) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .add({
          'name': name,
          'description': description,
          'date': date,
          'isComplete': isComplete,
          'userId': uid,
          'dateCreated': Timestamp.now(),
          'image': image,
          'latitude': lat,
          'longitude': long
        })
        .then((value) => print("todo data added "))
        .catchError((error) => print("can not add"));
  }

  Future<void> getCompleteTodos(String uid) async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('todos')
          .where('isComplete', isEqualTo: true)
          .get();
      print(_taskSnap.docs.length);
      complete_tasks.clear();

      for (var item in _taskSnap.docs) {
        complete_tasks.add(
          Todo(
              id: item.id,
              name: item['name'],
              description: item['description'],
              date: item['date'],
              isComplete: item['isComplete'],
              userId: item['userId'],
              dateCreated: item['dateCreated'],
              lat: item['latitude'],
              long: item['longitude']),
        );
      }
      update();
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}');
      print(e.toString());
    }
  }

  //*************filter by name ************************ */

  // *************get complete tasks ***********************

  Future<void> getData(String uid) async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('todos')
          .orderBy('dateCreated')
          .get();
      todos.clear();
      for (var item in _taskSnap.docs) {
        todos.add(
          Todo(
              id: item.id,
              name: item['name'],
              description: item['description'],
              date: item['date'],
              isComplete: item['isComplete'],
              userId: item['userId'],
              dateCreated: item['dateCreated'],
              lat: item['latitude'],
              long: item['longitude']),
        );
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  //**************************** delete by todo document id ******************************* */
  void removeTodo(String id, String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(id)
        .delete();
  }

  /// ******************* change the status of todo (done or not ) *****************/
  void changeStatus(String id, String uid, bool status) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(id)
        .update({'isComplete': status});
  }

  /// ***************update todo *************************************** */

  Future<void> UpdateTodo(String name, String description, String date,
      bool isComplete, String uid, String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('todos')
        .doc(id)
        .update({
          'name': name,
          'description': description,
          'date': date,
        })
        .then((value) => print("todo data UPDATED "))
        .catchError((error) => print("can not UPDATED"));
  }
}
