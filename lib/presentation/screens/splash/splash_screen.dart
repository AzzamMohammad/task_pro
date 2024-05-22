import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pro/business/splah_bloc/splash_bloc.dart';
import 'package:task_pro/consetant/page_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(GetTargetPageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SplashBloc,SplashState>(
          listener: (context,state){
            if(state is ThereIsCashedUserInfoDataExistState){
              Navigator.pushNamedAndRemoveUntil(context, PageRoutes.homeScreen, (route) => false);
            }else if(state is NoCashedUserInfoDataExistState){
              Navigator.pushNamedAndRemoveUntil(context, PageRoutes.introScreen, (route) => false);
            }
          },
          child: Center(
            child:  DefaultTextStyle(
              style: const TextStyle(),
              child: _animatedText(context),
            ),
          ),
        )
      ),
    );
  }

  Widget _animatedText(BuildContext context){
    return AnimatedTextKit(
      animatedTexts: [
        WavyAnimatedText('task '.toUpperCase(),textStyle:TextStyle(
          fontSize: 40.spMin,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,
        ),
            speed: const Duration(milliseconds: 200)
        ),
        WavyAnimatedText('pro'.toUpperCase(), textStyle: TextStyle(
          fontSize: 40.spMin,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
            speed: const Duration(milliseconds: 200)
        ),
      ],
      isRepeatingAnimation: true,
      repeatForever: true,
      pause:const Duration(milliseconds: 20),
    );
  }
}
