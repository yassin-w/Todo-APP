// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_collection_literals, no_leading_underscores_for_local_identifiers, avoid_print, unnecessary_overrides, unnecessary_string_interpolations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  RxList tasks = [].obs;
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');

  // void fetch_todos() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   var todoResult = [
  //     ToDo(
  //         name: 'everyday',
  //         description: "Do something nice for someone ",
  //         date: "1-12-2022",
  //         isComplete: false),
  //     ToDo(
  //         name: 'fifty states',
  //         description: "Memorize the fifty states ",
  //         date: "1-11-2022",
  //         isComplete: false),
  //     ToDo(
  //         name: 'GOT',
  //         description: "Watch a GOT ",
  //         date: "1-10-2022",
  //         isComplete: true),
  //     ToDo(
  //         name: 'football scrimmage',
  //         description: "Have a football scrimmage ",
  //         date: "1-9-2022",
  //         isComplete: true)
  //   ];

  //   tasks.value = todoResult;
  // }

  Future<void> addTodo(
      String name, String description, String date, bool isComplete) async {
    return todos
        .add({
          'name': name,
          'description': description,
          'date': date,
          'isComplete': isComplete
        })
        .then((value) => print("todo data added "))
        .catchError((error) => print("can not add"));
  }

  Future<void> getData() async {
    print("***************************************************");

    try {
      QuerySnapshot _taskSnap =
          await FirebaseFirestore.instance.collection('todos').get();
      print(_taskSnap.docs.length);
      tasks.clear();

      for (var item in _taskSnap.docs) {
        tasks.add(
          ToDo(
              id: item.id,
              name: item['name'],
              description: item['description'],
              date: item['date'],
              isComplete: item['isComplete']),
        );
      }
      update();
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}');
      ;
    }
    print("**************** tasks *************************");

    print(tasks.length);
  }

  void removeTodo(String id) {
    FirebaseFirestore.instance.collection('todos').doc(id).delete();
  }
}
