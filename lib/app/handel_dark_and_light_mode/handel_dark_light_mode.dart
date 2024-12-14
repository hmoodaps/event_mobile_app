import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/local_storage/shared_local.dart';
import '../components/constants/general_strings.dart';
import '../components/constants/theme_manager.dart';

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

abstract class TheAppMode {
  static ThemeData appMode = lightThemeData();

  static void updateMode(AppTheme mode) {
    appMode = mode.themeData;
  }
}

// Helper class to manage theme-related operations.
class HandleAppMode {
  // Sets the initial theme when the app starts.
  static void setInitialmode() {
    if (kDebugMode) {
      print("Setting initial theme...");
    }
    if (SharedPref.prefs.getString(GeneralStrings.appMode) == null) {
      AppTheme mode = AppTheme.light;
      TheAppMode.updateMode(mode);
    } else if (SharedPref.prefs.getString(GeneralStrings.appMode) == 'dark') {
      AppTheme mode = AppTheme.light;
      TheAppMode.updateMode(mode);
    } else if (SharedPref.prefs.getString(GeneralStrings.appMode) == 'light') {
      AppTheme mode = AppTheme.light;
      TheAppMode.updateMode(mode);
    }
    if (kDebugMode) {
      print("Initial theme set.");
    }
  }
}
