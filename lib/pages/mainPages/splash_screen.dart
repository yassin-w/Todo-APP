// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, file_names, prefer_interpolation_to_compose_strings, unused_field, non_constant_identifier_names


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Future<void> initializeSettings() async {
    await Firebase.initializeApp().then((value) => Get.put(AuthController()));
    await Future.delayed(Duration(seconds: 10));
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        return waitingView();
      },
    );
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
        body: Container(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
            ),
            Image.asset(
              "assets/images/todo.png",
              width: 150,
            ),
          ],
        ),
      ),
    ));
  }
}
