import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home-controller.dart';
import '../models/todo-view-model.dart';

class TodoItem extends GetView<HomeController> {
  const TodoItem({required this.todo, Key? key}) : super(key: key);

  final TodoViewModel todo;

  @override
  Widget build(BuildContext context) =>
      Card(
        color: Colors.pink,
        child: Row(
          children: [
            Expanded(
              child: Text(todo.title),
            ),
            Obx(
                  () =>
              controller.isEditLoadingMap[todo.id]??false
                  ? Transform.scale(
                scale:0.5,
                child: const CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
                  : Checkbox(
                value: todo.completed,
                onChanged: (newValue) =>
                    controller.toggleTodoIsCompleted(
                      todo: todo,
                      newValue: newValue!,
                    ),
              ),
            ),
            Obx(
                  () =>
              controller.isDeleteLoadingMap[todo.id]??false?
                   Transform.scale(
                scale: 0.5,
                child: const CircularProgressIndicator(),
              )
                  : IconButton(
                onPressed: () => controller.deleteTodo(id: todo.id),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
            Obx(
                  () =>
              controller.isEditLoading[todo.id]??false
                  ? Transform.scale(
                scale: 0.5,
                child: const CircularProgressIndicator(),
              )
                  : IconButton(
                onPressed: () =>
                    controller.editTodo(
                      todo: todo,
                      newTitle: 'newTitle',
                      newUserId: 100,
                    ),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),

      );
}