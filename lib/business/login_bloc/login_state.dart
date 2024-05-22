part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

final class LoginSuccessfullyState extends LoginState{}


final class LoginFailedByInfoErrorState extends LoginState{}

final class LoginFailedWhileSavingErrorState extends LoginState{}

