import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';


class AppTheme{
   static light(){
    return FlexThemeData.light(
      scheme: FlexScheme.bahamaBlue,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        buttonMinSize: Size(10, 50),
        outlinedButtonBorderWidth: 2,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,

      ),
      keyColors: const FlexKeyColors(
        useSecondary: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: "Montserrat",

    );
  }

  static dark(){
     return FlexThemeData.dark(
       scheme: FlexScheme.bahamaBlue,
       surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
       blendLevel: 12,
       subThemesData: const FlexSubThemesData(
         blendOnLevel: 20,
         useTextTheme: true,
         useM2StyleDividerInM3: true,
         alignedDropdown: true,
         useInputDecoratorThemeInDialogs: true,
       ),
       keyColors: const FlexKeyColors(
         useSecondary: true,
       ),
       visualDensity: FlexColorScheme.comfortablePlatformDensity,
       useMaterial3: true,
       swapLegacyOnMaterial3: true,
       fontFamily: "Montserrat",
     );
  }


}