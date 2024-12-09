import 'package:dartz/dartz.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../local_models/models.dart';

abstract class LoginToFirebaseRepo {
  Future<Either<FirebaseFailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req});

  Future<Either<FirebaseFailureClass, void>> logout();

  Future<Either<FirebaseFailureClass, void>> forgetPassword(String email);
}
