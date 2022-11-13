// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/listtodos.dart';

import '../controllers/authController.dart';
import '../wedgit/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    ListTodos(),
    AddTodo(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: drawer(),
      ),
      appBar: AppBar(
        title: Text(
          "ToDo App",
        ),
        actions: [
          IconButton(
              onPressed: () {
                AuthController.instance.logout();
              },
              icon: Icon(Icons.logout)),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home".tr),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_task,
              ),
              label: 'add task'.tr),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
