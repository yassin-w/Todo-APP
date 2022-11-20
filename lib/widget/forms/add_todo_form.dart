// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unnecessary_null_comparison

import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/utils/validator/validator.dart';
import '../../controllers/auth_controller.dart';
import '../../pages/todos/home_page.dart';
import '../dialogs/success_add_todo_dialog.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  File? img;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    TodoController todoController = Get.find();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    DateTime date = DateTime.now();
    String imageUrl = '';
    return Form(
      key: formKey,
      child: Column(
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
            height: 20,
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
            height: 20,
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
            height: 20,
          ),
          IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  child: SizedBox(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.photo),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "from Gallery",
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? file = (await imagePicker.pickImage(
                                        source: ImageSource.gallery))!;
                                    var imageTemporary = File(file.path);
                                    setState(() {
                                      img = imageTemporary;
                                    });

                                    if (file == null) return;
                                    Reference referenceRoot =
                                        FirebaseStorage.instance.ref();
                                    Reference referenceDirImages =
                                        referenceRoot.child('images');
                                    var number = Random().nextInt(100000);
                                    Reference referenceImageToUpload =
                                        referenceDirImages
                                            .child('name $number');

                                    try {
                                      //Store the file
                                      await referenceImageToUpload
                                          .putFile(File(file.path));
                                      //Success: get the download URL

                                      imageUrl = await referenceImageToUpload
                                          .getDownloadURL();
                                    } catch (error) {
                                      //Some error occurred
                                    }
                                  }),
                              Divider(),
                              ElevatedButton(
                                  child: SizedBox(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.camera_alt),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "from Camera",
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? file = await imagePicker.pickImage(
                                        source: ImageSource.camera);

                                    print('${file?.path}');
                                    var imageTemporary = File(file!.path);
                                    setState(() {
                                      img = imageTemporary;
                                    });
                                    if (file == null) return;
                                    Reference referenceRoot =
                                        FirebaseStorage.instance.ref();
                                    Reference referenceDirImages =
                                        referenceRoot.child('images');
                                    var number = Random().nextInt(100000);
                                    Reference referenceImageToUpload =
                                        referenceDirImages
                                            .child('name $number');

                                    try {
                                      //Store the file
                                      await referenceImageToUpload
                                          .putFile(File(file.path));
                                      //Success: get the download URL
                                      imageUrl = await referenceImageToUpload
                                          .getDownloadURL();
                                    } catch (error) {
                                      //Some error occurred
                                    }
                                  }),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.camera_alt)),
          SizedBox(
            height: 20,
          ),
          img != null
              ? ClipOval(
                  child: Image.file(
                    img!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
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
                    DateFormat.yMMMd().format(date),
                    false,
                    imageUrl,
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
    );
  }
}
