import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:flutter/material.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';
import 'color_manager.dart';

ThemeData lightThemeData() {
  return ThemeData(

    colorScheme: ColorScheme.light(
      primary: ColorManager.primarySecond,
      secondary: ColorManager.privateYalow,
      surface: ColorManager.primary,
      onPrimary: ColorManager.primary,
      onSecondary: Colors.black,
      onSurface: ColorManager.privateGrey,
      error: Colors.red,
      onError: Colors.white,
    ),
    primaryColor: ColorManager.primarySecond,
    scaffoldBackgroundColor: ColorManager.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      iconTheme: const IconThemeData(color: ColorManager.primarySecond),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.primarySecond,
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.primarySecond,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.primary,
      selectedItemColor: ColorManager.primarySecond,
      unselectedItemColor: ColorManager.privateGrey,
    ),

  );
}

ThemeData darkThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.dark(
      primary: ColorManager.primarySecond,
      secondary: ColorManager.privateYalow,
      surface: ColorManager.primary,
      onPrimary: ColorManager.primarySecond, // لون النصوص في الوضع الداكن
      onSecondary: Colors.white,
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.white,
    ),
    primaryColor: ColorManager.primarySecond,
    scaffoldBackgroundColor: ColorManager.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      iconTheme: const IconThemeData(color: ColorManager.primarySecond),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.primarySecond,
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.primarySecond,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.primary,
      selectedItemColor: ColorManager.primarySecond,
      unselectedItemColor: ColorManager.privateGrey,
    ),

  );
}
//toggle between themes
ThemeData? toggleLightAndDark(BuildContext context) {
  final EventsBloc bloc = EventsBloc.get(context);
  Brightness brightness = MediaQuery.of(context).platformBrightness;

  // تحديث الحالة بناءً على سمة النظام
  if (brightness == Brightness.dark) {
    VariablesManager.themeData = darkThemeData();
    VariablesManager.isDark = true;
  } else {
    VariablesManager.themeData = lightThemeData();
    VariablesManager.isDark = false;
  }

  bloc.add(ToggleLightAndDarkEvent());
  return VariablesManager.themeData;
}
