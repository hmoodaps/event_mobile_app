import 'package:dartz/dartz.dart';

import '../../../domain/local_models/models.dart';
import '../../../domain/repository/login_to_firebase_repo.dart';
import '../../../domain/repository/main_repositories/repositories.dart';
import '../failure_class/failure_class.dart';

class LoginToFirebaseImplementer implements LoginToFirebaseRepo {
  final Repositories repo;

  LoginToFirebaseImplementer({
    required this.repo,
  });

  // Log in to Firebase
  @override
  Future<Either<FailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req}) async {
    return await repo.loginToFirebase(req: req);
  }

  @override
  Future<Either<FailureClass, void>> logout() async {
    return await repo.logout();
  }

  @override
  Future<Either<FailureClass, void>> forgetPassword(String email) async {
    return await repo.forgetPassword(email);
  }
}
