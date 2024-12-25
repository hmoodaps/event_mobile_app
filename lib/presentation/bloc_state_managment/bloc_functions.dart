import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mobile_app/domain/model_objects/actor_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
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
  changeColorMode(ChangeColorModeEvent event, BuildContext context) {
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
    }
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

  // Caches images associated with movies
// This function is used to cache the images of movies by initializing CachedNetworkImageProvider instances
// for each movie's image (both the main and vertical images).
  Future<void> getActorsPhotos(List<ActorModel> actors) async {
    // Preload images into cache using precacheImage
    // The images are first wrapped in CachedNetworkImageProvider, then they are stored in memory.
    // Preload the images without displaying them to the user (in the background)
    // This ensures the images are cached and ready to be shown without delay.

    final actorsCopy = List<ActorModel>.from(actors); // Create a copy
    for (ActorModel actor in actorsCopy) {
      await precacheImage(CachedNetworkImageProvider(actor.imageSource),
          navigatorKey.currentContext!);
    }
  }
}
