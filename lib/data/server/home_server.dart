import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_pro/consetant/server_config.dart';
import 'package:task_pro/data/models/user_tasks.dart';

import '../models/todo.dart';

class HomeServer {
  Future<UserTasks?> getUserTasks(
    int userId,
  ) async {
    try {
      String urlWithUserId = '${ServerConfig.getUserTasksURL}/$userId';
      // send request
      var jsonResponse = await http.get(
        Uri.parse(urlWithUserId),
      );
      // handling response
      if (jsonResponse.statusCode == 200) {
        UserTasks userTasks = userTasksFromJson(jsonResponse.body);
        return userTasks;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteTask(
    int taskId,
  ) async {
    try {
      String urlWithTaskId = '${ServerConfig.deleteTaskURL}/$taskId';
      // send request
      var jsonResponse = await http.get(
        Uri.parse(urlWithTaskId),
      );
      // handling response
      if (jsonResponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Todo?> addNewTask(String taskDescription, int userId) async {
    try {
      // create header & body
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'todo': taskDescription,
        'completed': false,
        'userId': userId
      });

      // send request
      var jsonResponse = await http.post(
        Uri.parse(ServerConfig.addNewTaskURL),
        headers: headers,
        body: body,
      );
      // handling response
      if (jsonResponse.statusCode == 200) {
        Todo todo = Todo.fromJson(jsonDecode(jsonResponse.body));
        return todo;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }


  Future<bool> makeTaskDone(
      int taskId,
      ) async {
    try {
      // create header & body
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'completed': true,
      });
      String urlWithTaskId = '${ServerConfig.makeTaskDoneURL}/$taskId';
      // send request
      var jsonResponse = await http.put(
        Uri.parse(urlWithTaskId),
        headers: headers,
        body: body,
      );
      // handling response
      if (jsonResponse.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
