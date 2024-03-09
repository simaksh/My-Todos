import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../../infrastructure/commons/repository-urls.dart';
import '../models/edit-todo-dto.dart';
import '../models/todo-view-model.dart';

class HomeRepository {
  Future<Either<String, List<TodoViewModel>>> getTodos() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      var url = Uri.http(
        RepositoryUrls.webBaseUrl,
        RepositoryUrls.getTodos,
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> todosList = jsonDecode(response.body);
        final todos = todosList.map((todoJson) =>
            TodoViewModel.fromJson(todoJson)).toList();
        return Right(todos);
      } else {
        return Left('${response.statusCode}');
      }
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, String>> deleteTodo({
    required String id,
  }) async {
    try {

      await Future.delayed(const Duration(seconds: 4));
      final url = Uri.http(
        RepositoryUrls.webBaseUrl,
        RepositoryUrls.deleteTodo(id),
      );

      final response = await http.delete(url);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        return Right(response.body);
      } else {
        return Left('${response.statusCode}');
      }
    } catch (error) {
      return Left('$error');
    }
  }

  Future<Either<String, TodoViewModel>> toggleTodoIsCompleted({
    required EditTodoDto dto,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      await Future.delayed(const Duration(seconds: 5));
      final url = Uri.http(
        RepositoryUrls.webBaseUrl,
        RepositoryUrls.editTodo(dto.id),
      );

      final response = await http.patch(
        url,
        body: jsonEncode(dto.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final TodoViewModel todo = TodoViewModel.fromJson(json);
        return Right(todo);
      } else {
        return Left('${response.statusCode}');
      }
    } catch (error) {
      return Left('$error');
    }
  }

  Future<TodoViewModel> editTodo({
    required EditTodoDto dto,
  }) async {
    final response = await http.put(
    Uri(),
      body: json.encode(dto.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return TodoViewModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to edit todo: ${response.statusCode}');
    }
  }
}


