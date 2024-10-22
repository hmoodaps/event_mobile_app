import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';

import '../constants/error_strings.dart';

firebaseAuthErrorsHandler({required event, required emit}) {
  FirebaseAuthException authException = event.error;

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
      emit(CreateUserStateError(
          ErrorStrings.accountExistsWithDifferentCredential));
      break;
    case 'email-already-in-use':
      emit(CreateUserStateError(ErrorStrings.emailAlreadyInUse));
      break;
    case 'weak-password':
      emit(CreateUserStateError(ErrorStrings.weakPassword));
      break;
    default:
      emit(CreateUserStateError(
          authException.message ?? ErrorStrings.unknownError));
  }
}

//firebase auth exceptions
// expired-action-code: Thrown if OTP in email link expires.
// invalid-email: Thrown if the email address is not valid.
// user-disabled: Thrown if the user corresponding to the given email has been disabled.
// operation-not-allowed: Thrown if anonymous accounts are not enabled. Enable anonymous accounts in the Firebase Console, under the Auth tab.
// user-disabled: Thrown if the user corresponding to the given email has been disabled.
// user-mismatch: Thrown if the credential given does not correspond to the user.
// user-not-found: Thrown if the credential given does not correspond to any existing user.
// invalid-credential: Thrown if the provider's credential is not valid. This can happen if it has already expired when calling link, or if it used invalid token(s). See the Firebase documentation for your provider, and make sure you pass in the correct parameters to the credential method.
// invalid-email: Thrown if the email used in a EmailAuthProvider.credential is invalid.
// wrong-password: Thrown if the password used in a EmailAuthProvider.credential is not correct or when the user associated with the email does not have a password.
// invalid-verification-code: Thrown if the credential is a PhoneAuthProvider.credential and the verification code of the credential is not valid.
// invalid-verification-id: Thrown if the credential is a PhoneAuthProvider.credential and the verification ID of the credential is not valid.
// account-exists-with-different-credential: Thrown if there already exists an account with the email address asserted by the credential. Resolve this by calling fetchSignInMethodsForEmail and then asking the user to sign in using one of the returned providers. Once the user is signed in, the original credential can be linked to the user with linkWithCredential.
// invalid-credential: Thrown if the credential is malformed or has expired.
// operation-not-allowed: Thrown if the type of account corresponding to the credential is not enabled. Enable the account type in the Firebase Console, under the Auth tab.
// user-disabled: Thrown if the user corresponding to the given credential has been disabled.
// user-not-found: Thrown if signing in with a credential from EmailAuthProvider.credential and there is no user corresponding to the given email.
// wrong-password: Thrown if signing in with a credential from EmailAuthProvider.credential and the password is invalid for the given email, or if the account corresponding to the email does not have a password set.
// invalid-verification-code: Thrown if the credential is a PhoneAuthProvider.credential and the verification code of the credential is not valid.
// invalid-verification-id: Thrown if the credential is a PhoneAuthProvider.credential and the verification ID of the credential is not valid.id.
// wrong-password: Thrown if the password is invalid for the given email, or the account corresponding to the email doesn't have a password set.
// invalid-email: Thrown if the email address is not valid.
// user-disabled: Thrown if the user corresponding to the given email has been disabled.
// user-not-found: Thrown if there is no user corresponding to the given email.
// email-already-in-use: Thrown if there already exists an account with the given email address.
// invalid-email: Thrown if the email address is not valid.
// operation-not-allowed: Thrown if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.
// weak-password: Thrown if the password is not strong enough.
