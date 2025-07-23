import 'package:json_annotation/json_annotation.dart';

part 'Todo.g.dart';

@JsonSerializable()
class Todo {
  int id;
  String title;
  int isComplete;
  String description;
  DateTime created_at;
  DateTime updated_at;

  Todo({
    required this.id,
    required this.title,
    required this.isComplete,
    required this.description,
    required this.created_at,
    required this.updated_at,
  });

  factory Todo.fromJson(dynamic json) {
    return _$TodoFromJson(json);
  }
}

@JsonSerializable()
class NewTodo {
  String title;
  String description;

  NewTodo({required this.title, required this.description});

  Map<String, dynamic> toJson() {
    return _$NewTodoToJson(this);
  }
}
