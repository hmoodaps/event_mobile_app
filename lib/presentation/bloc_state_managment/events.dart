import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  final Either<FirebaseFailureClass, UserCredential> result;
  CreatingUserResultEvent(this.req, this.result, {this.error});
}

// ----------- Login Events -----------
class LoginEvent extends AppEvents {
  final CreateUserRequirements req;
  LoginEvent(this.req);
}

class LoginResultEvent extends AppEvents {
  final String? error;
  final Either<FirebaseFailureClass, String> result;

  LoginResultEvent(this.result, {this.error});
}

// ----------- Google Sign-In Events -----------
class SignInWithGoogleEvent extends AppEvents {}

class SignInWithGoogleResultEvent extends AppEvents {
  final String? error;
  Either<FailureClass,  User > result;

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
  final Either<FirebaseFailureClass, void> result;
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
  final String error;
  AddUserDetailsErrorEvent(this.error);
}

class AddUserDetailsSuccessEvent extends AppEvents {}

class MoviesLoadedErrorEvent extends AppEvents {
  final String fail;
  MoviesLoadedErrorEvent(this.fail);
}

class MoviesLoadedSuccessEvent extends AppEvents {}

class FetchFirebaseErrorEvent extends AppEvents {
  final String fail;
  FetchFirebaseErrorEvent(this.fail);
}

class FetchFirebaseSuccessEvent extends AppEvents {}

class UserCreatedErrorEvent extends AppEvents {
  final FirebaseFailureClass fail;
  UserCreatedErrorEvent(this.fail);
}

class UserCreatedSuccessEvent extends AppEvents {
  User user ;
  UserCreatedSuccessEvent(this.user);
}

class LoginErrorEvent extends AppEvents {
  final FirebaseFailureClass fail;
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

class ChangeColorModeEvent extends AppEvents{
  AppColorsTheme appColorsTheme ;
  ChangeColorModeEvent(this.appColorsTheme);
}
class AppColorChangedEvent extends AppEvents{}
