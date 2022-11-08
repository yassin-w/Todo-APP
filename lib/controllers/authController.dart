// ignore_for_file: unused_field, unnecessary_overrides, prefer_const_constructors, unused_element, file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/listtodos.dart';
import 'package:todo_app/pages/login.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _intialScreen);
  }

  _intialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => Login());
    } else {
      Get.offAll(() => ListTodos());
    }
  }

  void register(String email, String password) {
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("about user ", "message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account creation faild",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void login(String email, String password) {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("about login ", "message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "login faild",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
