// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';
import 'package:todo_app/pages/home.dart';
import 'package:todo_app/pages/listtodos.dart';
import '../controllers/todoController.dart';
import '../utils/themes/theme_service.dart';
import '../wedgit/drawer.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    final todoController = Get.put(TodoController());
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        width: double.infinity,
        child: Form(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(66),
                        border: Border.all(
                          color: Color.fromARGB(255, 158, 152, 235),
                        )),
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "ToDo Name".tr, border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(66),
                        border: Border.all(
                          color: Color.fromARGB(255, 158, 152, 235),
                        )),
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          hintText: "Todo Description".tr,
                          hintStyle: TextStyle(),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(66),
                        border: Border.all(
                          color: Color.fromARGB(255, 158, 152, 235),
                        )),
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                          hintText: "Date".tr,
                          hintStyle: TextStyle(),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      todoController.addTodo(
                          nameController.text.trim(),
                          descriptionController.text.trim(),
                          dateController.text.trim(),
                          false,
                          AuthController.instance.auth.currentUser!.uid);
                      Get.to(HomePage());
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27))),
                    ),
                    child: Text(
                      "Add".tr,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
