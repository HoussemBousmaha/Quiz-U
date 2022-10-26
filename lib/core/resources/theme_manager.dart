import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'value_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // main colors of the app
    // primaryColor: ColorManager.backgroundColor,
    // primaryColorLight: ColorManager.primaryOpacity70,
    // primaryColorDark: ColorManager.darkPrimary,
    // disabledColor: ColorManager.grey1,

    // ripple color
    // splashColor: ColorManager.primaryOpacity70,

    // will be used in case of disabled button for example
    colorScheme: ColorScheme.fromSwatch().copyWith(
        // secondary: ColorManager.grey,
        // primary: ColorManager.primary,
        ),

    // fontFamily: GoogleFonts.cairo().fontFamily,

    // card view theme

    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.ws4,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      // color: ColorManager,
      elevation: AppSize.ws4,
      // shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
    ),

    // Button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primaryButtonColor,
      splashColor: ColorManager.white,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.ws6)),
        textStyle: getRegularStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primaryButtonColor,
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      headline1: getSemiBoldStyle(color: ColorManager.primaryTextColor, fontSize: FontSize.s22),
      headline2: getBoldStyle(color: ColorManager.primaryTextColor, fontSize: FontSize.s14),
      headline3: getBoldStyle(color: ColorManager.secondaryTextColor, fontSize: FontSize.s10),
      headline4: getRegularStyle(color: ColorManager.primaryTextColor, fontSize: FontSize.s12),
      subtitle1: getMediumStyle(color: ColorManager.secondaryTextColor, fontSize: FontSize.s14),
      subtitle2: getMediumStyle(color: ColorManager.secondaryTextColor, fontSize: FontSize.s14),
      caption: getRegularStyle(color: ColorManager.secondaryTextColor),
      bodyText1: getRegularStyle(color: ColorManager.grey),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // hint style
      hintStyle: getRegularStyle(color: ColorManager.secondaryTextColor),

      // label style
      labelStyle: getBoldStyle(color: ColorManager.secondaryTextColor),

      fillColor: ColorManager.textFieldFillColor,

      // error style
      errorStyle: getRegularStyle(color: ColorManager.error),

      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: AppSize.ws1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.ws5)),
      ),

      // focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: AppSize.ws1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.ws5)),
      ),

      // error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.ws1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.ws5)),
      ),

      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: AppSize.ws1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.ws8)),
      ),
    ),
  );
}
