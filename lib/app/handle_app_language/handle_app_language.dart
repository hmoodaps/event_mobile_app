// Defines the green theme colors.

import 'package:flutter/foundation.dart';

import '../../data/local_storage/shared_local.dart';
import '../../presentation/bloc_state_managment/bloc_manage.dart';
import '../../presentation/bloc_state_managment/events.dart';
import '../components/constants/general_strings.dart';

class TheAppLanguage {
  static String appLanguage = 'en';

  static void updateLanguage(AppLanguage language) {
    appLanguage = language.appLanguage;
  }
}

abstract class AppLanguage {
  late String appLanguage;
}

class EnglishLanguage implements AppLanguage {
  @override
  String appLanguage = GeneralStrings.englishLanguage;
}

class NetherlandsLanguage implements AppLanguage {
  @override
  String appLanguage = GeneralStrings.netherlandsLanguage;
}

class ArabicLanguage implements AppLanguage {
  @override
  String appLanguage = GeneralStrings.arabicLanguage;
}

// Enum to define the available color themes.
enum ApplicationLanguage { en, nl, ar }

// Extension to retrieve the color manager based on the selected theme.
extension ApplicationLanguageExtension on ApplicationLanguage {
  AppLanguage get applanguage {
    switch (this) {
      case ApplicationLanguage.nl:
        return NetherlandsLanguage();
      case ApplicationLanguage.en:
        return EnglishLanguage();
      case ApplicationLanguage.ar:
        return ArabicLanguage();
      default:
        return EnglishLanguage();
    }
  }
}

// Helper class to manage theme-related operations.
class HandleAppLanguage {
  final EventsBloc bloc;

  HandleAppLanguage(this.bloc);

  // Sets the initial theme when the app starts.
  static void setInitialLanguage() {
    if (kDebugMode) {
      print("Setting initial theme...");
    }
    if (SharedPref.prefs.getString(GeneralStrings.appLanguage) == null) {
      AppLanguage language = ApplicationLanguage.en.applanguage;
      TheAppLanguage.updateLanguage(language);
    } else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) ==
        GeneralStrings.greenTheme) {
      AppLanguage language = ApplicationLanguage.en.applanguage;
      TheAppLanguage.updateLanguage(language);
    } else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) ==
        GeneralStrings.blueTheme) {
      AppLanguage language = ApplicationLanguage.en.applanguage;
      TheAppLanguage.updateLanguage(language);
    } else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) ==
        GeneralStrings.purpleTheme) {
      AppLanguage language = ApplicationLanguage.en.applanguage;
      TheAppLanguage.updateLanguage(language);
    }
    if (kDebugMode) {
      print("Initial theme set.");
    }
  }

  // Changes the color theme based on the selected event.
  static changeAppLanguage(ChangeLanguageEvent event) {
    AppLanguage appLanguage = event.applicationLanguage.applanguage;
    TheAppLanguage.updateLanguage(appLanguage);
  }
}
