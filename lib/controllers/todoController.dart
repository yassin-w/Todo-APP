// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, prefer_collection_literals
import 'package:get/state_manager.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  RxList tasks = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetch_todos();
  }

  void fetch_todos() async {
    await Future.delayed(Duration(seconds: 1));
    var todoResult = [
      ToDo(
          name: 'everyday',
          description: "Do something nice for someone ",
          date: "1-12-2022",
          isComplete: false),
      ToDo(
          name: 'fifty states',
          description: "Memorize the fifty states ",
          date: "1-11-2022",
          isComplete: false),
      ToDo(
          name: 'GOT',
          description: "Watch a GOT ",
          date: "1-10-2022",
          isComplete: true),
      ToDo(
          name: 'football scrimmage',
          description: "Have a football scrimmage ",
          date: "1-9-2022",
          isComplete: true)
    ];

    tasks.value = todoResult;
  }

  void addTodo(ToDo item) {
    tasks.add(item);
  }

  void removeTodo(ToDo item) {
    tasks.remove(item);
  }
}
