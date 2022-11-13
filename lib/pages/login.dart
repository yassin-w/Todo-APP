// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';
import 'package:todo_app/pages/signup.dart';
import '../wedgit/drawer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: drawer(),
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
          height: double.infinity,
          width: double.infinity,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Text(
                  "Log in".tr,
                  style: TextStyle(fontSize: 33, fontFamily: "myfont"),
                ),
                const SizedBox(
                  height: 35,
                ),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  width: 288,
                  height: 100,
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(66),
                    border: Border.all(
                      color: Color.fromARGB(255, 158, 152, 235),
                    ),
                  ),
                  width: 266,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                        ),
                        hintText: "Your Email :".tr,
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 158, 152, 235),
                    ),
                    borderRadius: BorderRadius.circular(66),
                  ),
                  width: 266,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        suffix: Icon(
                          Icons.visibility,
                        ),
                        icon: Icon(
                          Icons.lock,
                          size: 19,
                        ),
                        hintText: "Password :".tr,
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthController.instance.login(emailController.text.trim(),
                        passwordController.text.trim());
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 106, vertical: 10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27))),
                  ),
                  child: Text(
                    "login".tr,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
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
