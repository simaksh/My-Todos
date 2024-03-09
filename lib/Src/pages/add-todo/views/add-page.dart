
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add-controller.dart';



class AddPage extends GetView<AddController> {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('add page'),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 16),
            child: TextFormField(
              controller: controller.userIdTextController,
              decoration: const InputDecoration(
                label: Text('userId'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextFormField(
              controller: controller.titleTextController,
              decoration: const InputDecoration(
                label: Text('title'),
              ),
            ),
          ),
          Obx(() {
            return controller.isSubmitLoading.value
                ? _submitLoading()
                : ElevatedButton(
              onPressed: () => controller.addTodo(),
              child: const Text('Submit'),
            );
          }),
        ],
      ),
    ),
  );

  Widget _submitLoading() => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(color: Colors.grey),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
        Text(
          'Submit',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
