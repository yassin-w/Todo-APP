// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';
import 'package:todo_app/pages/home.dart';
import 'package:todo_app/pages/listtodos.dart';
import '../controllers/todoController.dart';

class CustomCard extends StatefulWidget {
  String id;
  String name;
  String description;
  String date;
  bool isComplete;
  CustomCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.isComplete})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomCardComp();
}

class _CustomCardComp extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final todoController = Get.put(TodoController());

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: SizedBox(
        width: 350,
        height: 165,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.name}",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    textWidthBasis: TextWidthBasis.longestLine,
                  ),
                  IconButton(
                      onPressed: () {
                        todoController.removeTodo(widget.id,
                            AuthController.instance.auth.currentUser!.uid);
                        Get.to(HomePage());
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    " ${widget.description}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${widget.date}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 201, 201, 202),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Switch(
                      value: widget.isComplete,
                      onChanged: (value) {
                        setState(() {
                          widget.isComplete = value;
                        });
                      }),
                ],
              ),
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}
