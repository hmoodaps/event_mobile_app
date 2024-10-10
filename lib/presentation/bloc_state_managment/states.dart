abstract class AppStates {}

class InitialState extends AppStates {}



class StartCreateUserState extends AppStates {}
class CreateUserStateSuccess extends AppStates {}
class CreateUserStateError extends AppStates {String error ; CreateUserStateError(this.error);}


class AddUserToFirebaseState extends AppStates {}
class AddUserToFirebaseStateSuccess extends AppStates {}
class AddUserToFirebaseStateError extends AppStates {String error ; AddUserToFirebaseStateError(this.error);}


class LoginState extends AppStates {}
class LoginSuccessState extends AppStates {}
class LoginErrorState extends AppStates {String error ; LoginErrorState(this.error);}


class SignInWithGoogleState extends AppStates {}
class SignInWithGoogleStateSuccess extends AppStates {}
class SignInWithGoogleStateError extends AppStates {String error ; SignInWithGoogleStateError(this.error);}




