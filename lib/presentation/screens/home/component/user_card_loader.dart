import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pro/presentation/components/liner_shimmer_loading.dart';

class UserCardLoader extends StatelessWidget {
  const UserCardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _userImageLoader(context),
      title: _userNameLoader(context),
      subtitle: _userEmailLoader(context),
    );
  }

  Widget _userImageLoader(BuildContext context){
    return  LinerShimmerLoading.Square(width: 50.w, height: 50.w, radius: 60.w, color: Theme.of(context).cardColor);
  }

  Widget _userNameLoader(BuildContext context){
    return  LinerShimmerLoading.Square(width: 70.w, height: 20.w, radius: 20.w, color: Theme.of(context).cardColor);
  }
  Widget _userEmailLoader(BuildContext context){
    return  LinerShimmerLoading.Square(width: 100.w, height: 18.w, radius: 20.w, color: Theme.of(context).cardColor);
  }
}
