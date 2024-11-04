abstract class AppStates {}
// init state
class InitialState extends AppStates {}
//create user events handle

class StartCreateUserState extends AppStates {}

class CreateUserStateSuccess extends AppStates {}

class CreateUserStateError extends AppStates {
  String error;

  CreateUserStateError(this.error);
}


//add user to firebase states
class AddUserToFirebaseState extends AppStates {}

class AddUserToFirebaseStateSuccess extends AppStates {}

class AddUserToFirebaseStateError extends AppStates {
  String error;

  AddUserToFirebaseStateError(this.error);
}

//login to firebase states
class LoginState extends AppStates {}

class LoginSuccessState extends AppStates {}

class LoginErrorState extends AppStates {
  String error;

  LoginErrorState(this.error);
}

//sign in or login by google states
class SignInWithGoogleState extends AppStates {}

class SignInWithGoogleStateSuccess extends AppStates {}

class SignInWithGoogleStateError extends AppStates {
  String error;

  SignInWithGoogleStateError(this.error);
}
// Change Navigation Bar Index States
class ChangeNavigationBarIndexState extends AppStates {}


//toggle between light and dark mood states

class ToggleLightAndDarkState extends AppStates {}
//fitch movies states
class StartFetchMoviesState extends AppStates {}

class InitFetchMoviesState extends AppStates {}

class InitFetchMoviesErrorState extends AppStates {
  String error;

  InitFetchMoviesErrorState(this.error);
}

//fetch firebase states
class StartFetchFirebaseState extends AppStates {}

class InitFetchFirebaseState extends AppStates {}

class InitFetchFirebaseErrorState extends AppStates {
  String error;

  InitFetchFirebaseErrorState(this.error);
}
//handel InternetConnection States
class DisconnectedState extends AppStates{}
class ConnectedState extends AppStates{}