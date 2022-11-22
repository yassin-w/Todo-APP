// ignore_for_file: unused_field, unnecessary_overrides, prefer_const_constructors, unused_element, file_names, avoid_print, unnecessary_null_comparison
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/authentication/login_page.dart';
import 'package:todo_app/pages/todos/home_page.dart';

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

  //* *********** check login status called in splash screen ********/
  _intialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => Login());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      } else {
        error = e.message!;
      }
      Get.snackbar("about user ", "message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            "Account creation faild",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            error,
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String error = '';
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      } else if (e.code == 'network-request-failed') {
        error = 'check your internet connection.';
      } else {
        error = e.message!;
      }

      Get.snackbar("about login ", "message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            "login faild",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            error,
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
