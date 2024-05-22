import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/empty_space.dart';
import '../../../components/liner_shimmer_loading.dart';

class HomeBodyWidgetsLoader extends StatelessWidget {
  const HomeBodyWidgetsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _selectTaskTypeButtonsBarLoader(context),
        EmptySpace(
          height: 20.h,
        ),
        _tasksLoader(context),
      ],
    );
  }

  Widget _selectTaskTypeButtonsBarLoader(BuildContext context){
    return  SizedBox(
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomLoader(context),
          _bottomLoader(context),
        ],
      ),
    );
  }

  Widget _bottomLoader(BuildContext context){
    return LinerShimmerLoading.Square(width: 160.w,height: 70.h,radius: 20, color: Theme.of(context).cardColor,);
  }

  Widget _tasksLoader(BuildContext context){
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 3,
      itemBuilder: (context, index) {
        return _taskCardLoader(context);
      },
    );
  }

  Widget _taskCardLoader(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: LinerShimmerLoading.Square(width: 160.w,height: 70.h,radius: 8.h, color: Theme.of(context).cardColor,),
    );
  }
}
