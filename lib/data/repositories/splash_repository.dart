import 'package:task_pro/data/local_storage/shared_date.dart';
import 'package:task_pro/data/models/user_info.dart';

class SplashRepository{
  late SharedDate sharedDate;

  SplashRepository(){
    sharedDate = SharedDate();
  }


  Future<bool> checksIfThereIsStoredUserInfo()async{
    // Checks if there is stored data and returns it, but does not return null
    String? userInfo = await sharedDate.getUserInfo();
    if(userInfo == null){
      return false;
    }else{
      return true;
    }
}
}