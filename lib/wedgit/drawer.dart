// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/AppLanguage.dart';
import '../utils/themes/theme_service.dart';

class drawer extends StatefulWidget {
  const drawer({
    Key? key,
  }) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    String _selectedLang = 'en';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerHeader(
          child: Column(
            children: [
              Container(
                // ignore: sort_child_properties_last
                child: Text(
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
                            _selectedLang = value!;
                          });
                          Get.updateLocale(Locale(_selectedLang));
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
