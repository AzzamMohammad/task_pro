import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pro/business/home_bloc/home_bloc.dart';
import 'package:task_pro/presentation/components/empty_space.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:task_pro/presentation/screens/home/component/user_card_loader.dart';

import '../../../../data/models/todo.dart';
import '../../../components/bottom_nav_bar.dart';
import '../../../components/task_card.dart';
import '../component/home_body_widgets_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetUserInfoFromLocalDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(8.h),
          children: [
            _userCard(),
            EmptySpace(
              height: 10.h,
            ),
            _homeBodyWidgets(),
          ],
        ),
      ),
      floatingActionButton: BottomNavBar(screenIndex: 1),
    );
  }

  Widget _userCard() {
    return BlocBuilder<HomeBloc,HomeState>(
      buildWhen: (previous, current){
        // build jst for UserInfoLoadedSuccessfullyState or LoadingUserInfoState
        if(current is LoadingUserInfoState || current is UserInfoLoadedSuccessfullyState){
          return true;
        }else{
          return false;
        }
      },
        builder:(context,state){
          if(state is LoadingUserInfoState){
            return const UserCardLoader();
          }else if(state is UserInfoLoadedSuccessfullyState){
            //call get user tasks api
            _getUserTasks(state.userInfo.id);
            return ListTile(
              leading: _userImage(),
              title: _userName('${state.userInfo.firstName} ${state.userInfo.lastName}'),
              subtitle: _userEmail(state.userInfo.email),
            );
          }
          return Container();
        }
    );
  }

  Widget _userImage() {
    return Container(
      width: 50.w,
      height: 50.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.w), color: Colors.blueAccent),
      child: Image.asset(
        'assets/icons/user_profile_image.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _userName(String userName) {
    return Text(
      userName.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );
  }

  Widget _userEmail(String email) {
    return Text(
      email,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );
  }

  Widget _homeBodyWidgets(){
    return BlocBuilder<HomeBloc,HomeState>(
      builder: (context,state){
        if(state is LoadingUserTasks){
          // set loading
          return const HomeBodyWidgetsLoader();
        }else if(state is ErrorInLoadingUserTasks){
          //set error
          return SizedBox(
            height: 60.h,
            child: const Center(
              child: Text('No Data'),
            ),
          );

        }else if (state is UserTasksLoadedSuccessfullyState){
           return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              _selectTaskTypeButtonsBar(),
              EmptySpace(
                height: 10.h,
              ),
              _tasksBarTitle(),
              EmptySpace(
                height: 10.h,
              ),
              _tasks(state.userTasks.todos),
            ],
          );
        }
        return Container();
      },
    );
  }
  //filtering tasks to completed amd not completed
  Widget _selectTaskTypeButtonsBar() {
    return SizedBox(
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _filterTaskButton(AppLocalizations.of(context)!.completed,(){
          }),
          _filterTaskButton(AppLocalizations.of(context)!.waiting,(){
          }),

        ],
      ),
    );
  }

  Widget _filterTaskButton(String label , Function() onTap) {
    return FilledButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all<Size>(Size(160.w, 70.h)),
        minimumSize: MaterialStateProperty.all<Size>(Size(160.w, 70.h)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            // Change your radius here
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Text(label),
    );
  }


  Widget _tasksBarTitle() {
    return Text(
      AppLocalizations.of(context)!.yor_tasks,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.spMin),
    );
  }

  Widget _tasks(List<Todo> todos) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TaskCard(id: todos[index].id,
          task:todos[index].todo,
          state:todos[index].completed ,
            );
      },
    );
  }

  void _getUserTasks(int userId){
    BlocProvider.of<HomeBloc>(context).add(GetUserTasksEvent(userId: userId));
  }

}
