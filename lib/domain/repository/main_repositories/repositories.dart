import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/implementer/failure_class/failure_class.dart';
import '../../../data/models/movie_model.dart';
import '../../local_models/models.dart';

abstract class Repositories {
  // Logs a user into Firebase
  Future<Either<FirebaseFailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req});

  // Creates a user in Firebase
  Future<Either<FirebaseFailureClass, UserCredential>> createUserAtFirebase(
      {required CreateUserRequirements req});

  // Adds a user to Firestore
  Future<Either<FirebaseFailureClass, void>> addUserToFirebase(
      {required CreateUserRequirements req});

  // Initializes Firebase and fetches user IDs
  Future<Either<FailureClass, List<String>>> initFirebase();

  // Fetches movies
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies();

  // Updates user details
  Future<Either<FirebaseFailureClass, void>> addUserDetails(
      {required CreateUserRequirements req});

  // Creates a user in Firebase using credentials
  Future<Either<FirebaseFailureClass, User>> createUserAtFirebaseWithCredential(
      {required AuthCredential credential});

  Future<void> logout();
}
