// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widget/dialogs/success_update_todo_dialog.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/todo_controller.dart';
import '../../pages/todos/home_page.dart';
import '../cards/card.dart';

class UpdateTodoDialog extends StatelessWidget {
  const UpdateTodoDialog({
    Key? key,
    required this.todoController,
    required this.widget,
  }) : super(key: key);

  final TodoController todoController;
  final CustomCard widget;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.name);
    TextEditingController descriptionController =
        TextEditingController(text: widget.description);
    TodoController todoController = Get.find();
    DateTime date = DateFormat.yMMMd().parse(widget.date);
    TextEditingController dateController =
        TextEditingController(text: widget.date);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: AlertDialog(
        actions: [
          ElevatedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
        title: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/update.svg",
              height: 50,
              color: Color.fromARGB(255, 9, 207, 59),
            ),
            SizedBox(
              height: 20,
            ),
            Text('todo information')
          ],
        ),
        content: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(66),
                    border: Border.all(
                      color: Color.fromARGB(255, 129, 128, 145),
                    )),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "ToDo Name".tr, border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(66),
                    border: Border.all(
                      color: Color.fromARGB(255, 129, 128, 145),
                    )),
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
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(66),
                    border: Border.all(
                      color: Color.fromARGB(255, 158, 152, 235),
                    )),
                width: 250,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                      hintText: "todo date".tr,
                      hintStyle: TextStyle(),
                      border: InputBorder.none),
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2022),
                        maxTime: DateTime(2030), onChanged: (value) {
                      date = value;
                      dateController.text = DateFormat.yMMMd().format(value);
                    }, onConfirm: (value) {
                      date = value;
                      dateController.text = DateFormat.yMMMd().format(value);
                    }, currentTime: date, locale: LocaleType.en);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return UpdateSuccessDialog();
                      });

                  todoController.UpdateTodo(
                      nameController.text.trim(),
                      descriptionController.text.trim(),
                      DateFormat.yMMMd().format(date),
                      false,
                      AuthController.instance.auth.currentUser!.uid,
                      widget.id);
                  await Future.delayed(Duration(seconds: 2));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27))),
                ),
                child: Text(
                  "update".tr,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
