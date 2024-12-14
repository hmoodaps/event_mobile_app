import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/local_models/models.dart';
import '../../../domain/repository/main_repositories/repositories.dart';
import '../../../domain/repository/register_in_firebase_repo.dart';
import '../failure_class/failure_class.dart';

class RegisterImplementer implements RegisterInFirebaseRepo {
  Repositories repo;

  RegisterImplementer({
    required this.repo,
  });

  // Create a new user in Firebase
  @override
  Future<Either<FailureClass, UserCredential>> createUserAtFirebase(
      {required CreateUserRequirements req}) async {
    return await repo.createUserAtFirebase(req: req);
  }

  // Add user details to Firestore
  @override
  Future<Either<FailureClass, void>> addUserToFirebase(
      {required CreateUserRequirements req}) async {
    return await repo.addUserToFirebase(req: req);
  }

  @override
  Future<Either<FailureClass, void>> createUserAtFirebaseWithCredential(
      {required AuthCredential credential}) async {
    return await repo.createUserAtFirebaseWithCredential(
        credential: credential);
  }
}
