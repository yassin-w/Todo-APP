// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UpdateSuccessDialog extends StatelessWidget {
  const UpdateSuccessDialog({
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
          'Done'.tr,
          style: TextStyle(fontSize: 25),
        ),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              Text(
                'update Successfully'.tr,
              ),
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                "assets/icons/done.svg",
                height: 100,
                color: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
