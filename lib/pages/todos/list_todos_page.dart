// ignore_for_file: prefer_const_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../models/todo_model.dart';
import '../../widget/cards/card.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/todo_controller.dart';
import 'package:get/get.dart';

class ListTodos extends StatefulWidget {
  ListTodos({super.key});

  @override
  State<ListTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
  List<Todo> todos = [];
  List<Todo> finalRes = [];
  final controller = TextEditingController();
  final todoController = Get.put(TodoController());

  @override
  void initState() {
    TodoController();
    todoController.getData(AuthController.instance.auth.currentUser!.uid);
    todos = todoController.todos;
    print("_________________________________________");
    print(todos.length);
    finalRes = todos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
        init: TodoController(),
        initState: (_) {},
        builder: (todoController) {
          ///  todos = todoController.todos;
          return Scaffold(
            body: Center(
              child: Container(
                //  width: double.infinity,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 300,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: controller,
                              onChanged: _SearchTodo,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.search,
                                ),
                                hintText: "search :".tr,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: finalRes.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                              id: finalRes[index].id,
                              name: finalRes[index].name,
                              description: finalRes[index].description,
                              date: finalRes[index].date,
                              isComplete: finalRes[index].isComplete);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _SearchTodo(String todoName) {
    List<Todo> result = [];
    if (todoName == '') {
      result = todos;
    } else {
      result = todos.where((todo) {
        final todoName = todo.name.toLowerCase();
        final input = todoName.toLowerCase();
        return todoName.contains(input);
      }).toList();
    }

    setState(() {
      finalRes = result;
    });
  }
}
