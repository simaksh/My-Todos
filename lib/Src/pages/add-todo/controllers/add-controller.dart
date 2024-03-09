
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/todo-dto.dart';
import '../repository/add-repository.dart';

class AddController extends GetxController {
  final AddRepository _repository = AddRepository();
  final TextEditingController titleTextController = TextEditingController(),
      userIdTextController = TextEditingController();

  final RxBool isSubmitLoading = false.obs;

  @override
  void onClose() {
    super.onClose();
    titleTextController.dispose();
    userIdTextController.dispose();
  }

  Future<void> addTodo() async {
    isSubmitLoading.value = true;
    final dto = TodoDto(
      userId: int.parse(userIdTextController.text),
      title: titleTextController.text,
      completed: false,
    );

    final resultOrException = await _repository.addTodo(dto: dto);

    isSubmitLoading.value = false;

    resultOrException.fold(
            (left) => Get.showSnackbar(GetSnackBar(
          message: left,
        )), (right) {
      Get.back(result: right);
    });
  }
}
