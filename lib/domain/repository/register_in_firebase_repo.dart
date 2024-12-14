import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../local_models/models.dart';

abstract class RegisterInFirebaseRepo {
  Future<Either<FailureClass, UserCredential>> createUserAtFirebase({
    required CreateUserRequirements req,
  });

  Future<Either<FailureClass, void>> addUserToFirebase({
    required CreateUserRequirements req,
  });

  Future<Either<FailureClass, void>> createUserAtFirebaseWithCredential({
    required AuthCredential credential,
  });
}
