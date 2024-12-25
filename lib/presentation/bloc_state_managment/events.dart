import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import 'package:event_mobile_app/domain/model_objects/actor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/handle_app_language/handle_app_language.dart';
import '../../app/handle_app_theme/handle_app_theme_colors.dart';
import '../../data/implementer/failure_class/failure_class.dart';
import '../../data/models/movie_model.dart';
import '../../domain/local_models/models.dart';

abstract class AppEvents {}

// ----------- User Creation Events -----------
class StartCreateUserEvent extends AppEvents {
  final CreateUserRequirements req;

  StartCreateUserEvent(this.req);
}

class CreatingUserResultEvent extends AppEvents {
  final String? error;
  final CreateUserRequirements req;
  final Either<FailureClass, UserCredential> result;

  CreatingUserResultEvent(this.req, this.result, {this.error});
}

// ----------- Login Events -----------
class LoginEvent extends AppEvents {
  final CreateUserRequirements req;

  LoginEvent(this.req);
}

class LoginResultEvent extends AppEvents {
  final String? error;
  final Either<FailureClass, String> result;

  LoginResultEvent(this.result, {this.error});
}

// ----------- Google Sign-In Events -----------
class SignInWithGoogleEvent extends AppEvents {}

class SignInWithGoogleResultEvent extends AppEvents {
  final String? error;
  Either<FailureClass, User> result;

  SignInWithGoogleResultEvent(this.result, {this.error});
}

// ----------- Movie Fetching Events -----------
class StartFetchMoviesEvent extends AppEvents {}

class FetchMoviesResultEvent extends AppEvents {
  final String? error;
  Either<FailureClass, List<MovieResponse>> result;

  FetchMoviesResultEvent(this.result, {this.error});
}

// ----------- Firebase Initialization Events -----------
class StartFetchFirebaseEvent extends AppEvents {}

class FetchFirebaseResultEvent extends AppEvents {
  final String? error;
  Either<FailureClass, List<String>> result;

  FetchFirebaseResultEvent(this.result, {this.error});
}

// ----------- Add User Details Events -----------
class AddUserDetailsEvent extends AppEvents {
  CreateUserRequirements req;

  AddUserDetailsEvent({required this.req});
}

class AddUserDetailsResultEvent extends AppEvents {
  final Either<FailureClass, void> result;

  AddUserDetailsResultEvent(this.result);
}

// ----------- Connectivity Events -----------
class InternetStatusChangeEvent extends AppEvents {}

// ----------- Logout Events -----------
class LogoutEvent extends AppEvents {}

// ----------- Navigation Bar Events -----------
class ChangeNavigationBarIndexEvent extends AppEvents {}

// ----------- Theme Toggle Events -----------
class ToggleLightAndDarkEvent extends AppEvents {
  ThemeData themeData;

  ToggleLightAndDarkEvent(this.themeData);
}

// ----------- Additional Add User Details Events -----------
class AddUserDetailsErrorEvent extends AppEvents {
  final FirebaseException error;

  AddUserDetailsErrorEvent(this.error);
}

class AddUserDetailsSuccessEvent extends AppEvents {}

class MoviesLoadedErrorEvent extends AppEvents {
  final String fail;

  MoviesLoadedErrorEvent(this.fail);
}

class MoviesLoadedSuccessEvent extends AppEvents {}

class FetchFirebaseErrorEvent extends AppEvents {
  final FirebaseException fail;

  FetchFirebaseErrorEvent(this.fail);
}

class FetchFirebaseSuccessEvent extends AppEvents {}

class UserCreatedErrorEvent extends AppEvents {
  final FirebaseException fail;

  UserCreatedErrorEvent(this.fail);
}

class UserCreatedSuccessEvent extends AppEvents {
  User user;

  UserCreatedSuccessEvent(this.user);
}

class LoginErrorEvent extends AppEvents {
  final FirebaseException fail;

  LoginErrorEvent(this.fail);
}

class LoginSuccessEvent extends AppEvents {}

class AddUserToFirebaseEvent extends AppEvents {}

class SignInWithGoogleUserNotExistEvent extends AppEvents {
  User user;

  SignInWithGoogleUserNotExistEvent(this.user);
}

class SignInWithGoogleUserExistEvent extends AppEvents {}

class SignInWithGoogleEventError extends AppEvents {
  final String fail;

  SignInWithGoogleEventError(this.fail);
}

class SignInWithGoogleEventSuccess extends AppEvents {
  final User user;

  SignInWithGoogleEventSuccess(this.user);
}

class ChangeColorModeEvent extends AppEvents {
  AppColorsTheme appColorsTheme;
  int selectedColorIndex;
  BuildContext context;

  ChangeColorModeEvent(
      {required this.appColorsTheme,
      required this.selectedColorIndex,
      required this.context});
}

class ChangeLanguageEvent extends AppEvents {
  ApplicationLanguage applicationLanguage;
  int selectedLanguageIndex;

  ChangeLanguageEvent(
      {required this.applicationLanguage, required this.selectedLanguageIndex});
}

//forget password
class ResetPasswordEvent extends AppEvents {
  String email;

  ResetPasswordEvent(this.email);
}

class ResetPasswordSuccessEvent extends AppEvents {}

class ResetPasswordErrorEvent extends AppEvents {
  FirebaseException error;

  ResetPasswordErrorEvent(this.error);
}

class LoadPreferencesEvent extends AppEvents {
  int selectedLanguageIndex;
  int selectedColorIndex;
  int? selectedModeIndex;

  LoadPreferencesEvent(
      {required this.selectedColorIndex,
      this.selectedModeIndex,
      required this.selectedLanguageIndex});
}

class ToLogoutEvent extends AppEvents {}

class ExtractDominantColorEvent extends AppEvents {}

class ShowNoInternetDialog extends AppEvents {}

class GetCurrentUserResponseEvent extends AppEvents {}

class ChangeModeEvent extends AppEvents {
  AppTheme appMode;

  ChangeModeEvent(
    this.appMode,
  );
}

class ChangeModeThemeEvent extends AppEvents {
  bool isManual;

  ChangeModeThemeEvent(this.isManual);
}

class RemoveFilmFromFavEvent extends AppEvents {
  MovieResponse movie;

  RemoveFilmFromFavEvent(this.movie);
}

class AddFilmToFavEvent extends AppEvents {
  MovieResponse movie;

  AddFilmToFavEvent(this.movie);
}

class GetFavesItemsEvent extends AppEvents {}

class GetFavesItemsStateSuccessEvent extends AppEvents {}

class RemoveFilmFromCartEvent extends AppEvents {
  MovieResponse movie;

  RemoveFilmFromCartEvent(this.movie);
}

class AddFilmToCartEvent extends AppEvents {
  MovieResponse movie;

  AddFilmToCartEvent(this.movie);
}

class GetCartItemsEvent extends AppEvents {}

class GetCartItemsStateSuccessEvent extends AppEvents {}
class GetActorsPhotosEvent extends AppEvents {
  final List<ActorModel> actors ;
  GetActorsPhotosEvent({required this.actors});

}

class FetchActorsDataEvent extends AppEvents {
  final List<String> actors ;
  FetchActorsDataEvent({required this.actors});
}
