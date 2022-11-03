import 'package:flutter/material.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/listtodos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const ListTodos(),
        "/add": (context) => const AddTodo(),
      },
    );
  }
}
