// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_import
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
