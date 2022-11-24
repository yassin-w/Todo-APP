// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAiiGxifxIX1ys5zu_q8riv1MmiGatCE5g',
    appId: '1:932685931691:web:b823e73ea31f79146e03ee',
    messagingSenderId: '932685931691',
    projectId: 'todoapp-afb81',
    authDomain: 'todoapp-afb81.firebaseapp.com',
    storageBucket: 'todoapp-afb81.appspot.com',
    measurementId: 'G-YKE61N8LE6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmHiicbpSJ9awBKwP1xaO-pT8RFuTaozM',
    appId: '1:932685931691:android:3201a6f74a2675c16e03ee',
    messagingSenderId: '932685931691',
    projectId: 'todoapp-afb81',
    storageBucket: 'todoapp-afb81.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgbI35IEn-c7_AfpzLAdKbWaqc0tPXdh4',
    appId: '1:932685931691:ios:a135e0a778a944b36e03ee',
    messagingSenderId: '932685931691',
    projectId: 'todoapp-afb81',
    storageBucket: 'todoapp-afb81.appspot.com',
    iosClientId: '932685931691-8c554qadq75s8sj3pi0b12f086ki56qg.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBgbI35IEn-c7_AfpzLAdKbWaqc0tPXdh4',
    appId: '1:932685931691:ios:a135e0a778a944b36e03ee',
    messagingSenderId: '932685931691',
    projectId: 'todoapp-afb81',
    storageBucket: 'todoapp-afb81.appspot.com',
    iosClientId: '932685931691-8c554qadq75s8sj3pi0b12f086ki56qg.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );
}
