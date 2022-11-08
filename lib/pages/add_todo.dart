// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';
import 'package:todo_app/pages/listtodos.dart';
import '../controllers/todoController.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(fontSize: 28, color: Color(0xffFFECEF)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff3d2e58),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        color: Color.fromARGB(255, 255, 255, 255),
        width: double.infinity,
        child: Form(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(66),
                    ),
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "ToDo Name",
                          hintStyle: TextStyle(
                            color: Colors.purple[800],
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(66),
                    ),
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(
                            color: Colors.purple[800],
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(66),
                    ),
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                          hintText: "Date",
                          hintStyle: TextStyle(
                            color: Colors.purple[800],
                          ),
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
                      Get.to(ListTodos());
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffFFCACA)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27))),
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: 20, color: Color(0xff251B37)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Get.to(ListTodos());
              },
              icon: Icon(Icons.home),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple[100]),
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
                backgroundColor: MaterialStateProperty.all(Colors.purple[100]),
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
  }
}
