// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/authentication/signup_page.dart';

import '../../widget/components/drawer.dart';
import '../../widget/forms/login_form.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Drawer(
          child: DrawerComp(),
        ),
        appBar: AppBar(
          title: Text(
            "ToDo App",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox(

          width: double.infinity,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Log in".tr,
                  style: TextStyle(fontSize: 33, fontFamily: "myfont"),
                ),
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  width: 288,
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginForm(),
                const SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an accout?".tr),
                    GestureDetector(
                        onTap: () {
                          Get.to(SignUp());
                        },
                        child: Text(
                          "sign up".tr,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
