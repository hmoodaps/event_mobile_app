import 'package:flutter/material.dart';
import 'color_manager.dart';

ThemeData lightThemeData() {
  return ThemeData(

    colorScheme: const ColorScheme.light(
      primary: ColorManager.primarySecond,
      secondary: ColorManager.privateYalow,
      surface: ColorManager.primary,
      onPrimary: ColorManager.darkPrimary,
      onSecondary: Colors.black,
      onSurface: ColorManager.privateGrey,
      error: Colors.red,
      onError: Colors.white,
    ),
    primaryColor: ColorManager.primarySecond,
    scaffoldBackgroundColor: ColorManager.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.primary,
      iconTheme: IconThemeData(color: ColorManager.primarySecond),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.primarySecond,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.primarySecond,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorManager.primary,
      selectedItemColor: ColorManager.primarySecond,
      unselectedItemColor: ColorManager.privateGrey,
    ),

  );
}

ThemeData darkThemeData() {
  return ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: ColorManager.primarySecond,
      secondary: ColorManager.privateYalow,
      surface: ColorManager.darkPrimary,
      onPrimary: ColorManager.primarySecond, // لون النصوص في الوضع الداكن
      onSecondary: Colors.white,
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.white,
    ),
    primaryColor: ColorManager.primarySecond,
    scaffoldBackgroundColor: ColorManager.darkPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.darkPrimary,
      iconTheme: IconThemeData(color: ColorManager.primarySecond),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.primarySecond,
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.primarySecond,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorManager.darkPrimary,
      selectedItemColor: ColorManager.primarySecond,
      unselectedItemColor: ColorManager.privateGrey,
    ),

  );
}
