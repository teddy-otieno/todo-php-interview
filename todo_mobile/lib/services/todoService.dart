import 'dart:convert';

import 'package:todo_mobile/models/Todo.dart';
import 'package:todo_mobile/utils.dart';

class TodoService {
  Future<List<Todo>> listTodos() async {
    var response = await client.get(makeUri('/api/todos'));

    var body = jsonDecode(response.body);

    return List<Todo>.from(body.map((x) => Todo.fromJson(x)));
  }

  Future<Todo> getTodo(int id) async {
    var response = await client.get(makeUri('/api/todos/${id}'));

    var body = jsonDecode(response.body);

    return Todo.fromJson(body);
  }
}
