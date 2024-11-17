import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../presentation/bloc_state_managment/bloc_manage.dart';
import '../../presentation/bloc_state_managment/events.dart';
import '../components/constants/theme_manager.dart';
import '../components/constants/variables_manager.dart';

enum AppTheme {
  light,
  dark,
}

extension AppThemeExtension on AppTheme {
  ThemeData get themeData {
    switch (this) {
      case AppTheme.dark:
        return darkThemeData();
      case AppTheme.light:
        return lightThemeData();
      default:
        return lightThemeData();
    }
  }
}

class ThemeHelper {
  final EventsBloc bloc;

  ThemeHelper(this.bloc);

  //================ Toggle between light and dark mode ========================
  // Updates theme data based on system brightness and triggers ToggleLightAndDarkEvent

  ThemeData? toggleLightAndDark(context) {
    ThemeData themeData = lightThemeData();
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    brightness == Brightness.dark
        ? (themeData = AppTheme.dark.themeData)
        : (themeData = AppTheme.light.themeData);
    if (kDebugMode) {
      print(VariablesManager.isDark ? "dark" : 'light');
    }
    bloc.add(ToggleLightAndDarkEvent(themeData));
    return themeData;
  }
}
