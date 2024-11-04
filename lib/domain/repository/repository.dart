import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/data/implementer/failure_class/failure_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/movie_model.dart';
import '../local_models/models.dart';

abstract class Repository {
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies();

  navigatorToTheMain(context);

  Future<Either<FailureClass, AuthCredential>> signWithGoogle(context);

  Future<AuthCredential> signInWithApple();

  Future<Either<FirebaseFailureClass, UserCredential>> createUserAtFirebase(
      {required CreateUserRequirements req});

  Future<Either<FirebaseFailureClass, void>> addUserToFirebase(
      {required String? email,
        required String? fullName,
        String? uid,
        String? userPhotoUrl});

  Future<Either<FailureClass, List<String>>> initFirebase();
  Future<Either<FirebaseFailureClass, String>> loginToFirebase();
}
