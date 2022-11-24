// ignore_for_file: prefer_const_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, non_constant_identifier_names, unnecessary_new, file_names

import 'package:flutter/material.dart';
import '../../models/model.dart';

class ListTodosDatabase extends StatefulWidget {
  ListTodosDatabase({super.key});

  @override
  State<ListTodosDatabase> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodosDatabase> {
  List<Todo> todos = [];
  loadData() async {
    todos = await Todo().select().toList();
    setState(() {});
  }

  showTodoAddDialog() {
    String newTitle = "";
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Text("Add task"),
              content: TextField(
                onChanged: (value) => newTitle = value,
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () async {
                      todoAdd(newTitle);
                      Navigator.pop(context);
                    },
                    child: Text("Add"))
              ],
            ));
  }

  todoAdd(String todoTitle) async {
    Todo todoToAdd = Todo();
    todoToAdd.name = todoTitle;
    todoToAdd.description = "des";
    todoToAdd.date = "date";
    todoToAdd.isComplete = false;
    await todoToAdd.save();
    loadData();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: showTodoAddDialog,
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext cntxt, int index) {
              return ListTile(
                title: Text(todos[index].name ?? ""),
                trailing: todos[index].isComplete == true
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank),
                onTap: () async {
                  todos[index].isComplete = !todos[index].isComplete!;
                  await todos[index].save();
                  loadData();
                },
              );
            }));
  }
}
