import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/domain/model_objects/movies_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../data/implementer/repo_implementer.dart';

abstract class Repository{
  Future<Either<FailedResponse, List<MoviesModel>>> fetchMovies();
  navigatorToTheMain(context);
  Future<AuthCredential> signInWithGoogle(context);
  Future<AuthCredential> signInWithApple();
  Future<UserCredential> createUserAtFirebase(
      {required GlobalKey<FormState>? formKey,
        required String email,
        required String password,
        required String fullName});
  Future<void> addUserToFirebase(
      {required String? email,
        required String? fullName,
        String? uid,
        String? userPhotoUrl});
  Future<List<String>> initFirebase();

}





