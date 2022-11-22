// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/pages/mainPages/splash_screen.dart';
import 'package:todo_app/utils/languages/translation.dart';
import 'package:todo_app/utils/themes/theme_service.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // localaization
      translations: Translation(),
      locale: Locale(GetStorage().read('lang') ?? 'en'),
      fallbackLocale: Locale(GetStorage().read('lang') ?? 'en'),
      // themes
      theme: ThemeService().lightTheme,
      darkTheme: ThemeService().darkTheme,
      themeMode: ThemeService().getThemeMode(),

      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
