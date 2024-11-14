import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../local_models/models.dart';

abstract class RegisterInFirebaseRepo{
  Future<Either<FirebaseFailureClass, UserCredential>> createUserAtFirebase({
    required CreateUserRequirements req,
  });

  Future<Either<FirebaseFailureClass, void>> addUserToFirebase({
    required CreateUserRequirements req,
  });
}