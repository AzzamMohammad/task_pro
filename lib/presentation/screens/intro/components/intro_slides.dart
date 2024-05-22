import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class IntroSlides extends StatelessWidget {
   final PageController pageViewController;
    const IntroSlides({super.key,required this.pageViewController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
      child: PageView(
        controller: pageViewController,
        children: _slidesList(context),
      ),
    );
  }

   List<Widget>_slidesList(BuildContext context){
    return [
      _slide(
        context,
        'assets/images/wellcome_one.png',
        AppLocalizations.of(context)!.manage_your_task,
        AppLocalizations.of(context)!.with_this_small_app_you_can_organize_all_your_tasks_And_duties_in_a_one_single_app,
      ),
      _slide(
        context,
        'assets/images/wellcom_tow.png',
        AppLocalizations.of(context)!.carry_out_tasks,
        AppLocalizations.of(context)!.carry_out_your_tasks_day_After_Day_until_you_reach_your_goal,
      ),
      _slide(
        context,
        'assets/images/wellcom_three.png',
        AppLocalizations.of(context)!.success_partners,
        AppLocalizations.of(context)!.organize_your_tasks_in_the_best_way_to_ensure_success_in_all_areas_of_life,
      ),
    ];
   }

  Widget _slide(
      BuildContext context,
      String image,
      String title,
      String description,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _slidImage(context, image),
        SizedBox(
          height: 20.h,
        ),
        _slidTitle(title),
        SizedBox(
          height: 20.h,
        ),
        _slidDescription(context, description),
      ],
    );
  }

  Widget _slidImage(BuildContext context, String image) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h),
      child: Center(
        child: Image.asset(
          image,
          width: 300.w,
          height: 260.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _slidTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30.spMin,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _slidDescription(BuildContext context, String description) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: Text(
        description,
        style: TextStyle(fontSize: 16.spMin, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
