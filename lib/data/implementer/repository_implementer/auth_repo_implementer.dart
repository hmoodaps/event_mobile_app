import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../local_storage/shared_local.dart';
import '../failure_class/failure_class.dart';

class AuthImplementer implements AuthRepository{
  // Sign in with Google
  @override
  Future<Either<FailureClass, Either<bool , bool>>> signInWithGoogle() async {
    try {
      // Attempt to sign in with Google
      final GoogleSignInAccount? googleUser = await VariablesManager.googleSignIn.signIn();

      // // Check if googleUser is not null and get authentication details
      if (googleUser == null) {
        throw Exception("Google sign-in was cancelled or failed.");
      }
      //
      // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      //
      // final AuthCredential credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );

      // Save the user ID to SharedPreferences
      String userId = googleUser.id; // Extracting the user ID
      await SharedPref.prefs.setString(GeneralStrings.currentUser, userId);
      //check user Existing
      if(VariablesManager.userIds.contains(userId)) {
        //user already exist
        return Right(Right(true));
      } else{
        //user is new
        return Right(Left(false));
      }
    } catch (error) {
      return Left(FailureClass(error: error.toString())); // Return an error wrapped in a Left
    }
  }

  // Sign in with Apple
  @override
  Future<AuthCredential> signInWithApple() async {
    // Get Apple ID credentials
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email, // Request email scope
        AppleIDAuthorizationScopes.fullName, // Request full name scope
      ],
    );

    // Save the Apple user identity to SharedPreferences (using email or identityToken)
    SharedPref.prefs.setString(GeneralStrings.currentUser, appleCredential.email ?? appleCredential.identityToken!);

    // Create OAuth provider for Apple
    final oAuthProvider = OAuthProvider("apple.com");
    // Create credential using Apple ID tokens
    final credential = oAuthProvider.credential(
      idToken: appleCredential.identityToken, // Set the ID token
      accessToken: appleCredential.authorizationCode, // Set the authorization code
    );

    return credential; // Return the credentials
  }
}