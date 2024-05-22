part of 'pagination_bloc.dart';

@immutable
abstract class PaginationState {}

class PaginationInitial extends PaginationState {}


class NewPageIsLoadedState extends PaginationState {
  late final List<Todo> newTasks;
  NewPageIsLoadedState({
    required this.newTasks,
});
}

class ArriveToLastPageState extends PaginationState {}
