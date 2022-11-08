// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/listtodos.dart';

import 'login.dart';
import '../auth/AuthenticationManager.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.find();

    return Obx(() {
      return _authManager.isLogged.value ? ListTodos() : Login();
    });
  }
}
