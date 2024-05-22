import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class LoadingMessage{
   static void displayToast(Color backgroundColor , Color indicatorColor , Color textColor , String messageText , bool dismissOnTap){
    EasyLoading.instance
      ..backgroundColor = backgroundColor
      ..indicatorColor = indicatorColor
      ..textColor =  textColor;
    EasyLoading.showToast(
      messageText,
      toastPosition: EasyLoadingToastPosition.bottom,
      dismissOnTap: dismissOnTap,
      duration: const Duration(seconds: 5),
    );
  }

  static void displayLoading(Color backgroundColor , Color indicatorColor){
    EasyLoading.instance
      ..backgroundColor = backgroundColor
      ..indicatorColor = indicatorColor
      ..textColor =  Colors.white;
    EasyLoading.show(
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,

    );
  }


  void displaySuccess(Color backgroundColor , Color indicatorColor , Color textColor , String messageText, bool dismissOnTap){
    EasyLoading.instance
      ..backgroundColor = backgroundColor
      ..indicatorColor = indicatorColor
      ..textColor =  textColor;
    EasyLoading.showSuccess(
      messageText,
      dismissOnTap: dismissOnTap,
      duration: const Duration(seconds: 4),
      maskType: EasyLoadingMaskType.black,
    );
  }

  void displayError(Color backgroundColor , Color indicatorColor , Color textColor , String messageText, bool dismissOnTap){
    EasyLoading.instance
      ..backgroundColor = backgroundColor
      ..indicatorColor = indicatorColor
      ..textColor =  textColor;
    EasyLoading.showError(
      messageText,
      dismissOnTap: dismissOnTap,
      duration: const Duration(seconds: 4),
      maskType: EasyLoadingMaskType.black,
    );
  }

   static void dismiss (){
    EasyLoading.dismiss();
  }
}