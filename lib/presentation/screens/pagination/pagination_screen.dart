import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pro/business/pagination_bloc/pagination_bloc.dart';

import '../../../data/models/todo.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/liner_shimmer_loading.dart';
import '../../components/task_card.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  late final  ScrollController _tasksScrollController;
  late final List<Todo> _tasks;
  late bool _arriveToLastPage;

  @override
  void initState() {
    _arriveToLastPage = false;
    _tasks = [];
    _tasksScrollController = ScrollController();
    _listenToScroll();
    super.initState();
  }

  void _listenToScroll(){
    BlocProvider.of<PaginationBloc>(context).add(GetNewPageEvent());
    // listen to scroll
    // if arrive to last item try to get new page
    _tasksScrollController.addListener(() {
      if(_tasksScrollController.position.maxScrollExtent == _tasksScrollController.offset){
        // arrive to the end of list
        if(!_arriveToLastPage){
          BlocProvider.of<PaginationBloc>(context).add(GetNewPageEvent());
        }
      }
    });
  }

  @override
  void dispose() {
    _tasksScrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pagination),
        automaticallyImplyLeading: false,
        // leading: Container(),
      ),
      body: SafeArea(
        child: _tasksList(),
      ),
      floatingActionButton: BottomNavBar(screenIndex: 2),

    );
  }

  Widget _tasksList(){
    return BlocBuilder<PaginationBloc,PaginationState>(
      buildWhen: (previous, current){
        if(current is ArriveToLastPageState){
          _arriveToLastPage = true;
          return true;
        }else if(current is NewPageIsLoadedState){
          _tasks.addAll(current.newTasks);
          return true;
        }
        return false;
      },
      builder: (BuildContext context, PaginationState state) {
        return Scrollbar(
          radius: const Radius.circular(5),
          child: ListView.builder(
            controller: _tasksScrollController,
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            primary: false,
            itemCount:_arriveToLastPage ? _tasks.length: _tasks.length + 1,
            itemBuilder: (context, index) {
              if(index == _tasks.length ){
                if(!_arriveToLastPage){
                  return _tasksLoader(context);
                }
              }
              return TaskCard(id: _tasks[index].id,
                task: _tasks[index].todo,
                state: _tasks[index].completed,
                isSlidable: false,
              );
            },
          ),
        );
      },
    );
  }

  Widget _tasksLoader(BuildContext context){
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 2,
      itemBuilder: (context, index) {
        return _taskCardLoader(context);
      },
    );
  }

  _taskCardLoader(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: LinerShimmerLoading.Square(width: 160.w,height: 70.h,radius: 8.h, color: Theme.of(context).cardColor,),
    );
  }
}
