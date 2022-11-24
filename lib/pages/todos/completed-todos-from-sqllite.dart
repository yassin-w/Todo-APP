// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todo_app/models/db_helper.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/todo_controller.dart';
import 'package:get/get.dart';

class CompleteTodosSQL extends StatefulWidget {
  const CompleteTodosSQL({super.key});

  @override
  State<CompleteTodosSQL> createState() => _ListTodosState();
}

class _ListTodosState extends State<CompleteTodosSQL> {
  dbHelper db = dbHelper();
  final todoController = Get.put(TodoController());

  @override
  void initState() {
    TodoController();
    todoController
        .getCompleteTodos(AuthController.instance.auth.currentUser!.uid);
    adddata(todoController.complete_tasks);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
        init: TodoController(),
        initState: (_) {},
        builder: (todoController) {
          return Scaffold(
            body: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        FutureBuilder(
                          future: readdate(),
                          builder:
                              (context, AsyncSnapshot<List<Map>?> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                        title: Row(
                                      children: [
                                        Text(
                                            "${snapshot.data![index]['name']}"),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                            "${snapshot.data![index]['status']}"),
                                      ],
                                    )),
                                  );
                                },
                              );
                            }
                            return Container();
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<List<Map>> readdate() async {
    List<Map> response = await db.readData("select * from todo");
    return response;
  }

  adddata(RxList complete_tasks) async {
    for (var element in complete_tasks) {
      await db.insertData(
          "INSERT INTO 'todo' ('name','status') VALUES ('${element.name}','completed')");
    }
  }
}
