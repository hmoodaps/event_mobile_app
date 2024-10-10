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

