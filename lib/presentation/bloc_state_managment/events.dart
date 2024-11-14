import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../../data/models/movie_model.dart';
import '../../domain/local_models/models.dart';

abstract class AppEvents {}

class StartCreateUserEvent extends AppEvents {
  final CreateUserRequirements req;
  StartCreateUserEvent(this.req);
}

class CreatingUserResultEvent extends AppEvents {
  final String? error;
  final CreateUserRequirements req;
  final Either<FirebaseFailureClass, UserCredential> result;

  CreatingUserResultEvent(this.req, this.result, {this.error});
}

class AddUserToFirebaseEvent extends AppEvents {
  final CreateUserRequirements req;
  AddUserToFirebaseEvent(this.req);
}

class AddUserToFirebaseResultEvent extends AppEvents {
  final String? error;
  final Either<FirebaseFailureClass, void> result;
  AddUserToFirebaseResultEvent(this.result, {this.error});
}

class LoginEvent extends AppEvents {
  final CreateUserRequirements req;
  LoginEvent(this.req);
}

class LoginResultEvent extends AppEvents {
  final String? error;
  final Either<FirebaseFailureClass, String> result;
  LoginResultEvent(this.result, {this.error});
}

class SignInWithGoogleEvent extends AppEvents {}

class SignInWithGoogleResultEvent extends AppEvents {
  final String? error;
  Either<FailureClass, Either<bool, bool>> result;
  SignInWithGoogleResultEvent(this.result, {this.error});
}

class ChangeNavigationBarIndexEvent extends AppEvents {}

class ToggleToLightEvent extends AppEvents {}
class ToggleToDarkEvent extends AppEvents {}
class ToggleLightAndDarkEvent extends AppEvents {
}

class StartFetchMoviesEvent extends AppEvents {}

class FetchMoviesResultEvent extends AppEvents {
  final String? error;
  Either<FailureClass, List<MovieResponse>> result;
  FetchMoviesResultEvent(this.result, {this.error});
}

class StartFetchFirebaseEvent extends AppEvents {}
class MoviesLoadedEvent extends AppEvents {}

class FetchFirebaseResultEvent extends AppEvents {
  final String? error;
  Either<FailureClass, List<String>> result;
  FetchFirebaseResultEvent(this.result, {this.error});
}

class InternetStatusChangeEvent extends AppEvents{}