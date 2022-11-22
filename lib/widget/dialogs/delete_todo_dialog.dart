// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/todo_controller.dart';
import '../../pages/todos/home_page.dart';
import '../cards/card.dart';

class DeleteTodoDialog extends StatelessWidget {
  const DeleteTodoDialog({
    Key? key,
    required this.todoController,
    required this.widget,
  }) : super(key: key);

  final TodoController todoController;
  final CustomCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: AlertDialog(
        actions: [
          ElevatedButton(
            child: Text("Cancel".tr),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ElevatedButton(
            child: Text("delete".tr),
            onPressed: () {
              todoController.removeTodo(
                  widget.id, AuthController.instance.auth.currentUser!.uid);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )
        ],
        title: SvgPicture.asset(
          "assets/icons/warning.svg",
          height: 50,
          color: Colors.redAccent,
        ),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              Text(
                'Are you sure?'.tr,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Do you really want to delete these records? This process cannot be undone.'
                      .tr)
            ],
          ),
        ),
      ),
    );
  }
}
