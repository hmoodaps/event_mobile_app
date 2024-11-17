import 'package:dartz/dartz.dart';

import '../../../domain/local_models/models.dart';
import '../../../domain/repository/login_to_firebase_repo.dart';
import '../../../domain/repository/main_repositories/repositories.dart';
import '../failure_class/failure_class.dart';

class LoginToFirebaseImplementer implements LoginToFirebaseRepo {
  final Repositories isolateHelper;

  LoginToFirebaseImplementer({
    required this.isolateHelper,
  });

  // Log in to Firebase
  @override
  Future<Either<FirebaseFailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req}) async {
    return await isolateHelper.loginToFirebase(req: req);
  }

  @override
  Future<void> logout() async{
    return await isolateHelper.logout();
  }
}
