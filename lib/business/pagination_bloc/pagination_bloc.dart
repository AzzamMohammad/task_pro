import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meta/meta.dart';
import 'package:task_pro/data/models/tasks_pagination.dart';
import 'package:task_pro/data/models/todo.dart';
import 'package:task_pro/data/repositories/pagination_repository.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final PaginationRepository _paginationRepository = PaginationRepository();
  late TasksPagination? _lastPage = null;
  PaginationBloc() : super(PaginationInitial()) {
    on<GetNewPageEvent>(_getNewPage);
  }

  Future<void> _getNewPage(
      GetNewPageEvent event,
      Emitter<PaginationState> emit,
      )async{
    // if first page do not call yet
    if(_lastPage == null){
      // check the net connection
      bool netState = await _isThereNetConnection();
      if(!netState){
        await _getCashedPaginationTasks(event,emit);
        return;
      }
      await _getFirstTasksPage(event,emit);
    }else{
      // get next page
     await _getNextPage(event,emit);
    }
  }

  Future<bool> _isThereNetConnection() async {
    //check net connection
    bool connection = await InternetConnection().hasInternetAccess;
    return connection;
  }

  Future<void> _getCashedPaginationTasks( GetNewPageEvent event,
      Emitter<PaginationState> emit,)async{
    List<Todo>? cashedTasks = await _paginationRepository.getCashedPaginationTasks();
    if(cashedTasks != null){
      emit(NewPageIsLoadedState(newTasks: cashedTasks));
      emit(ArriveToLastPageState());
    }
  }

  Future<void> _getFirstTasksPage(
      GetNewPageEvent event,
      Emitter<PaginationState> emit,
      )async{
    TasksPagination? firstPage = await _paginationRepository.getNewPage(0);
    if(firstPage!=null){
      _lastPage = firstPage;
      emit(NewPageIsLoadedState(newTasks: _lastPage!.todos));
      await _paginationRepository.cashPaginationTasks(_lastPage!.todos);
    }
  }

  Future<void> _getNextPage(
      GetNewPageEvent event,
      Emitter<PaginationState> emit,
      )async{
    // get next page
    // every page content 15 item
    TasksPagination? nextPage = await _paginationRepository.getNewPage(_lastPage!.skip+15);
    if(nextPage!=null){
      _lastPage = nextPage;
      emit(NewPageIsLoadedState(newTasks: _lastPage!.todos));
      //  arrive to last page
      if(_lastPage!.skip >= _lastPage!.total){
        emit(ArriveToLastPageState());
        return;
      }
    }
  }
}
