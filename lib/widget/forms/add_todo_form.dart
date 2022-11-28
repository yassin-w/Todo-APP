// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, unnecessary_null_comparison, sort_child_properties_last, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/utils/validator/validator.dart';
import 'package:todo_app/widget/dialogs/map_dialog.dart';
import '../../controllers/auth_controller.dart';
import '../../pages/todos/home_page.dart';

import 'package:timezone/data/latest.dart' as tz;

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  File? img;
  LatLng locationPoint = LatLng(0.0, 0.0);

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  late SharedPreferences s_prefs;

  String name = '';
  String date = '';
  String description = '';

  _saveToShared_Preferences() async {
    s_prefs = await SharedPreferences.getInstance();
    s_prefs.setString("name", nameController.text.toString());
    s_prefs.setString("date", dateController.text.toString());
    s_prefs.setString("description", descriptionController.text.toString());
  }

  _showSavedValue() async {
    s_prefs = await SharedPreferences.getInstance();

    setState(() {
      name = s_prefs.getString("name").toString();
      description = s_prefs.getString("description").toString();
      date = s_prefs.getString("date").toString();
    });
  }

  _delete_Shared_Preferences() async {
    s_prefs = await SharedPreferences.getInstance();
    s_prefs.remove("name");
    s_prefs.remove("date");

    s_prefs.remove("description");

    setState(() {
      name = " ";
      date = '';
      description = '';
    });
  }


  void sendNotification(String token, String title, String body) async {
    var serverKey =
        'AAAA2Shp5Ks:APA91bHbjp1YrHAr5iwEbSEbVce24N1g08Fwqv5HRWM7Jvj12AyHRbpMf4DScNfJpRO2VS7ZnjFHEA77C-1GI_8hcQKKbwU9BxwAo4rJobyZvHz1xnnDHgtvPrPyFPo9-phVp5r1nZ2Y';



    try {

        http.Response response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': 'this is a body',
                'title': 'this is a title'
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done'
              },
              'to': token,
            },
          ),
        );
        print(response.statusCode) ;

    } catch (e) {
      print("error push notification");
    }
  }

  @override
  void initState() {
    super.initState();
    _showSavedValue();
    tz.initializeTimeZones();
  }

  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    TodoController todoController = Get.find();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    DateTime date = DateTime.now();
    String imageUrl = '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
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
                                          ImagePicker imagePicker =
                                              ImagePicker();
                                          XFile? file =
                                              (await imagePicker.pickImage(
                                                  source:
                                                      ImageSource.gallery))!;
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

                                            imageUrl =
                                                await referenceImageToUpload
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
                                          ImagePicker imagePicker =
                                              ImagePicker();
                                          XFile? file =
                                              await imagePicker.pickImage(
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
                                            imageUrl =
                                                await referenceImageToUpload
                                                    .getDownloadURL();
                                          } catch (error) {
                                            //Some error occurred
                                          }
                                        }),
                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: img != null
                        ? ClipOval(
                            child: Image.file(
                              img!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipOval(
                            child: Image.asset(
                              "assets/icons/chooseImg.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(66),
                    border: Border.all(
                      color: const Color.fromARGB(255, 158, 152, 235),
                    )),
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: Validators.validateSimpleString,
                  controller: nameController,
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(focus);
                  },
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
                child: TextFormField(
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
                  focusNode: focus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(focus);
                  },
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
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  _saveToShared_Preferences();
                  showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: Duration(milliseconds: 700),
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: MyLocationDialog(),
                        );
                      },
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position:
                              Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                  .animate(anim1),
                          child: child,
                        );
                      }).then((val) {
                    setState(() {
                      print("val");
                      locationPoint = val as LatLng;
                      print(locationPoint.latitude);
                    });
                  });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                ),
                child: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        "add location".tr,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AddSuccessfullyTodo();
                    //     });
                    var uid = AuthController.instance.auth.currentUser!.uid;
                    QuerySnapshot<Map<String, dynamic>> snap =
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('tokens')
                            .get();
                    print(
                        "******************************** snap here *************************************");
                    for (var item in snap.docs) {
                      print(item.id) ;
                      sendNotification(item.id, "title", "body") ;
                    }

                    todoController.addTodo(
                        nameController.text.trim(),
                        descriptionController.text.trim(),
                        DateFormat.yMMMd().format(date),
                        false,
                        imageUrl,
                        AuthController.instance.auth.currentUser!.uid,
                        locationPoint.latitude,
                        locationPoint.longitude);

                    await Future.delayed(Duration(seconds: 2));
                    /*NotificationService().showNotification(
                         1, "Todo Added", "Added successfully", 4);
                    */

                    _delete_Shared_Preferences();
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
        ),
      ),
    );
  }
}
