import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_stripe_payment/easy_stripe_payment.dart';
import 'package:event_mobile_app/app/components/constants/dio_and_mapper_constants.dart';
import 'package:event_mobile_app/data/mapper/mapper.dart';
import 'package:event_mobile_app/data/network_data_handler/rest_api/dio_logger.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:flutter/material.dart';
import '../../app/components/constants/general_strings.dart';
import '../../app/components/constants/variables_manager.dart';
import '../../app/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import '../../app/handle_app_language/handle_app_language.dart';
import '../../app/handle_app_theme/handle_app_theme_colors.dart';
import '../../data/local_storage/shared_local.dart';
import '../../domain/models/model_objects/actor_model.dart';
import '../../domain/models/movie_model/movie_model.dart';
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
    // Use switch to handle setting the language
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
      case ApplicationLanguage.ru:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'ru');
        break;
      case ApplicationLanguage.it:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'it');
        break;
      case ApplicationLanguage.de:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'de');
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
        await precacheImage(CachedNetworkImageProvider(movie.vertical_photo!),
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

  Future<Either<String, Response<dynamic>>> makePayment(double amount,
      {String? clientEmail, String? description}) async {
    return await EasyStripePayment.instance.makePayment(
        amount: amount,
        clientEmail: clientEmail ?? "",
        description: description ?? "",
        currency: "eur");
  }

 Future<Either<String,String>> makeReservation(
      {required String guest_id,
      required int movie_id,
      required int showtime_id,
      required List<int> seat_numbers}) async{
    String reservationId="";
    try{
      await createDio().post(
        AppConstants.create_reservation,
        data: {
          "guest_id": guest_id,
          "movie_id": movie_id,
          "showtime_id": showtime_id,
          "seat_numbers": seat_numbers
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization":"token ${VariablesManager.currentUserResponse.token}"
          },
        ),
      ).then((value) {
        reservationId = value.data["reservation_code"];
      },);
      return Right(reservationId)  ;
    }catch (e){
      log(e.toString());
      return Left(e.toString());
    }
  }

  Future<MovieResponse> getMovie(
      {required int movieId,
}) async{
    try{
  final response = await createDio().get(
        AppConstants.getOneMovie(movieId: movieId),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization":"token ${VariablesManager.currentUserResponse.token}"
          },
        ),
      );
    final movieResponse = MovieResponse.fromJson(response.data! );
    return movieResponse.toDomain();

    }catch (e){
      throw Exception("error while getting movie ${e.toString()}");
    }
  }


}
