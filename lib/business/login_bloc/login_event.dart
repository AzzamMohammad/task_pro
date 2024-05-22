part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

 class LoginUserWithUserNameAndPasswordEvent extends LoginEvent{
  late final String userName;
  late final String password;
  LoginUserWithUserNameAndPasswordEvent({required this.userName,required this.password});
}