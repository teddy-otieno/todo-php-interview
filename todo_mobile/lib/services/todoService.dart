import 'package:fpdart/fpdart.dart';
import 'package:todo_mobile/models/Todo.dart';
import 'package:todo_mobile/utils.dart';

class TodoService {
  TaskEither<Error, List<Todo>> listTodos() {
    return httpGet(
      '/api/todos',
      (data) => List<Todo>.from(data.map((x) => Todo.fromJson(x))),
    );
  }

  TaskEither<Error, Todo> getTodo(int id) {
    return httpGet('/api/todos/$id', Todo.fromJson);
  }

  TaskEither<Error, Todo> addTodo(NewTodo newTodo) {
    return httpPost("/api/todos", Todo.fromJson, newTodo.toJson());
  }
}
