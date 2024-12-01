// Defines the green theme colors.

import 'package:flutter/foundation.dart';

import '../../data/local_storage/shared_local.dart';
import '../../presentation/bloc_state_managment/events.dart';
import '../components/constants/general_strings.dart';

abstract class TheAppLanguage {
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
  String appLanguage = 'en';
}class TurkishLanguage implements AppLanguage {
  @override
  String appLanguage = 'tr';
}

class NetherlandsLanguage implements AppLanguage {
  @override
  String appLanguage = 'nl';
}

class ArabicLanguage implements AppLanguage {
  @override
  String appLanguage = 'ar';
}

class FranchLanguage implements AppLanguage {
  @override
  String appLanguage = 'fr';
}

class SpanishLanguage implements AppLanguage {
  @override
  String appLanguage = 'es';
}

// Enum to define the available color themes.
enum ApplicationLanguage { en, nl, ar, fr, es , tr }

// Extension to retrieve the color manager based on the selected theme.
extension ApplicationLanguageExtension on ApplicationLanguage {
  AppLanguage get applanguage {
    switch (this) {
      case ApplicationLanguage.nl:
        return NetherlandsLanguage();
        case ApplicationLanguage.tr:
        return TurkishLanguage();
      case ApplicationLanguage.fr:
        return FranchLanguage();
      case ApplicationLanguage.es:
        return SpanishLanguage();
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
  // Sets the initial theme when the app starts.
  static void setInitialLanguage() {
    if (kDebugMode) {
      print("Setting initial theme...");
    }
    if (SharedPref.prefs.getString(GeneralStrings.appLanguage) == null) {
      AppLanguage language = ApplicationLanguage.en.applanguage;
      TheAppLanguage.updateLanguage(language);
    } else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) == 'en') {
      AppLanguage language = ApplicationLanguage.en.applanguage;
      TheAppLanguage.updateLanguage(language);
    } else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) == 'ar') {
      AppLanguage language = ApplicationLanguage.ar.applanguage;
      TheAppLanguage.updateLanguage(language);
    } else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) == 'nl') {
      AppLanguage language = ApplicationLanguage.nl.applanguage;
      TheAppLanguage.updateLanguage(language);
    } else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) == 'fr') {
      AppLanguage language = ApplicationLanguage.fr.applanguage;
      TheAppLanguage.updateLanguage(language);
    } else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) == 'es') {
      AppLanguage language = ApplicationLanguage.es.applanguage;
      TheAppLanguage.updateLanguage(language);
    }else if (SharedPref.prefs.getString(GeneralStrings.appLanguage) == 'tr') {
      AppLanguage language = ApplicationLanguage.tr.applanguage;
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
