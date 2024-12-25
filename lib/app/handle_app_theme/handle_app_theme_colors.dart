// Defines the green theme colors.
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/local_storage/shared_local.dart';
import '../../presentation/bloc_state_managment/events.dart';
import '../components/constants/color_manager.dart';
import '../components/constants/general_strings.dart';

class GreenAppColor implements AppColorManager {
  @override
  Color primary = Color(0xFFbdd6bc);
  @override
  Color primarySecond = Color(0xFF36CC60);

  //main page Color manager
  @override
  Color green1 = const Color(0xFF061400);
  @override
  Color green2 = const Color(0xFF164701);
  @override
  Color green3 = const Color(0xFF2b8c01);
  @override
  Color green4 = const Color(0xFF4cf502);

  @override
  Color green5 = const Color(0xFFb7f7ad);
}

// Defines the purple theme colors.
class PurpleAppColor implements AppColorManager {
  @override
  Color primary = const Color(0xFFd7b6e3);
  @override
  Color primarySecond = const Color(0xFF8b3ab5);

  @override
  Color green1 = const Color(0xFF1f022e);
  @override
  Color green2 = const Color(0xFF420263);
  @override
  Color green3 = const Color(0xFF6e03a6);
  @override
  Color green4 = const Color(0xFFa502fa);

  @override
  Color green5 = const Color(0xFFdba0fa);
}

// Defines the blue theme colors.
class BlueAppColor implements AppColorManager {
  @override
  Color primary = const Color(0xFF9fb8e0);
  @override
  Color primarySecond = const Color(0xFF3876d9);

  @override
  Color green1 = const Color(0xFF011638);
  @override
  Color green2 = const Color(0xFF012f78);
  @override
  Color green3 = const Color(0xFF024bbf);
  @override
  Color green4 = const Color(0xFF0363fc);

  @override
  Color green5 = const Color(0xFF99bbf0);
}

// Enum to define the available color themes.
enum AppColorsTheme { green, purple, blue }

// Extension to retrieve the color manager based on the selected theme.
extension AppColorsThemeExtension on AppColorsTheme {
  AppColorManager get appColorManager {
    switch (this) {
      case AppColorsTheme.green:
        return GreenAppColor();
      case AppColorsTheme.purple:
        return PurpleAppColor();
      case AppColorsTheme.blue:
        return BlueAppColor();
    }
  }
}

// Helper class to manage theme-related operations.
class AppColorHelper {
  // Sets the initial theme when the app starts.
  static void setInitialTheme() {
    if (kDebugMode) {
      print("Setting initial theme...");
    }
    if (SharedPref.prefs.getString(GeneralStrings.colorTheme) == null) {
      AppColorManager color = AppColorsTheme.green.appColorManager;
      ColorManager.updateColors(color);
    } else if (SharedPref.prefs.getString(GeneralStrings.colorTheme) ==
        'green') {
      AppColorManager color = AppColorsTheme.green.appColorManager;
      ColorManager.updateColors(color);
    } else if (SharedPref.prefs.getString(GeneralStrings.colorTheme) ==
        'blue') {
      AppColorManager color = AppColorsTheme.blue.appColorManager;
      ColorManager.updateColors(color);
    } else if (SharedPref.prefs.getString(GeneralStrings.colorTheme) ==
        'purple') {
      AppColorManager color = AppColorsTheme.purple.appColorManager;
      ColorManager.updateColors(color);
    }

    if (kDebugMode) {
      print("Initial theme set.");
    }
  }

  // Changes the color theme based on the selected event.
  static changeColorTheme(ChangeColorModeEvent event) {
    AppColorManager appColorManager = event.appColorsTheme.appColorManager;
    ColorManager.updateColors(appColorManager);
  }
}
