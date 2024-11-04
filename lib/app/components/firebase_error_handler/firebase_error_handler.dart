import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/implementer/failure_class/failure_class.dart';
import '../../../presentation/bloc_state_managment/states.dart';
import '../constants/error_strings.dart';

firebaseAuthErrorsHandler({required FirebaseFailureClass failure, required emit}) {
  FirebaseAuthException? authException = failure.authException;

  if (authException != null) {
    switch (authException.code) {
      case 'expired-action-code':
        emit(CreateUserStateError(ErrorStrings.expiredActionCode));
        break;
      case 'invalid-email':
        emit(CreateUserStateError(ErrorStrings.invalidEmail));
        break;
      case 'user-disabled':
        emit(CreateUserStateError(ErrorStrings.userDisabled));
        break;
      case 'operation-not-allowed':
        emit(CreateUserStateError(ErrorStrings.operationNotAllowed));
        break;
      case 'user-mismatch':
        emit(CreateUserStateError(ErrorStrings.userMismatch));
        break;
      case 'user-not-found':
        emit(CreateUserStateError(ErrorStrings.userNotFound));
        break;
      case 'invalid-credential':
        emit(CreateUserStateError(ErrorStrings.invalidCredential));
        break;
      case 'wrong-password':
        emit(CreateUserStateError(ErrorStrings.wrongPassword));
        break;
      case 'invalid-verification-code':
        emit(CreateUserStateError(ErrorStrings.invalidVerificationCode));
        break;
      case 'invalid-verification-id':
        emit(CreateUserStateError(ErrorStrings.invalidVerificationId));
        break;
      case 'account-exists-with-different-credential':
        emit(CreateUserStateError(ErrorStrings.accountExistsWithDifferentCredential));
        break;
      case 'email-already-in-use':
        emit(CreateUserStateError(ErrorStrings.emailAlreadyInUse));
        break;
      case 'weak-password':
        emit(CreateUserStateError(ErrorStrings.weakPassword));
        break;
      default:
        emit(CreateUserStateError(ErrorStrings.unknownError));
    }
  }
}
