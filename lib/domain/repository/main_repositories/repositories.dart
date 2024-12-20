import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/implementer/failure_class/failure_class.dart';
import '../../../data/models/movie_model.dart';
import '../../local_models/models.dart';

abstract class Repositories {
  // Logs a user into Firebase using provided requirements
  Future<Either<FailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req});

  // Creates a new user in Firebase with given requirements
  Future<Either<FailureClass, UserCredential>> createUserAtFirebase(
      {required CreateUserRequirements req});

  // Adds a new user to Firestore database
  Future<Either<FailureClass, void>> addUserToFirebase(
      {required CreateUserRequirements req});

  // Initializes Firebase services and retrieves user IDs
  Future<Either<FailureClass, List<String>>> initFirebase();

  // Retrieves a list of movies from the database or API
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies();

  // Updates user details in the Firestore database
  Future<Either<FailureClass, void>> addUserDetails(
      {required CreateUserRequirements req});

  // Creates a new user in Firebase using an authentication credential
  Future<Either<FailureClass, User>> createUserAtFirebaseWithCredential(
      {required AuthCredential credential});

  // Logs the current user out of the application
  Future<Either<FailureClass, void>> logout();

  // Sends a password reset email to the provided email address
  Future<Either<FailureClass, void>> forgetPassword(String email);

  // Adds a film to the user's list of favorites
  Future<Either<FailureClass, void>> addFilmToFavorites(
      {required MovieResponse movie});

  // Removes a film from the user's list of favorites
  Future<Either<FailureClass, void>> removeFilmFromFavorites(
      {required MovieResponse movie});

  // Retrieves the details of the currently logged-in user
  Future<Either<FailureClass, UserResponse>> getCurrentUserResponse();

  // Adds a film to the user's cart
  Future<Either<FailureClass, void>> addFilmToCart(
      {required MovieResponse movie});

  // Removes a film from the user's cart
  Future<Either<FailureClass, void>> removeFilmFromCart(
      {required MovieResponse movie});
}
