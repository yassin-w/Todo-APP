import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/validator/validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {


  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(66),
                border: Border.all(
                  color: const Color.fromARGB(255, 158, 152, 235),
                ),
              ),
              width: 266,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                validator: Validators.validateEmail,
                controller: emailController,
                decoration: InputDecoration(
                    icon: const Icon(
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
                  color: const Color.fromARGB(255, 158, 152, 235),
                ),
                borderRadius: BorderRadius.circular(66),
              ),
              width: 266,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                validator: Validators.validatePassword,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    suffix: const Icon(
                      Icons.visibility,
                    ),
                    icon: const Icon(
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
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  AuthController.instance.login(emailController.text.trim(),
                      passwordController.text.trim());
                  // Change here
                }
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 106, vertical: 10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
              ),
              child: Text(
                "login".tr,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ));
  }
}
