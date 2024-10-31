import 'package:flutter/material.dart';
import '../../app/components/constants/general_strings.dart';
import '../../app/components/constants/theme_manager.dart';
import '../local_storage/shared_local.dart';

enum AppTheme {
  light,
  dark,
}

extension AppThemeExtension on AppTheme {
  ThemeData get themeData {
    switch (this) {
      case AppTheme.dark:
        return ThemeData.dark();
      case AppTheme.light:
      default:
        return ThemeData.light();
    }
  }

  Future<void> saveToPreferences() async {
    await SharedPref.prefs.setString('app_theme', toString());
  }

  static Future<AppTheme> loadFromPreferences() async {
    final themeString = SharedPref.prefs.getString('app_theme') ?? AppTheme.light.toString();
    return AppTheme.values.firstWhere((e) => e.toString() == themeString, orElse: () => AppTheme.light);
  }
}
class ThemeHelper {
  Future<ThemeData> loadThemeData() async {
    String toggleModeType = SharedPref.prefs.getString(GeneralStrings.toggleModeType) ?? GeneralStrings.basedOnPhone;
    if (toggleModeType == GeneralStrings.manual) {
      AppTheme currentTheme = await AppThemeExtension.loadFromPreferences();
      return currentTheme == AppTheme.dark ? AppTheme.light.themeData : AppTheme.dark.themeData;
    } else {
      return WidgetsBinding.instance.window.platformBrightness == Brightness.dark ? darkThemeData() : lightThemeData();
    }
  }
}
