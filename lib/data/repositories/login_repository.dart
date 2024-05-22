import '../local_storage/shared_date.dart';
import '../models/user_info.dart';
import '../server/login_server.dart';

class LoginRepository {
  late LoginServer _loginServer;
  late SharedDate _sharedDate;

  LoginRepository() {
    _loginServer = LoginServer();
    _sharedDate = SharedDate();
  }

  Future<UserInfo?> sendLoginUserInfo(String userName,String userPassword)async {
    UserInfo? userInfo = await _loginServer.sendLoginRequest(userName, userPassword);
    return userInfo;
  }

  Future<bool> cashUserInfo(UserInfo userInfo)async{
    // save Userinfo model to local storage
    String user = userInfoToJson(userInfo);
    try{
      await _sharedDate.saveUserInfo(user);
      return true;
    }catch(error){
      // if an error happen while saving
      return false;
    }
  }
}
