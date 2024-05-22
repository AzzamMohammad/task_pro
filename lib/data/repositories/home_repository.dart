import 'package:task_pro/data/local_storage/shared_date.dart';

import '../models/todo.dart';
import '../models/user_info.dart';
import '../models/user_tasks.dart';
import '../server/home_server.dart';

class HomeRepository{
  late SharedDate _sharedDate;
  late HomeServer _homeServer;

  HomeRepository(){
    _sharedDate = SharedDate();
    _homeServer = HomeServer();
  }

  Future<UserInfo?> getStoredUserInfo()async{
    try{
      String? user = await _sharedDate.getUserInfo();
      if(user != null){
        UserInfo userInfo = userInfoFromJson(user);
        return userInfo;
      }
      return null;
    }catch(e){
      return null;
    }
  }

  Future<UserTasks?> getUserTasksFromServer(int userId)async{
    return await _homeServer.getUserTasks(userId);
  }


  Future<void> cashUserTasks(UserTasks tasks)async{
    try{
      // delete storied data
      _sharedDate.deleteUserTasks();
      //save new data
      String userTasksJson = userTasksToJson(tasks);
      await _sharedDate.saveUserTasks(userTasksJson);
    }catch(e){
      return;
    }
  }

  Future<UserTasks?> getCashedUserTasks()async{
    try{
      String? userTaskJson = await _sharedDate.getUserTasks();
      if(userTaskJson != null){
        // there ara cashed user tasks
        UserTasks tasks = userTasksFromJson(userTaskJson);
        return tasks;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

  Future<bool> deleteTask(int taskId)async{
    bool deleteState = await _homeServer.deleteTask(taskId);
    return deleteState;
  }

  Future<Todo?> addNewTask(String taskDescription,int userId)async{
    Todo? newTask = await _homeServer.addNewTask(taskDescription,userId);
    return newTask;
  }

  Future<bool> makeTaskDone(int taskId)async{
    bool doneState = await _homeServer.makeTaskDone(taskId);
    return doneState;
  }
}