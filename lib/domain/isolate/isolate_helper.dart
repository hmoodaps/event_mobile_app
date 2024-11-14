import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../../data/models/movie_model.dart';
import '../local_models/models.dart';

abstract class IsolateHelper{
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies();
  Future<Either<FailureClass, List<String>>> initFirebase();
  Future<Either<FirebaseFailureClass, UserCredential>> createUserAtFirebase({
    required CreateUserRequirements req,
  });

  Future<Either<FirebaseFailureClass, void>> addUserToFirebase({
    required CreateUserRequirements req,
  });
  Future<Either<FirebaseFailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req});
}