import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:task_pro/business/home_bloc/home_bloc.dart';

import '../../components/loding_message.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final TextEditingController _taskController;

  @override
  void initState() {
    _taskController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _userTextTask(context),
              const SizedBox(
                height: 5,
              ),
              _circle(context, 10, 60),
              const SizedBox(
                height: 5,
              ),
              _circle(context, 7, 75),
              _userImage(),
            ],
          ),
        ),
      ),
      floatingActionButton: _sendingButton(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.add_task),
    );
  }

  Widget _userTextTask(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 300.w,
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: _filed(context),
    );
  }

  Widget _filed(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: _taskController,
      cursorColor: Colors.blueAccent,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: AppLocalizations.of(context)!.what_are_you_thinking,
      ),
      style: TextStyle(fontSize: 15.spMin),
      autofocus: true,
      maxLines: 5,
      // textAlign: TextAlign.center,
    );
  }

  Widget _circle(BuildContext context, double size, double padding) {
    return Container(
      height: 20,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Align(
        alignment: Alignment.topLeft,
        child: CircleAvatar(
          radius: size,
          backgroundColor: Colors.blueAccent,
          child: CircleAvatar(
            radius: size - 2,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }

  Widget _sendingButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _addNewTask(_taskController.text);
      },
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Colors.blueAccent),
        child: const Icon(Icons.send, color: Colors.white),
      ),
    );
  }

  Widget _userImage() {
    return CircleAvatar(
      radius: 70.0.w,
      backgroundColor: Colors.blueAccent,
      child: Text(
        'T',
        style: TextStyle(
          fontSize: 50.spMin,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _addNewTask(String task) async {
    // check if task description is not empty
    FocusScope.of(context).requestFocus( FocusNode());
    if(!_validateTask(task)){
      return;
    }
    LoadingMessage.displayLoading(Theme.of(context).cardColor, Colors.blue);
    BlocProvider.of<HomeBloc>(context).add(AddNewTaskEvent(taskDescription:task));
    _listenToChanges(context);
  }

  bool _validateTask(String task){
    if (task == '') {
      //display error
      LoadingMessage.displayToast(
        Theme.of(context).cardColor,
        Colors.blue,
        Colors.blue,
        AppLocalizations.of(context)!.enter_task_description,
        true,
      );
      return false;
    }
    return true;
  }


  void _listenToChanges(BuildContext context){
    BlocProvider.of<HomeBloc>(context).stream.listen((state) {
      if (state is TaskAddedSuccessfullyState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.task_add_successfully, true);
        Navigator.pop(context);
      }
      if (state is ErrorInAddTaskState) {
        LoadingMessage.dismiss();
        LoadingMessage.displayToast(Theme.of(context).cardColor, Colors.blue,
            Colors.blue, AppLocalizations.of(context)!.an_error_happen, true);
      }
    });
  }
}
