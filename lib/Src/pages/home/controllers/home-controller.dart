


import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../edit-Todo/edit-todo-page.dart';
import '../../../infrastructure/route/route-names.dart';

import '../models/edit-todo-dto.dart';
import '../models/todo-view-model.dart';
import '../repository/home-repository.dart';

class HomeController extends GetxController {
  final HomeRepository _repository = HomeRepository();
  RxList<TodoViewModel> todos = <TodoViewModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isRetryMode = false.obs;
  RxMap<String, bool> isEditLoadingMap = <String, bool>{}.obs;
  RxMap<String, bool> isEditLoading = <String, bool>{}.obs;
  RxMap<String, bool> isDeleteLoadingMap = <String, bool>{}.obs;


  @override
  void onInit() {
    super.onInit();
    getTodos();
  }

  Future<void> getTodos() async {
    try {
      isLoading.value = true;
      final resultOrException = await _repository.getTodos();
      isLoading.value = false;

      resultOrException.fold(
            (exception) {
          isRetryMode.value = true;
          Get.showSnackbar(
            GetSnackBar(
              message: 'Error.StatusCode $exception',
            ),
          );
        },
            (todosResponse) {
          todos.assignAll(todosResponse);
        },
      );
    } catch (error) {
      Get.showSnackbar(
        GetSnackBar(
          title: '$error',
        ),
      );
    }
  }

  Future<void> goToAddPage() async {
    final result = await Get.toNamed('${RouteNames.home}${RouteNames.addTodo}');
    if (result != null) {
      final TodoViewModel newTodo = TodoViewModel.fromJson(result);
      todos.add(newTodo);
    }
  }

  Future<void> deleteTodo({
    required String id,
  }) async {
    isDeleteLoadingMap[id]=true;
    await Future.delayed(const Duration(seconds: 2));

    final resultOrException = await _repository.deleteTodo(id: id);
    isDeleteLoadingMap[id]=false;

    resultOrException.fold(
          (exception) => Get.showSnackbar(
        GetSnackBar(
          title: exception,
        ),
      ),
          (right) {
        todos.removeWhere((item) => item.id == id);
      },
    );
  }

  Future<void> toggleTodoIsCompleted({
    required TodoViewModel todo,
    required bool newValue,
  }) async {
    isEditLoadingMap[todo.id]=false;


    final EditTodoDto dto = EditTodoDto(
      userId: todo.userId,
      id: todo.id,
      title: todo.title,
      isCompleted: newValue,
    );

    final resultOrException = await _repository.toggleTodoIsCompleted(dto: dto);
    isEditLoadingMap[todo.id]=true;


    resultOrException.fold(
          (exception) => Get.showSnackbar(
        GetSnackBar(
          title: exception,
        ),
      ),
          (newTodo) {
        final int index = todos.indexWhere((element) => element.id == todo.id);
        if (index != -1) {
          todos[index] = newTodo;
        }
      },
    );
  }

  Future<void> editTodo({
    required TodoViewModel todo,
    required String newTitle,
    required int newUserId,
  }) async {
    try {
      isEditLoading [todo.id]=true;

      final resultOrException = await _repository.toggleTodoIsCompleted(
        dto: EditTodoDto(
            userId: newUserId,
            id: todo.id,
            title: newTitle,
            isCompleted: todo.completed
        ),
      );
      isEditLoading[todo.id]=false;
      resultOrException.fold(
            (exception) => Get.showSnackbar(
          GetSnackBar(
            title: exception,
          ),
        ),
            (newTodo) {
          final int index = todos.indexWhere((element) => element.id == todo.id);
          if (index != -1) {
            todos[index] = newTodo;
          }
        },
      );
    } catch (error) {
      Get.showSnackbar(
        GetSnackBar(
          title: '$error',
        ),
      );
    }
  }

  Future<void> goToEditPage(TodoViewModel todo) async {
    await Get.to(() => EditTodoPage(todo: todo));
  }
}