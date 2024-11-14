import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
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
        return darkThemeData();
      case AppTheme.light:
      default:
        return ThemeData.light();
    }
  }
}

class ThemeHelper {
  Future<ThemeData> loadThemeData(BuildContext context) async {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return AppTheme.dark.themeData;
    } else {
      return AppTheme.light.themeData;
    }
  }

}
