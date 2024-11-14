import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/dependencies_injection/dependency_injection.dart';
import 'package:event_mobile_app/domain/isolate/isolate_helper.dart';
import 'package:event_mobile_app/domain/repository/register_in_firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/local_models/models.dart';
import '../failure_class/failure_class.dart';

class RegisterImplementer implements RegisterInFirebaseRepo {
  IsolateHelper isolateHelper = instance<IsolateHelper>();

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
}
