import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_pro/data/models/user_tasks.dart';

import '../../data/models/todo.dart';
import '../../data/models/user_info.dart';
import '../../data/repositories/home_repository.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository = HomeRepository();
  late UserInfo? userInfo;
  late UserTasks? _userTasks;

  HomeBloc() : super(HomeInitial()) {
    //Get user info from localData
    on<GetUserInfoFromLocalDataEvent>(_getUserInfo);
    //Get user tasks
    on<GetUserTasksEvent>(_getUserTasks);
    //Delete task event
    on<DeleteTaskEvent>(_deleteTask);
    //Add new task event
    on<AddNewTaskEvent>(_addNewTask);
    //Edit task {{ this api is not exist so i do update task api}}
    on<MakeTaskDoneEvent>(_makeTaskDone);
  }

  Future<void> _getUserInfo(
    GetUserInfoFromLocalDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingUserInfoState());
    emit(LoadingUserTasks());
    userInfo = await _homeRepository.getStoredUserInfo();
    if (userInfo != null) {
      emit(UserInfoLoadedSuccessfullyState(userInfo: userInfo!));
    }
  }

  Future<void> _getUserTasks(
    GetUserTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingUserTasks());
    // check net connection
    bool connection = await _isThereNetConnection();

    // If there is a connection then get the data from the server
    // else get cashed data
    if (connection) {
     await _getUserTaskFromServer(event, emit);
    } else {
     await _getCashedUserTasks(event, emit);
    }
  }

  Future<bool> _isThereNetConnection() async {
    //check net connection
    bool connection = await InternetConnection().hasInternetAccess;
    return connection;
  }

  Future<void> _getUserTaskFromServer(
    GetUserTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    // try to get data from server
     _userTasks = await _homeRepository.getUserTasksFromServer(
      event.userId,
    );
    // if data arrived return it
    // else get cashed data
    if (_userTasks != null) {
      // emit state
      emit(UserTasksLoadedSuccessfullyState(userTasks: _userTasks!));
      // cash user tasks
      _homeRepository.cashUserTasks(_userTasks!);
    } else {
      // get cashed data
     await _getCashedUserTasks(event, emit);
    }
  }

  Future<void> _getCashedUserTasks(
    GetUserTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    // get cashed data
    _userTasks = await _homeRepository.getCashedUserTasks();
    // if there is cashed data return it
    //else return error (( display empty data))
    if (_userTasks != null) {
      // emit state
      emit(UserTasksLoadedSuccessfullyState(userTasks: _userTasks!));
    } else {
      emit(ErrorInLoadingUserTasks());
    }
  }

  void _deleteTask( DeleteTaskEvent event,
      Emitter<HomeState> emit,)async{
    bool deleteState = await _homeRepository.deleteTask(event.taskId);
    if(deleteState){
      // deleted successfully
      //1- delete from tasks list
      _deleteTaskFromList(event.taskId);
      //2-finish loading
      emit(TaskDeletedSuccessfullyState());
      //3- rebuild screen
      emit(UserTasksLoadedSuccessfullyState(userTasks: _userTasks!));
    }else{
      //1- error in delete task
      emit(ErrorInDeletedTaskState());
      //2- rebuild screen
      emit(UserTasksLoadedSuccessfullyState(userTasks: _userTasks!));
    }
  }

  void _deleteTaskFromList(int taskID){
    _userTasks!.todos.removeWhere((element) => element.id == taskID);
  }

  void _addNewTask(AddNewTaskEvent event,
      Emitter<HomeState> emit,)async{
    Todo? newTask = await _homeRepository.addNewTask(event.taskDescription,userInfo!.id);
    // if added successfully then add to task lest
    if(newTask != null){
      //1- add to task lest
      _addTaskToList(newTask);
      //2-finish loading
      emit(TaskAddedSuccessfullyState());
      //3- rebuild screen
      emit(UserTasksLoadedSuccessfullyState(userTasks: _userTasks!));
    }else{
      //1- error in delete task
      emit(ErrorInAddTaskState());
    }
  }

  void _addTaskToList(Todo task){
    _userTasks!.todos.insert(0, task);
  }

  void _makeTaskDone(MakeTaskDoneEvent event,
      Emitter<HomeState> emit,)async{
    bool doneState = await _homeRepository.makeTaskDone(event.taskId);
    if(doneState){
      // done successfully
      //1- make task done locally
      _makeTaskDoneInList(event.taskId);
      //2-finish loading
      emit(TaskMakedDoneSuccessfullyState());
      //3- rebuild screen
      emit(UserTasksLoadedSuccessfullyState(userTasks: _userTasks!));
    }else{
      //1- error in update task
      emit(ErrorInMakedDoneTaskState());
      //2- rebuild screen
      emit(UserTasksLoadedSuccessfullyState(userTasks: _userTasks!));
    }
  }

  void _makeTaskDoneInList(int taskId){
    _userTasks?.todos.where((task) => task.id == taskId).first.completed = true;
  }
}
