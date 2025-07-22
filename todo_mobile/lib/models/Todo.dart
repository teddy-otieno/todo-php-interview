class Todo {
  int id;
  String title;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.updatedAt});

  factory Todo.fromJson(dynamic json) {
    return Todo(
        id: json['id'],
        title: json["title"],
        description: json['description'],
        createdAt: json['updatedAt'],
        updatedAt: json['createdAt']);
  }
}
