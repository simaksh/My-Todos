import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../pages/home/controllers/home-controller.dart';

import '../pages/home/models/todo-view-model.dart';


class EditTodoPage extends StatelessWidget {
  final TodoViewModel todo;

  const EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: todo.title);
    final TextEditingController userIdController = TextEditingController(text: todo.userId.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(

              onPressed: () {

                final HomeController controller = Get.find();
                controller.editTodo(todo: todo, newTitle: titleController.text, newUserId: int.parse(userIdController.text));
                // Go back to previous page
                Get.back();
              },

              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}