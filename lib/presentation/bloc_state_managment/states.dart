// ======== Abstract State ========
import 'package:firebase_auth/firebase_auth.dart';

abstract class AppStates {}

// ======== Initial State ========
class InitialState extends AppStates {}

// ----------- Logout States -----------
class LogoutState extends AppStates {}

// ----------- User Creation States -----------
class StartUserCreateState extends AppStates {}

class UserCreatedSuccessState extends AppStates {}

class UserCreatedErrorState extends AppStates {
  final FirebaseException error;

  UserCreatedErrorState(this.error);
}

// ----------- Add User Details States -----------
class AddUsersDetailsState extends AppStates {}

class AddUserDetailsSuccessState extends AppStates {}

class AddUserDetailsErrorState extends AppStates {
  FirebaseException error;

  AddUserDetailsErrorState(this.error);
}

// ----------- Login States -----------
class LoginState extends AppStates {}

class LoginSuccessState extends AppStates {}

class LoginErrorState extends AppStates {
  final FirebaseException error;

  LoginErrorState(this.error);
}

// ----------- Google Sign-In States -----------
class StartSignInWithGoogleState extends AppStates {}

class SignInWithGoogleStateSuccess extends AppStates {
  User user;

  SignInWithGoogleStateSuccess(this.user);
}

class SignInWithGoogleStateError extends AppStates {
  final String error;

  SignInWithGoogleStateError(this.error);
}

// ----------- Movie Fetching States -----------
class StartFetchMoviesState extends AppStates {}

class SignInWithGoogleUserExistState extends AppStates {}

class MoviesLoadedSuccessState extends AppStates {}

class MoviesLoadedErrorState extends AppStates {
  final String error;

  MoviesLoadedErrorState(this.error);
}

// ----------- Navigation Bar States -----------
class ChangeNavigationBarIndexState extends AppStates {}

// ----------- Theme Toggle States -----------
class ToggleLightAndDarkState extends AppStates {}

// ----------- Firebase Initialization States -----------
class StartFetchFirebaseState extends AppStates {}

class FetchFirebaseSuccessState extends AppStates {}

class FetchFirebaseErrorState extends AppStates {
  final String error;

  FetchFirebaseErrorState(this.error);
}

// ----------- Connectivity States -----------
class DisconnectedState extends AppStates {}

class ConnectedState extends AppStates {}
// ----------- App theme color -----------

class ChangeColorThemeState extends AppStates {}

class ChangeAppLanguageState extends AppStates {}

//forget password
class ResetPasswordState extends AppStates {}

class ResetPasswordSuccessState extends AppStates {}

class ResetPasswordErrorState extends AppStates {
  FirebaseException error;

  ResetPasswordErrorState(this.error);
}
