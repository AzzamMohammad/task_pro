import 'dart:convert';

import 'package:task_pro/data/models/todo.dart';

UserTasks userTasksFromJson(String str) => UserTasks.fromJson(json.decode(str));

String userTasksToJson(UserTasks data) => json.encode(data.toJson());

class UserTasks {
  List<Todo> todos;
  int total;
  int skip;
  int limit;

  UserTasks({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory UserTasks.fromJson(Map<String, dynamic> json) => UserTasks(
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
