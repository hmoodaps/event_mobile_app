import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/components/constants/general_strings.dart';
import '../../app/components/constants/variables_manager.dart';
import '../../app/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import '../../app/handle_app_language/handle_app_language.dart';
import '../../app/handle_app_theme/handle_app_theme_colors.dart';
import '../../data/local_storage/shared_local.dart';
import '../../data/models/movie_model.dart';
import '../../main.dart';

class BlocFunctions {
  getCartItems() async {}

  getFavesItems() async {}

  changeColorMode(ChangeColorModeEvent event) {
    // Change the color theme using the helper
    AppColorHelper.changeColorTheme(event);

    // Use switch to handle setting the color theme
    switch (event.appColorsTheme) {
      case AppColorsTheme.green:
        SharedPref.prefs.setString(GeneralStrings.colorTheme, 'green');
        break;

      case AppColorsTheme.blue:
        SharedPref.prefs.setString(GeneralStrings.colorTheme, 'blue');
        break;

      case AppColorsTheme.purple:
        SharedPref.prefs.setString(GeneralStrings.colorTheme, 'purple');
        break;

      default:
        // Optional: handle unknown themes if needed
        break;
    }
  }

  changeLanguage(ChangeLanguageEvent event) {
    HandleAppLanguage.changeAppLanguage(event);
    // Use switch to handle setting the color theme
    switch (event.applicationLanguage) {
      case ApplicationLanguage.en:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'en');
        break;
      case ApplicationLanguage.tr:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'tr');
        break;
      case ApplicationLanguage.fr:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'fr');
        break;
      case ApplicationLanguage.es:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'es');
        break;
      case ApplicationLanguage.nl:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'nl');
        break;
      case ApplicationLanguage.ar:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'ar');
        break;

      default:
        // Optional: handle unknown themes if needed
        break;
    }
  }

  ThemeData checkIfModeManual() {
    ThemeData themeData =
        TheAppMode.appMode; // Use the saved theme mode (light or dark).
    // Check if the event's theme is dark or light, and update the dark mode flag accordingly.
    if (themeData == AppTheme.dark.themeData) {
      VariablesManager.isDark = true;
    } else {
      VariablesManager.isDark = false;
    }
    return themeData;
  }

  ThemeData checkLightAndDarkMode(BuildContext context) {
    ThemeData? themeData;
    // Automatically set the theme based on device's current brightness (light/dark mode)
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    brightness == Brightness.dark
        ? (themeData =
            AppTheme.dark.themeData) // Set dark theme if device is dark mode.
        : (themeData = AppTheme.light.themeData); // Otherwise, set light theme.

    // For debugging, print the current theme
    if (kDebugMode) {
      print(VariablesManager.isDark ? "dark" : 'light');
    }
    if (themeData == AppTheme.dark.themeData) {
      VariablesManager.isDark = true;
    } else {
      VariablesManager.isDark = false;
    }
    return themeData;
  }

  changeMode(ChangeModeEvent event) {
    // Update the app theme mode based on the event.
    TheAppMode.updateMode(event.appMode);

    // Store the selected theme in shared preferences (for persistence)
    switch (event.appMode) {
      case AppTheme.light:
        SharedPref.prefs
            .setString(GeneralStrings.appMode, 'light'); // Save light mode.
        break;
      case AppTheme.dark:
        SharedPref.prefs
            .setString(GeneralStrings.appMode, 'dark'); // Save dark mode.
        break;
      default:
        // Handle unknown theme modes (optional, if required).
        break;
    }
  }

  // Caches images associated with movies
// This function is used to cache the images of movies by initializing CachedNetworkImageProvider instances
// for each movie's image (both the main and vertical images).
  Future<void> getPhotos(List<MovieResponse> movies) async {
    // Preload images into cache using precacheImage
    // The images are first wrapped in CachedNetworkImageProvider, then they are stored in memory.
    // Preload the images without displaying them to the user (in the background)
    // This ensures the images are cached and ready to be shown without delay.

    final moviesCopy = List<MovieResponse>.from(movies); // Create a copy
    if (VariablesManager.isFirstTimeOpened) {
      for (MovieResponse movie in moviesCopy) {
        await precacheImage(CachedNetworkImageProvider(movie.photo!),
            navigatorKey.currentContext!);
        await precacheImage(CachedNetworkImageProvider(movie.verticalPhoto!),
            navigatorKey.currentContext!);
      }
    }
  }
}
