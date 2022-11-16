// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/utils/validator/validator.dart';

import '../../controllers/auth_controller.dart';
import '../../pages/todos/home_page.dart';
import '../dialogs/success_add_todo_dialog.dart';

class AddTodoForm extends StatelessWidget {
  const AddTodoForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    TodoController todoController = Get.find();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    DateTime date = DateTime.now();
    TextEditingController dateController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(66),
                    border: Border.all(
                      color: const Color.fromARGB(255, 158, 152, 235),
                    )),
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  validator: Validators.validateSimpleString,
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "ToDo Name".tr, border: InputBorder.none),
                ),
              ),
              const SizedBox(
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
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddSuccessfullyTodo();
                        });

                    todoController.addTodo(
                        nameController.text.trim(),
                        descriptionController.text.trim(),
                        dateController.text.trim(),
                        false,
                        AuthController.instance.auth.currentUser!.uid);
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
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
    );
  }
}
