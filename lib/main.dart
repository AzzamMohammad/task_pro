import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_pro/settings/theme/app_theme.dart';
import 'package:task_pro/settings/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_router.dart';




void main() {
  runApp(MyApp(appRouter: AppRouter(),));
  configEasyLoading();
}

class MyApp extends StatelessWidget {
  AppRouter appRouter;
  MyApp({super.key,required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child){
        return MaterialApp(
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          supportedLocales: l10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (currentLanguage,supportedLang){
            if(currentLanguage != null){
              for (Locale locale in supportedLang){
                if(locale.languageCode == currentLanguage.languageCode) {
                  return locale;
                }
              }
            }
            return supportedLang.first;
          },
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
          builder: EasyLoading.init(),
        );
      },

    );
  }

}

void configEasyLoading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 20)
    ..indicatorType = EasyLoadingIndicatorType.foldingCube
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50
    ..radius = 10.0
    ..progressColor = Colors.green
    ..maskColor = Colors.blue
    ..userInteractions = false
    ..dismissOnTap = false;

}
