// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/authController.dart';
import 'package:todo_app/pages/login.dart';

import '../utils/themes/theme_service.dart';
import '../wedgit/drawer.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

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
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "sign up".tr,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "myfont",
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: 120,
              ),
              const SizedBox(
                height: 27,
              ),
              const SizedBox(
                height: 15,
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
                        Icons.email,
                      ),
                      hintText: "Your Email :".tr,
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 15,
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
              const SizedBox(
                height: 17,
              ),
              ElevatedButton(
                onPressed: () {
                  AuthController.instance.register(emailController.text.trim(),
                      passwordController.text.trim());
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 89, vertical: 5)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27))),
                ),
                child: Text(
                  "sign up".tr,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '.tr),
                  GestureDetector(
                    onTap: () {
                      Get.to(Login());
                    },
                    child: Text(
                      "login".tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              SizedBox(
                width: 299,
                child: Row(
                  children: const [
                    Expanded(
                        child: Divider(
                      thickness: 0.6,
                    )),
                    Text(
                      "OR",
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.6,
                    )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color.fromARGB(255, 158, 152, 235),
                                width: 1)),
                        child: SvgPicture.asset(
                          "assets/icons/facebook.svg",
                          color: Colors.blue,
                          height: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color.fromARGB(255, 158, 152, 235),
                                width: 1)),
                        child: SvgPicture.asset(
                          "assets/icons/google-plus.svg",
                          color: Colors.blue,
                          height: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color.fromARGB(255, 158, 152, 235),
                                width: 1)),
                        child: SvgPicture.asset(
                          "assets/icons/twitter.svg",
                          color: Colors.blue,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
