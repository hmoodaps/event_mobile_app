// ======== Abstract State ========
import 'package:dio/dio.dart';
import 'package:event_mobile_app/domain/models/movie_model/movie_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/model_objects/actor_model.dart';

abstract class AppStates {}

// ======== Initial State ========
class InitialState extends AppStates {}

// ----------- Logout States -----------
class LogoutState extends AppStates {}

// ----------- User Creation States -----------
class StartUserCreateState extends AppStates {}

class UserCreatedSuccessState extends AppStates {}

class UserCreatedErrorState extends AppStates {
  final String error;

  UserCreatedErrorState(this.error);
}

// ----------- Add User Details States -----------
class AddUsersDetailsState extends AppStates {}

class AddUserDetailsSuccessState extends AppStates {}

class StartRemovingItemFromFavesState extends AppStates {}

class StartAddingItemToFavesState extends AppStates {}

class AddUserDetailsErrorState extends AppStates {
  String error;

  AddUserDetailsErrorState(this.error);
}

// ----------- Login States -----------
class LoginState extends AppStates {}

class LoginSuccessState extends AppStates {}

class LoginErrorState extends AppStates {
  final String error;

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

class ChangeColorThemeState extends AppStates {
  int selectedColorIndex;

  ChangeColorThemeState({required this.selectedColorIndex});
}

class ChangeAppLanguageState extends AppStates {
  int selectedLanguageIndex;

  ChangeAppLanguageState({required this.selectedLanguageIndex});
}

class ChangeModeState extends AppStates {
  ChangeModeState();
}

//forget password
class ResetPasswordState extends AppStates {}

class ResetPasswordSuccessState extends AppStates {}

class ResetPasswordErrorState extends AppStates {
  String error;

  ResetPasswordErrorState(this.error);
}

class LoadPreferencesState extends AppStates {
  int selectedLanguageIndex;
  int selectedColorIndex;
  int? selectedModeIndex;

  LoadPreferencesState(
      {required this.selectedColorIndex,
      this.selectedModeIndex,
      required this.selectedLanguageIndex});
}

class ChangeModeThemeState extends AppStates {
  bool isManual;

  ChangeModeThemeState(this.isManual);
}

class StartChangingMode extends AppStates {}

class ShowNoInternetDialogState extends AppStates {}

class ExtractDominantColorState extends AppStates {}

class GetCurrentUserResponseState extends AppStates {}

class AddFilmToFavState extends AppStates {}

class GetFavesItemsState extends AppStates {}

class RemoveFilmFromFavState extends AppStates {}

class GetFavesItemsStateSuccessState extends AppStates {}

class RemoveFilmFromFav22State extends AppStates {}

class AddFilmToCartState extends AppStates {}

class GetCartItemsState extends AppStates {}

class RemoveFilmFromCartState extends AppStates {}

class GetCartItemsStateSuccessState extends AppStates {}

class FetchMoviesResultState extends AppStates {}

class FetchActorsSuccessState extends AppStates {
  final List<ActorModel> actors;

  FetchActorsSuccessState(this.actors);
}

class MakePaymentSuccessState extends AppStates {
  Response<dynamic> response ;//from dio
  MakePaymentSuccessState({required this.response});
}

class MakePaymentFailState extends AppStates {
  String error;

  MakePaymentFailState({required this.error});
}

class MakeReservationState extends AppStates{
  String ? error;
  String ? reservationCode ;
  MakeReservationState({this.reservationCode , this.error});
}

class AddBillsToFirebaseState extends AppStates{}
class GetMovieState extends AppStates{
  MovieResponse movieResponse ;
  GetMovieState({required this.movieResponse});
}

class GenerateBillRefNumState extends AppStates{
  String refNum;
  GenerateBillRefNumState({required this.refNum});
}