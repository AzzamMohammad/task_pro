import 'package:task_pro/data/models/tasks_pagination.dart';
import 'package:http/http.dart' as http;

import '../../consetant/server_config.dart';

class PaginationServer{
  Future<TasksPagination?> getNewPage(int fromItem)async{
    try {
      String urlWithUserId = '${ServerConfig.getPageURL}?limit=15&skip=$fromItem';
      // send request
      var jsonResponse = await http.get(
        Uri.parse(urlWithUserId),
      );
      // handling response
      if (jsonResponse.statusCode == 200) {
        TasksPagination page = tasksPaginationFromJson(jsonResponse.body);
        return page;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}