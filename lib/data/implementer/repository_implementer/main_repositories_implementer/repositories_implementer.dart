import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/data/network_data_handler/rest_api/rest_api_dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../domain/local_models/models.dart';
import '../../../../domain/repository/main_repositories/repositories.dart';
import '../../../models/movie_model.dart';
import '../../../models/user_model.dart';
import '../../failure_class/failure_class.dart';

class RepositoriesImplementer implements Repositories {
  final DioClient dioClient;

  RepositoriesImplementer(this.dioClient);

  // ----------------------- Firebase Functions -----------------------

  // -------Function: Login to Firebase -------
  @override
  Future<Either<FirebaseFailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: req.email!,
        password: req.password!,
      );
      return Right(userCredential.user!.uid);
    } on FirebaseException catch (error) {
      return Left(FirebaseFailureClass(firebaseException: error));
    }
  }

  // -------Function: Create a user in Firebase -------
  @override
  Future<Either<FirebaseFailureClass, UserCredential>> createUserAtFirebase(
      {required CreateUserRequirements req}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: req.email!,
        password: req.password!,
      );

      return Right(userCredential);
    } on FirebaseException catch (error) {
      return Left(FirebaseFailureClass(firebaseException: error));
    }
  }

  // -------Function: Add user to Firebase -------
  @override
  Future<Either<FirebaseFailureClass, void>> addUserToFirebase(
      {required CreateUserRequirements req}) async {
    try {
      final userResponse = UserResponse(
        email: req.email,
        fullName: req.fullName,
        id: FirebaseAuth.instance.currentUser!.uid,
      );

      await FirebaseFirestore.instance
          .collection(GeneralStrings.users)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set(userResponse.toJson());
      return Right(null);
    } on FirebaseException catch (error) {
      return Left(FirebaseFailureClass(firebaseException: error));
    }
  }

  // -------Function: Initialize Firebase and fetch user IDs -------
  @override
  Future<Either<FailureClass, List<String>>> initFirebase() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(GeneralStrings.users)
          .get();
      final userIds = snapshot.docs.map((doc) => doc.id).toList();
      if (kDebugMode) {
        print(userIds);
      }
      return Right(userIds);
    } catch (error) {
      if (kDebugMode) {
        print("fetch firebase uids ${error.toString()}");
      }
      return Left(FailureClass(error: error.toString()));
    }
  }

  // -------Function: Fetch movies -------
  @override
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies() async {
    try {
      final response = await Isolate.run(() async {
        return await dioClient.getMovies();
      });

      return Right(response);
    } catch (error) {
      return Left(FailureClass(error: error.toString()));
    }
  }

  // -------Function: Add user details -------
  @override
  Future<Either<FirebaseFailureClass, void>> addUserDetails(
      {required CreateUserRequirements req}) async {
    try {
      final userDoc = FirebaseFirestore.instance
          .collection(GeneralStrings.users)
          .doc(FirebaseAuth.instance.currentUser!.uid);

      await userDoc.update({
        'street': req.street,
        'houseNumber': req.houseNumber,
        'postalCode': req.postalCode,
        'city': req.city,
        'dateOfBirth': req.dateOfBirth,
        'additionalInfo': req.additinalInfo,
      });

      return Right(null);
    } catch (error) {
      return Left(
          FirebaseFailureClass(firebaseException: error as FirebaseException));
    }
  }

  // -------Function: Create user with credentials -------
  @override
  Future<Either<FirebaseFailureClass, User>> createUserAtFirebaseWithCredential(
      {required AuthCredential credential}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      SharedPref.prefs
          .setString(GeneralStrings.currentUser, userCredential.user!.uid);

      return Right(userCredential.user!);
    } catch (error) {
      return Left(
          FirebaseFailureClass(firebaseException: error as FirebaseException));
    }
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  bool checkUserExisting(String? uid) {
    return VariablesManager.userIds.contains(uid);
  }
}
