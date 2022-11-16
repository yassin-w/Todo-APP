// ignore_for_file: prefer_const_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final todoController = Get.put(TodoController());
    const moonIcon = CupertinoIcons.moon_stars;
    String filterValue = "filterValue";
    String name = '';
    return GetBuilder<TodoController>(
        init: TodoController(),
        initState: (_) {},
        builder: (todoController) {
          todoController.getData(AuthController.instance.auth.currentUser!.uid);

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
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
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
          );
        });
  }
}
