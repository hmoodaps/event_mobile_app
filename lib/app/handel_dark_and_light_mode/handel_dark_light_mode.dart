import 'package:flutter/material.dart';

import '../../presentation/bloc_state_managment/bloc_manage.dart';
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

class ThemeHelper {
  final EventsBloc bloc;

  ThemeHelper(this.bloc);

//================ Toggle between light and dark mode ========================
// Updates theme data based on system brightness and triggers ToggleLightAndDarkEvent
}
