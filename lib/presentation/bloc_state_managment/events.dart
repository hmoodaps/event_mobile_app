import 'package:firebase_auth/firebase_auth.dart';

abstract class AppEvents {}
//create user events handle
class StartCreateUserEvent extends AppEvents {}
class CreateUserEventSuccess extends AppEvents {}
class CreateUserEventError extends AppEvents {FirebaseAuthException error ; CreateUserEventError(this.error);}

//add user events handle

class AddUserToFirebaseEvent extends AppEvents {}
class AddUserToFirebaseEventSuccess extends AppEvents {}
class AddUserToFirebaseEventError extends AppEvents {FirebaseAuthException error ; AddUserToFirebaseEventError(this.error);}

//login events handle
class LoginEvent extends AppEvents {}
class LoginSuccessEvent extends AppEvents {}
class LoginErrorEvent extends AppEvents {FirebaseAuthException error ; LoginErrorEvent(this.error);}

//Sign In With Google handle
class SignInWithGoogleEvent extends AppEvents {}
class SignInWithGoogleEventSuccess extends AppEvents {}
class SignInWithGoogleEventError extends AppEvents {FirebaseAuthException error ; SignInWithGoogleEventError(this.error);}

//change navigation bar index
class ChangeNavigationBarIndexEvent extends AppEvents {}

//Toggle Light And Dark
class ToggleLightAndDarkEvent extends AppEvents {}

//fetch init data firebase and movies
class StartFetchMoviesEvent extends AppEvents {}
class InitFetchMoviesEvent extends AppEvents {}
class InitFetchMoviesErrorEvent extends AppEvents {String error ; InitFetchMoviesErrorEvent(this.error);}

class StartFetchFirebaseEvent extends AppEvents {}
class InitFetchFirebaseEvent extends AppEvents {}
class InitFetchFirebaseErrorEvent extends AppEvents {String error ; InitFetchFirebaseErrorEvent(this.error);}
