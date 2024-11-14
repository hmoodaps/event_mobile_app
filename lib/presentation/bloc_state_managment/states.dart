import 'package:flutter/material.dart';

abstract class AppStates {}

class InitialState extends AppStates {}

class StartCreateUserState extends AppStates {}

class CreateUserStateSuccess extends AppStates {}

class CreateUserStateError extends AppStates {
  final String error;
  CreateUserStateError(this.error);
}

class AddUserToFirebaseState extends AppStates {}

class AddUserToFirebaseStateSuccess extends AppStates {}

class AddUserToFirebaseStateError extends AppStates {
  final String error;
  AddUserToFirebaseStateError(this.error);
}

class LoginState extends AppStates {}

class LoginSuccessState extends AppStates {}

class LoginErrorState extends AppStates {
  final String error;
  LoginErrorState(this.error);
}

class SignInWithGoogleState extends AppStates {}

class SignInWithGoogleStateSuccess extends AppStates {}

class SignInWithGoogleStateError extends AppStates {
  final String error;
  SignInWithGoogleStateError(this.error);
}

class SignInWithGoogleUserExist extends AppStates {}

class SignInWithGoogleUserNotExist extends AppStates {}

class ChangeNavigationBarIndexState extends AppStates {}

class ToggleToLightState extends AppStates {
  ThemeData themeData ;
  ToggleToLightState(this.themeData);
}
class ToggleToDarkState extends AppStates {
  ThemeData themeData ;
  ToggleToDarkState(this.themeData);

}
class ToggleLightAndDarkState extends AppStates {}


class StartFetchMoviesState extends AppStates {}

class MoviesLoadedState extends AppStates {}

class InitFetchMoviesErrorState extends AppStates {
  final String error;
  InitFetchMoviesErrorState(this.error);
}

class StartFetchFirebaseState extends AppStates {}

class InitFetchFirebaseState extends AppStates {}

class InitFetchFirebaseErrorState extends AppStates {
  final String error;
  InitFetchFirebaseErrorState(this.error);
}

class DisconnectedState extends AppStates {}

class ConnectedState extends AppStates {}

