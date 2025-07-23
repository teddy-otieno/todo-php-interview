// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  isComplete: json['isComplete'] as int,
  description: json['description'] as String,
  created_at: DateTime.parse(json['created_at'] as String),
  updated_at: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'created_at': instance.created_at.toIso8601String(),
  'updated_at': instance.updated_at.toIso8601String(),
};

NewTodo _$NewTodoFromJson(Map<String, dynamic> json) => NewTodo(
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$NewTodoToJson(NewTodo instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
};
