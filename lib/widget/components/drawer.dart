// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_language_controller.dart';
import '../../utils/themes/theme_service.dart';

class DrawerComp extends StatefulWidget {
  const DrawerComp({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerComp> createState() => DrawerState();
}

class DrawerState extends State<DrawerComp> {
  @override
  Widget build(BuildContext context) {
    String selectedLang = 'ar';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerHeader(
          child: Column(
            children: [
              SizedBox(
                // ignore: sort_child_properties_last
                child: const Text(
                  "Todo App",
                  style: TextStyle(fontFamily: "myfont", fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                width: double.infinity,
              ),
              Image.asset(
                "assets/images/todo.png",
                width: 100,
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("choose language: ".tr),
              SizedBox(
                width: 20,
              ),
              GetBuilder<AppLanguage>(
                  init: AppLanguage(),
                  builder: (controller) {
                    return DropdownButton(
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text("English"),
                          ),
                          DropdownMenuItem(
                            value: 'ar',
                            child: Text("Arabic"),
                          ),
                        ],
                        value: controller.appLocale,
                        onChanged: (value) {
                          setState(() {
                            selectedLang = value!;
                          });
                          Get.updateLocale(Locale(selectedLang));
                          controller.changeLanguage(value!);
                        });
                  })
            ],
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Text("Dark theme".tr),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    ThemeService().changeTheme();
                  },
                  icon: Icon(CupertinoIcons.moon_stars)),
            ],
          ),
        )
      ],
    );
  }
}
