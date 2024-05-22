import 'dart:convert';

import 'package:task_pro/data/local_storage/shared_date.dart';
import 'package:task_pro/data/models/tasks_pagination.dart';
import 'package:task_pro/data/models/todo.dart';
import 'package:task_pro/data/server/pagination_server.dart';

class PaginationRepository{
  late PaginationServer _paginationServer;
  late SharedDate _sharedDate;
  PaginationRepository(){
    _paginationServer = PaginationServer();
    _sharedDate = SharedDate();
  }

  Future<TasksPagination?> getNewPage(int fromItem)async{
    TasksPagination? tasksPage = await _paginationServer.getNewPage(fromItem);
    return tasksPage;
  }


  Future<void> cashPaginationTasks(List<Todo> tasks)async{
    try{
      // delete storied data
      _sharedDate.deletePaginationTasks();
      //save new data
      var paginationTasks = jsonEncode(tasks.map((e) => e.toJson()).toList());
      await _sharedDate.savePaginationTasks(paginationTasks);
    }catch(e){
      return;
    }
  }

  Future<List<Todo>?> getCashedPaginationTasks()async{
    try{
      String? paginationTasks = await _sharedDate.getPaginationTasks();
      if(paginationTasks != null){
        // there ara cashed user tasks
        Iterable jsonTasks = json.decode(paginationTasks);
        List<Todo> posts = List<Todo>.from(jsonTasks.map((model)=> Todo.fromJson(model)));
        return posts;
      }else{
        return null;
      }
    }catch(e){
      return null;
    }
  }

}