import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../local_models/models.dart';

abstract class RegisterInFirebaseRepo {
  Future<Either<FailureClass, Map<String , dynamic>>> createUserAtFirebase({
    required CreateUserRequirements req,
  });

  Future<Either<FailureClass, void>> addUserToFirebase({
    required CreateUserRequirements req,
  });

  Future<Either<FailureClass, Map<String, dynamic>>> createUserAtFirebaseWithCredential({
    required AuthCredential credential,
  });

  Future<String> createGuest(String id);
}
