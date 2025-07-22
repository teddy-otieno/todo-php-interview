import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';

import 'package:todo_mobile/models/Todo.dart';
import 'package:todo_mobile/utils.dart';

class TodoService {
  TaskEither<Error, List<Todo>> listTodos() {
    return httpGet('/api/todos',
        (data) => List<Todo>.from(data.map((x) => Todo.fromJson(x))));
  }

  TaskEither<Error, Todo> getTodo(int id) {
    return httpGet('/api/todos/${id}', Todo.fromJson);
  }

  Future<Todo> addTodo(NewTodo newTodo) async {
    var response = await client.post(makeUri("/api/todos/"),
        body: jsonEncode(newTodo.toJson()));

    var body = jsonDecode(response.body);

    return Todo.fromJson(body);
  }
}
