import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_pro/business/home_bloc/home_bloc.dart';
import 'package:task_pro/presentation/components/loding_message.dart';
import 'empty_space.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class TaskCard extends StatelessWidget {
  late final int id;
  late final String task;
  late final bool state;
  late final bool? isSlidable;

  TaskCard({super.key, required this.id, required this.task,required this.state,this.isSlidable});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      enabled: isSlidable ?? true,
      startActionPane: startActionPane(context),
      endActionPane: endActionPane( context),
      child: _card(),
    );
  }

  ActionPane? startActionPane(BuildContext context) {
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label:AppLocalizations.of(context)!.delete,
          onPressed: (c) {
            _deleteTask(context,id);
          },
        ),
      ],
    );
  }

  ActionPane? endActionPane(BuildContext context) {
    return ActionPane(
      motion: const DrawerMotion(),
      children: _endActionButtons(context),
    );
  }

   List<Widget> _endActionButtons(BuildContext context){
    Widget doneButton = SlidableAction(
      onPressed: (c) {
        _makeTaskDone(context,id);
      },
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      icon: Icons.done,
      label:AppLocalizations.of(context)!.done,
    );

    Widget loveButton = SlidableAction(
      onPressed: (c) {},
      backgroundColor: Colors.greenAccent,
      foregroundColor: Colors.white,
      icon: Icons.star,
      label:AppLocalizations.of(context)!.love,
    );

    if(state){
      // task is done
      return [
        loveButton,
      ];
    }else{
      return [
        doneButton,
        loveButton,
      ];
    }
   }


  Widget _card(){
    return Card(
      child: Container(
          padding: EdgeInsets.all(8.h),
          height: 70.h,
          child: Row(
            children: [
              _leading(),
              EmptySpace(
                width: 15.w,
              ),
              _taskContent(),
            ],
          ),),
    );
  }
  Widget _leading() {
    return OutlinedButton(
      onPressed: () {},
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all<Size>(
          Size.fromWidth(60.h),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size.fromWidth(60.h),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(
        'T',
        style: TextStyle(
          fontSize: 30.spMin,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _taskContent(){
    return Expanded(
      child: Text(
        task,
        maxLines: 3,
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
    );
  }

  void _deleteTask(BuildContext context,int taskId)async{
    //set loading
    LoadingMessage.displayLoading(Theme.of(context).cardColor, Colors.blue);
    BlocProvider.of<HomeBloc>(context).add(DeleteTaskEvent(taskId: taskId));
    _listenToDeleteChanges(context);
  }

  void _listenToDeleteChanges(BuildContext context){
    BlocProvider.of<HomeBloc>(context).stream.listen((state) {
      if (state is TaskDeletedSuccessfullyState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.task_deleted_successfully, true);
      }
      if (state is ErrorInDeletedTaskState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.an_error_happen, true);
      }
    });
  }

  void _makeTaskDone(BuildContext context,int taskId)async{
    //set loading
    LoadingMessage.displayLoading(Theme.of(context).cardColor, Colors.blue);
    BlocProvider.of<HomeBloc>(context).add(MakeTaskDoneEvent(taskId: taskId));
    _listenToMakeDoneChanges(context);
  }

  void _listenToMakeDoneChanges(BuildContext context){
    BlocProvider.of<HomeBloc>(context).stream.listen((state) {
      if (state is TaskMakedDoneSuccessfullyState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.task_updated_successfully, true);
      }
      if (state is ErrorInMakedDoneTaskState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.an_error_happen, true);
      }
    });
  }
}
