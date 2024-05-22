import 'dart:convert';

import 'package:task_pro/data/models/todo.dart';

TasksPagination tasksPaginationFromJson(String str) => TasksPagination.fromJson(json.decode(str));

String tasksPaginationToJson(TasksPagination data) => json.encode(data.toJson());

class TasksPagination {
  List<Todo> todos;
  int total;
  int skip;
  int limit;

  TasksPagination({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TasksPagination.fromJson(Map<String, dynamic> json) => TasksPagination(
    todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}
