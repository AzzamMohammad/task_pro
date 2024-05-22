import 'package:shared_preferences/shared_preferences.dart';

class SharedDate{
  /////////////////// cashing UserInfo
  Future<void> saveUserInfo(String userInfo)async{
    final data = await SharedPreferences.getInstance();
    data.setString('user_info', userInfo);
  }

  Future<String?> getUserInfo()async{
    final data = await SharedPreferences.getInstance();
    String? userInfo = data.getString('user_info');
    return userInfo ;
  }
  Future<bool> deleteUserInfo()async{
    final data = await SharedPreferences.getInstance();
    if(await data.remove('user_info')) {
      return true;
    }
    return false;
  }

  /////////////////// cashing UserTasks
  Future<void> saveUserTasks(String userTasks)async{
    final data = await SharedPreferences.getInstance();
    data.setString('user_tasks', userTasks);
  }

  Future<String?> getUserTasks()async{
    final data = await SharedPreferences.getInstance();
    String? userTasks = data.getString('user_tasks');
    return userTasks ;
  }
  Future<bool> deleteUserTasks()async{
    final data = await SharedPreferences.getInstance();
    if(await data.remove('user_tasks')) {
      return true;
    }
    return false;
  }



  /////////////////// cashing UserTasks
  Future<void> savePaginationTasks(String paginationTasks)async{
    final data = await SharedPreferences.getInstance();
    data.setString('pagination_tasks', paginationTasks);
  }

  Future<String?> getPaginationTasks()async{
    final data = await SharedPreferences.getInstance();
    String? pagination = data.getString('pagination_tasks');
    return pagination ;
  }
  Future<bool> deletePaginationTasks()async{
    final data = await SharedPreferences.getInstance();
    if(await data.remove('pagination_tasks')) {
      return true;
    }
    return false;
  }

}