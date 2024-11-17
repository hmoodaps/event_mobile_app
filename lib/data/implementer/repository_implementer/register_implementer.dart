import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/local_models/models.dart';
import '../../../domain/repository/main_repositories/repositories.dart';
import '../../../domain/repository/register_in_firebase_repo.dart';
import '../failure_class/failure_class.dart';

class RegisterImplementer implements RegisterInFirebaseRepo {
  Repositories isolateHelper;

  RegisterImplementer({
    required this.isolateHelper,
  });

  // Create a new user in Firebase
  @override
  Future<Either<FirebaseFailureClass, UserCredential>> createUserAtFirebase(
      {required CreateUserRequirements req}) async {
    return await isolateHelper.createUserAtFirebase(req: req);
  }

  // Add user details to Firestore
  @override
  Future<Either<FirebaseFailureClass, void>> addUserToFirebase(
      {required CreateUserRequirements req}) async {
    return await isolateHelper.addUserToFirebase(req: req);
  }

  @override
  Future<Either<FirebaseFailureClass, void>> createUserAtFirebaseWithCredential(
      {required AuthCredential credential}) async {
    return await isolateHelper.createUserAtFirebaseWithCredential(
        credential: credential);
  }
}
