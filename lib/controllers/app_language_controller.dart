// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/langueges/language_storge.dart';

class AppLanguage extends GetxController {
  var appLocale = 'ar';

  @override
  void onInit() async {
    super.onInit();
    LanguageStorage localStorage = LanguageStorage();

    appLocale = await localStorage.languageSelected == null
        ? 'ar'
        : await localStorage.languageSelected;
    update();
    Get.updateLocale(Locale(appLocale));
  }

  void changeLanguage(String type) async {
    LanguageStorage localStorage = LanguageStorage();

    if (appLocale == type) {
      return;
    }
    if (type == 'ar') {
      appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
    } else {
      appLocale = 'en';
      localStorage.saveLanguageToDisk('en');
    }
    update();
  }
}
