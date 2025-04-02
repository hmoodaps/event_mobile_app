import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/implementer/failure_class/failure_class.dart';

abstract class AuthRepository {
  Future<Either<FailureClass, Map<String, dynamic>>> signInWithGoogle();

// Future<AuthCredential> signInWithApple();
}
