import 'package:flutter/material.dart';
import '../../widget/cards/card.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/todo_controller.dart';
import 'package:get/get.dart';

class CompleteTodos extends StatefulWidget {
  const CompleteTodos({super.key});

  @override
  State<CompleteTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<CompleteTodos> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
        init: TodoController(),
        initState: (_) {},
        builder: (todoController) {
          todoController
              .getCompleteTodos(AuthController.instance.auth.currentUser!.uid);

          return Scaffold(
            body: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GetX<TodoController>(
                      builder: (controller) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.complete_tasks.length,
                            itemBuilder: (context, index) {
                              return CustomCard(
                                  id: controller.complete_tasks[index].id,
                                  name: controller.complete_tasks[index].name,
                                  description: controller
                                      .complete_tasks[index].description,
                                  date: controller.complete_tasks[index].date,
                                  isComplete: controller
                                      .complete_tasks[index].isComplete);
                            });
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
