import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled116/Src/components/number-picker/custom-number-picker.dart';

import '../controllers/home-controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('listTodos'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.isRetryMode.value
                ? _buildRetryWidget()
                : _buildTodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.goToAddPage(),
        child: Icon(
          Icons.add,
          color: Colors.green.shade300,
        ),
      ),
    );
  }

  Widget _buildRetryWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('خطا در بارگیری لیست وظایف!'),
          ElevatedButton(
            onPressed: () => controller.getTodos(),
            child: const Text(
              'retry',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return Column(children: [
      CustomNumberPicker(
        initialValue: 20,
        onIncrease: (value) {},
        onDecrease: (value) {},
        minValue: 0,
        maxValue: 100,
      ),
      ElevatedButton(onPressed: () {}, child: const Text('submit')),
      Expanded(
          child: RefreshIndicator(
              onRefresh: () => controller.getTodos(),
              child: ListView.builder(
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) {
                    final todo = controller.todos[index];
                    return Card(
                        color: Colors.blue.shade100,
                        child: ListTile(
                          title: Text(todo.title),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            Checkbox(
                              value: todo.completed,
                              onChanged: (newValue) =>
                                  controller.toggleTodoIsCompleted(
                                todo: todo,
                                newValue: newValue!,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.deleteTodo(
                                id: todo.id,
                              ),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade500,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            IconButton(
                                onPressed: () => controller.goToEditPage(todo),
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.deepOrange.shade500,
                                ))
                          ]),
                        ));
                  })))
    ]);
  }
}
