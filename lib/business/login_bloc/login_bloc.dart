import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_pro/data/models/user_info.dart';

import '../../data/repositories/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository = LoginRepository();
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserWithUserNameAndPasswordEvent>(_loginUser);
  }

  void _loginUser(
      LoginUserWithUserNameAndPasswordEvent event,
      Emitter<LoginState> emit,
      ) async {
    // get user login info
    String userName = event.userName;
    String userPassword = event.password;
    // login request
    UserInfo? userInfo = await _loginRepository.sendLoginUserInfo(userName, userPassword);

    // case1 : userInfo is null => there are an error in connection or info
    // case2 : userInfo is not null => login success
    if(userInfo != null){
      // cash user info
     bool savingState =await _loginRepository.cashUserInfo(userInfo);
     if(savingState){
        // go to home page
        emit(LoginSuccessfullyState());
     }else{
        // an error happen
       emit(LoginFailedWhileSavingErrorState());
     }
    }else{
      // an error happen
      emit(LoginFailedByInfoErrorState());
    }
  }
}


