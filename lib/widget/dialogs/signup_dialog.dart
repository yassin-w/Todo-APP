// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignupSuccessfullyDialog extends StatelessWidget {
  const SignupSuccessfullyDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: AlertDialog(
        title: Text(
          'Thanks !!',
          style: TextStyle(fontSize: 25),
        ),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/icons/signup_success.svg",
                height: 100,
                color: Colors.greenAccent,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Thanke you For Signing Up!',
              )
            ],
          ),
        ),
      ),
    );
  }
}
