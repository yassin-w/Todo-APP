// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/authentication/login_page.dart';
import '../../widget/components/drawer.dart';
import '../../widget/forms/signup_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

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
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              SignupForm(),
              const SizedBox(
                height: 15,
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
