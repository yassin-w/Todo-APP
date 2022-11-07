// ignore_for_file: prefer_const_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../card.dart';
import '../controllers/authController.dart';
import '../controllers/todoController.dart';
import '../models/todo.dart';
import 'package:get/get.dart';

import 'add_todo.dart';

class ListTodos extends StatefulWidget {
  ListTodos({super.key});

  @override
  State<ListTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
  @override
  Widget build(BuildContext context) {
    final todoController = Get.put(TodoController());

    String filterValue = "filterValue";
    return GetBuilder<TodoController>(
        init: TodoController(),
        initState: (_) {},
        builder: (todoController) {
          todoController.getData(AuthController.instance.auth.currentUser!.uid);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "ToDo App",
                style: TextStyle(fontSize: 28, color: Color(0xffFFECEF)),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      AuthController.instance.logout();
                    },
                    icon: Icon(Icons.logout))
              ],
              backgroundColor: Color(0xff3d2e58),
              centerTitle: true,
            ),
            body: Center(
              child: Container(
                color: Color.fromARGB(255, 221, 212, 231),
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
                          width: 200,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.purple[800],
                                ),
                                hintText: "search :",
                                hintStyle: TextStyle(color: Colors.purple[300]),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                            width: 100,
                            child: GetX<TodoController>(builder: (controller) {
                              return DropdownButton<ToDo>(
                                hint: Text(
                                  "Filter",
                                  style: TextStyle(color: Colors.purple[300]),
                                ),

                                // borderRadius: BorderRadius,
                                isExpanded: true,
                                style: const TextStyle(
                                  // decoration: InputDecoration(border: OutlineInputBorder()),
                                  // decoration: ,
                                  color: Colors.indigo,
                                ),
                                items: controller.tasks.map((value) {
                                  //Here is the list
                                  return DropdownMenuItem<ToDo>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                                onChanged: (value) => filterValue =
                                    value!.name, //Here saves the value
                              );
                            })),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: GetX<TodoController>(
                        builder: (controller) {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.tasks.length,
                              itemBuilder: (context, index) {
                                return CustomCard(
                                    id: controller.tasks[index].id,
                                    name: controller.tasks[index].name,
                                    description:
                                        controller.tasks[index].description,
                                    date: controller.tasks[index].date,
                                    isComplete:
                                        controller.tasks[index].isComplete);
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.home),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.purple[100]),
                    ),
                    label: Text(
                      "Home ",
                      style: TextStyle(fontSize: 20, color: Colors.purple),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(AddTodo());
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.purple[100]),
                    ),
                    icon: Icon(Icons.add_task),
                    label: Text(
                      "add task",
                      style: TextStyle(fontSize: 20, color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
