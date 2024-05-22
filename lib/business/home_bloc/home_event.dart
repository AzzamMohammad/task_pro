part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

final class GetUserInfoFromLocalDataEvent extends HomeEvent{}

 class GetUserTasksEvent extends HomeEvent{
  late final int userId;
  GetUserTasksEvent({
    required this.userId,
});

}

 class DeleteTaskEvent extends HomeEvent{
  late final int taskId;
  DeleteTaskEvent({required this.taskId,});
}

 class AddNewTaskEvent extends HomeEvent{
  late final String taskDescription;
  AddNewTaskEvent({required this.taskDescription,});
}

 class MakeTaskDoneEvent extends HomeEvent{
  late final int taskId;
  MakeTaskDoneEvent({required this.taskId,});
}


