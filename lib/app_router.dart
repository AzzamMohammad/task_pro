import 'package:flutter/material.dart';
import 'package:task_pro/business/home_bloc/home_bloc.dart';
import 'package:task_pro/business/login_bloc/login_bloc.dart';
import 'package:task_pro/business/pagination_bloc/pagination_bloc.dart';
import 'package:task_pro/business/splah_bloc/splash_bloc.dart';
import 'package:task_pro/presentation/screens/add_task/add_task_screen.dart';
import 'package:task_pro/presentation/screens/home/screen/home_screen.dart';
import 'package:task_pro/presentation/screens/intro/screen/intro_screen.dart';
import 'package:task_pro/presentation/screens/login/login_screen.dart';
import 'package:task_pro/presentation/screens/pagination/pagination_screen.dart';
import 'package:task_pro/presentation/screens/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'consetant/page_routes.dart';

class AppRouter {
  late HomeBloc homeBloc;

  AppRouter() {
    homeBloc = HomeBloc();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // splash screen route
      case PageRoutes.splashScreen:
        {
          return _goToSplashScreen();
        }
      //intro screen route
      case PageRoutes.introScreen:
        {
          return _goToIntroScreen();
        }
      // login screen route
      case PageRoutes.loginScreen:
        {
          return _goToLoginScreen();
        }
      // home screen route
      case PageRoutes.homeScreen:
        {
          return _goToHomeScreen();
        }
      // Add task screen route
      case PageRoutes.addTaskScreen:
        {
          return _goToAddTaskScreen();
        }
      // pagination screen route
      case PageRoutes.paginationScreen:
        {
          return _goToPaginationScreen();
        }
    }
    return null;
  }

  MaterialPageRoute<dynamic> _goToSplashScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (BuildContext context) {
          return SplashBloc();
        },
        child: const SplashScreen(),
      ),
    );
  }

  MaterialPageRoute<dynamic> _goToIntroScreen() {
    return MaterialPageRoute(
      builder: (_) => const IntroScreen(),
    );
  }

  MaterialPageRoute<dynamic> _goToLoginScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (BuildContext context) {
          return LoginBloc();
        },
        child: const LoginScreen(),
      ),
    );
  }

  MaterialPageRoute<dynamic> _goToHomeScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: homeBloc,
        child: const HomeScreen(),
      ),
    );
  }

  MaterialPageRoute<dynamic> _goToAddTaskScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: homeBloc,
        child: AddTaskScreen(),
      ),
    );
  }

  MaterialPageRoute<dynamic> _goToPaginationScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (BuildContext context) {
          return PaginationBloc();
        },
        child: const PaginationScreen(),
      ),
    );
  }
}
