import 'dart:convert';
import 'package:either_dart/either.dart';

import'package:http/http.dart'as http;

import '../models/todo-dto.dart';


class AddRepository {
  Future<Either<String, Map<String, dynamic>>> addTodo(
      {required TodoDto dto}) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      var url = Uri.http('localhost:3000','/todos');
      final response = await http.post(
        url,
        body: jsonEncode(dto.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 400) {
        return Right(jsonDecode(response.body));
      } else {
        return Left('${response.statusCode}');
      }
    } catch (error) {
      return Left(error.toString());
    }
  }
}
