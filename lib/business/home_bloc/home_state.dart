part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

final class LoadingUserInfoState extends HomeState{}

 class UserInfoLoadedSuccessfullyState extends HomeState{
  late final UserInfo userInfo;
  UserInfoLoadedSuccessfullyState({required this.userInfo});
}

final class LoadingUserTasks extends HomeState{}

class UserTasksLoadedSuccessfullyState extends HomeState{
 late final UserTasks userTasks;
 UserTasksLoadedSuccessfullyState({
  required this.userTasks,
});
}

class ErrorInLoadingUserTasks extends HomeState{}

class TaskDeletedSuccessfullyState extends HomeState{}

class ErrorInDeletedTaskState extends HomeState{}

class TaskAddedSuccessfullyState extends HomeState{}

class ErrorInAddTaskState extends HomeState{}

class TaskMakedDoneSuccessfullyState extends HomeState{}

class ErrorInMakedDoneTaskState extends HomeState{}
