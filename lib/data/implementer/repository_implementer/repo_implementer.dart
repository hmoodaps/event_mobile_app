import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../../../domain/local_models/models.dart';
import '../../../domain/repository/repository.dart';
import '../../models/movie_model.dart';
import '../../models/user_model.dart';
import '../../network_data_handler/rest_api/rest_api_dio.dart';
import '../failure_class/failure_class.dart';

class RepositoryImplementer implements Repository {
  final DioClient _dioClient; // Client for making API requests

  RepositoryImplementer(this._dioClient); // Constructor to initialize the Dio client

  // Fetch movies from the API
  @override
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies() async {
    VariablesManager.movies.clear(); // Clear the existing movie list
    try {
      // Call the API to fetch movies
      final response = await _dioClient.getMovies();
      VariablesManager.movies.addAll(response); // Store the movies in the manager
      return Right(VariablesManager.movies); // Return the movies on success
    } catch (error) {
      return Left(FailureClass(error: error.toString())); // Return the error if any
    }
  }



  // Navigate to the main route of the application
  @override
  navigatorToTheMain(context) {
    navigateTo(context!, RouteStringsManager.mainRoute); // Navigate to main route
  }

  // Sign in with Google
  @override
  Future<Either<FailureClass, AuthCredential>> signWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await VariablesManager.googleSignIn.signIn(); // Sign in with Google
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication; // Get Google authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, // Set the access token
        idToken: googleAuth.idToken, // Set the ID token
      );
      return Right(credential); // Return the credentials on success
    } catch (error) {
      return Left(FailureClass(error: error.toString())); // Return the error if any
    }
  }

  // Sign in with Apple
  @override
  Future<AuthCredential> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential( // Get Apple ID credentials
      scopes: [
        AppleIDAuthorizationScopes.email, // Request email scope
        AppleIDAuthorizationScopes.fullName, // Request full name scope
      ],
    );

    final oAuthProvider = OAuthProvider("apple.com"); // Create OAuth provider for Apple

    final credential = oAuthProvider.credential(
      idToken: appleCredential.identityToken, // Set the ID token
      accessToken: appleCredential.authorizationCode, // Set the authorization code
    );
    return credential; // Return the credentials
  }

  // Create a new user in Firebase
  @override
  Future<Either<FirebaseFailureClass, UserCredential>> createUserAtFirebase({required CreateUserRequirements req}) async {
    try {
      // Create user with email and password
      UserCredential credential = await VariablesManager.auth.createUserWithEmailAndPassword(
          email: req.email, password: req.password);
      return Right(credential); // Return the user credential on success
    } catch (error) {
      return Left(FirebaseFailureClass(authException: error as FirebaseAuthException)); // Return Firebase exception
    }
  }

  // Add user details to Firestore
  @override
  Future<Either<FirebaseFailureClass, void>> addUserToFirebase({
    required String? email,
    required String? fullName,
    String? uid,
    String? userPhotoUrl,
  }) async {
    UserResponse userResponse = UserResponse(
      email: email,
      fullName: fullName,
      id: uid,
      userPhotoUrl: userPhotoUrl,
    );

    try {
      // Check if the user ID already exists before adding
      if (!VariablesManager.userIds.contains(userResponse.id)) {
        await FirebaseFirestore.instance
            .collection(GeneralStrings.users) // Reference the users collection
            .doc(VariablesManager.currentUser!.uid) // Use the current user's UID as the document ID
            .set(userResponse.toJson());
      }
      return Right(null); // Return success with no data
    } catch (error) {
      return Left(FirebaseFailureClass(authException: error as FirebaseAuthException)); // Return the error if any
    }
  }


  // Initialize Firebase and fetch user IDs
  @override
  Future<Either<FailureClass, List<String>>> initFirebase() async {
    VariablesManager.userIds.clear() ;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(GeneralStrings.users).get(); // Get users collection
      for (var doc in snapshot.docs) {
        VariablesManager.userIds.add(doc.id); // Add each user ID to the list
      }
      return Right(VariablesManager.userIds); // Return the list of IDs on success
    } catch (error) {
      return Left(FailureClass(error: error.toString())); // Return the error if any
    }
  }

  @override
  Future<Either<FirebaseFailureClass, String>> loginToFirebase() {
    // TODO: implement loginToFirebase
    throw UnimplementedError();
  }


}
