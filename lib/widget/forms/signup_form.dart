// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../pages/todos/home_page.dart';
import '../../utils/validator/validator.dart';
import '../dialogs/signup_dialog.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(66),
                border: Border.all(
                  color: Color.fromARGB(255, 158, 152, 235),
                ),
              ),
              width: 266,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                validator: Validators.validateEmail,
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                validator: Validators.validatePassword,
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
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SignupSuccessfullyDialog();
                      });
                  AuthController.instance.register(emailController.text.trim(),
                      passwordController.text.trim());
                  await Future.delayed(const Duration(seconds: 4));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 89, vertical: 5)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
              ),
              child: Text(
                "sign up".tr,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ));
  }
}
