// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_import
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/todos/add_todo_page.dart';
import 'package:todo_app/pages/todos/is_complete_tasks_page.dart';
import 'package:todo_app/pages/todos/list_todos_page.dart';
import 'package:todo_app/pages/todos/todolist-using-sqfentity.dart';
import 'package:todo_app/pages/todos/todos_location.dart';
import '../../controllers/auth_controller.dart';
import '../../widget/components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    ListTodos(),
    AddTodo(),
    CompleteTodos(),
    MyLocationPage()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String deviceToken = " ";

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   // If you're going to use other Firebase services in the background, such as Firestore,
  //   // make sure you call `initializeApp` before using other Firebase services.
  //   await Firebase.initializeApp();

  //   print("Handling a background message: ${message.messageId}");
  // }

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print(settings.authorizationStatus);
  }

  getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        deviceToken = value!;
        print('deviceToken is ----> $deviceToken');
      });
      savetoken(value!);
    });
  }

  Future<void> savetoken(String token) async {
    await FirebaseFirestore.instance.collection('UserToken').doc('user1').set({
      'token': token,
    });
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the current user
    String uid = AuthController().auth.currentUser!.uid;
    // FirebaseUser user = await _auth.currentUser();
    // Get the token for this device
    String? fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens =
          _db.collection('users').doc(uid).collection('tokens').doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  @override
  void initState() {
    requestPermission();
    getToken();
    _saveDeviceToken() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerComp(),
      ),
      appBar: AppBar(
        title: Text(
          "ToDo App",
        ),
        actions: [
          IconButton(
              onPressed: () {
                AuthController.instance.logout(AuthController.instance.auth.currentUser!.uid,deviceToken);
              },
              icon: Icon(Icons.logout)),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              label: "Home".tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_task, color: Colors.blue),
              label: 'add task'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.done, color: Colors.blue),
              label: 'tasks done'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on, color: Colors.blue),
              label: 'Locations'.tr),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
