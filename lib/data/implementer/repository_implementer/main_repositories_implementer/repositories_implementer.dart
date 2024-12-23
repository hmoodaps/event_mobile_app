import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/data/mapper/mapper.dart';
import 'package:event_mobile_app/data/network_data_handler/rest_api/rest_api_dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app/components/constants/variables_manager.dart';
import '../../../../domain/local_models/models.dart';
import '../../../../domain/repository/main_repositories/repositories.dart';
import '../../../models/movie_model.dart';
import '../../../models/user_model.dart';
import '../../failure_class/failure_class.dart';

class RepositoriesImplementer implements Repositories {
  final DioClient dioClient;

  RepositoriesImplementer(this.dioClient);

  // -------Getter to get the userId dynamically-------
  String? get userId => VariablesManager.firebaseAuthInstance.currentUser?.uid;

  // ----------------------- Firebase Functions -----------------------

  // -------Function: Login to Firebase -------
  @override
  Future<Either<FailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req}) async {
    return handleFirebaseOperation(() async {
      final userCredential = await VariablesManager.firebaseAuthInstance
          .signInWithEmailAndPassword(
        email: req.email!,
        password: req.password!,
      );
      SharedPref.prefs
          .setString(GeneralStrings.currentUser, userCredential.user!.uid);
      await _addFavesFromGuestToUser();

      return userCredential.user!.uid;
    });
  }

  // -------Function: Create a user in Firebase -------
  @override
  Future<Either<FailureClass, UserCredential>> createUserAtFirebase(
      {required CreateUserRequirements req}) async {
    return handleFirebaseOperation(() async {
      final userCredential = await VariablesManager.firebaseAuthInstance
          .createUserWithEmailAndPassword(
        email: req.email!,
        password: req.password!,
      );
      return userCredential;
    });
  }

  // -------Function: Add user to Firebase -------
  @override
  Future<Either<FailureClass, void>> addUserToFirebase(
      {required CreateUserRequirements req}) async {
    return handleFirebaseOperation(() async {
      List<int> favorites = [];
      for (String favorite
          in SharedPref.prefs.getStringList(GeneralStrings.listFaves)!) {
        int favoriteItem = int.parse(favorite);
        favorites.add(favoriteItem);
      }
      final userResponse = UserResponse(
        email: req.email,
        fullName: req.fullName,
        id: userId,
        favorites: favorites,
      );

      await VariablesManager.firestoreInstance
          .collection(GeneralStrings.users)
          .doc(userId)
          .set(userResponse.toDomain().toJson());
    });
  }

  // -------Function: Initialize Firebase and fetch user IDs -------
  @override
  Future<Either<FailureClass, List<String>>> initFirebase() async {
    return handleFirebaseOperation(() async {
      final snapshot = await VariablesManager.firestoreInstance
          .collection(GeneralStrings.users)
          .get();
      final userIds = snapshot.docs.map((doc) => doc.id).toList();
      return userIds;
    });
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
  Future<Either<FailureClass, void>> addUserDetails(
      {required CreateUserRequirements req}) async {
    return handleFirebaseOperation(() async {
      final userDoc = VariablesManager.firestoreInstance
          .collection(GeneralStrings.users)
          .doc(userId);

      await userDoc.update({
        'street': req.street,
        'houseNumber': req.houseNumber,
        'postalCode': req.postalCode,
        'city': req.city,
        'dateOfBirth': req.dateOfBirth,
        'additionalInfo': req.additionalInfo,
      });
      SharedPref.prefs.setString(
          GeneralStrings.currentUser, FirebaseAuth.instance.currentUser!.uid);

      await _addFavesFromGuestToUser();
    });
  }

  // -------Function: Create user with credentials -------
  @override
  Future<Either<FailureClass, User>> createUserAtFirebaseWithCredential(
      {required AuthCredential credential}) async {
    return handleFirebaseOperation(() async {
      final userCredential = await VariablesManager.firebaseAuthInstance
          .signInWithCredential(credential);
      SharedPref.prefs
          .setString(GeneralStrings.currentUser, userCredential.user!.uid);

      await _addFavesFromGuestToUser();
      SharedPref.prefs
          .setString(GeneralStrings.currentUser, userCredential.user!.uid);
      return userCredential.user! ;
    });
  }

  // -------Log out -------
  @override
  Future<Either<FailureClass, void>> logout() async {
    return handleFirebaseOperation(() async {
      await VariablesManager.firebaseAuthInstance.signOut();
    });
  }

  // -------Forget password -------
  @override
  Future<Either<FailureClass, void>> forgetPassword(String email) async {
    return handleFirebaseOperation(() async {
      await VariablesManager.firebaseAuthInstance
          .sendPasswordResetEmail(email: email);
    });
  }

  // -------Get Current User Response -------
  @override
  Future<Either<FailureClass, UserResponse>> getCurrentUserResponse() async {
    if (userId == null) {
      return Left(FailureClass(error: "User not authenticated"));
    }

    return handleFirebaseOperation(() async {
      final userDoc = await VariablesManager.firestoreInstance
          .collection(GeneralStrings.users)
          .doc(userId)
          .get();
      SharedPref.prefs.setString(
          GeneralStrings.currentUser, FirebaseAuth.instance.currentUser!.uid);

      if (userDoc.exists) {
        return UserResponse.fromJson(userDoc.data()!).toDomain();
      } else {
        throw Exception('User document not found.');
      }
    });
  }

  // -------Add Film To Favorites -------
  @override
  Future<Either<FailureClass, void>> addFilmToFavorites(
      {required MovieResponse movie}) async {
    return handleFirebaseOperation(() async {
      if (userId == null) {
        List<String> faves =
            SharedPref.prefs.getStringList(GeneralStrings.listFaves) ?? [];

        if (!faves.contains(movie.id.toString())) {
          faves.add(movie.id.toString());
        }
        VariablesManager.favesMovies.add(movie);

        SharedPref.prefs.setStringList(GeneralStrings.listFaves, faves);
      } else {
        final userRef = VariablesManager.firestoreInstance
            .collection(GeneralStrings.users)
            .doc(userId);

        await VariablesManager.firestoreInstance
            .runTransaction((transaction) async {
          final docSnapshot = await transaction.get(userRef);
          if (docSnapshot.exists) {
            transaction.update(userRef, {
              'favorites': FieldValue.arrayUnion([movie.id])
            });
          }
        });
      }
    });
  }

  // -------Remove Film From Favorites -------
  @override
  Future<Either<FailureClass, void>> removeFilmFromFavorites(
      {required MovieResponse movie}) async {
    return handleFirebaseOperation(() async {
      if (userId == null) {
        List<String> faves =
            SharedPref.prefs.getStringList(GeneralStrings.listFaves) ?? [];

        faves.remove(movie.id.toString());
        VariablesManager.favesMovies.remove(movie);
        SharedPref.prefs.setStringList(GeneralStrings.listFaves, faves);
      } else {
        final userRef = VariablesManager.firestoreInstance
            .collection(GeneralStrings.users)
            .doc(userId);

        final docSnapshot = await userRef.get();
        if (docSnapshot.exists) {
          await userRef.update({
            'favorites': FieldValue.arrayRemove([movie.id])
          });
        }
      }
    });
  }

  // -------Add Film To Cart -------
  @override
  Future<Either<FailureClass, void>> addFilmToCart(
      {required MovieResponse movie}) async {
    return handleFirebaseOperation(() async {
      if (userId != null) {
        final userRef = VariablesManager.firestoreInstance
            .collection(GeneralStrings.users)
            .doc(userId);
        VariablesManager.cartMovies.add(movie);
        await VariablesManager.firestoreInstance
            .runTransaction((transaction) async {
          final docSnapshot = await transaction.get(userRef);
          if (docSnapshot.exists) {
            transaction.update(userRef, {
              'cart': FieldValue.arrayUnion([movie.id!])
            });
          }
        });
      }
    });
  }

  // -------Remove Film From Favorites -------
  @override
  Future<Either<FailureClass, void>> removeFilmFromCart(
      {required MovieResponse movie}) async {
    return handleFirebaseOperation(() async {
      final userRef = VariablesManager.firestoreInstance
          .collection(GeneralStrings.users)
          .doc(userId);
      VariablesManager.cartMovies.remove(movie);
      final docSnapshot = await userRef.get();
      if (docSnapshot.exists) {
        await userRef.update({
          'cart': FieldValue.arrayRemove([movie.id])
        });
      }
    });
  }

  _addFavesFromGuestToUser() async {
    final currentUser = await VariablesManager.firestoreInstance
        .collection(GeneralStrings.users)
        .doc(VariablesManager.firebaseAuthInstance.currentUser!.uid)
        .get();

    if (currentUser.exists) {
      List<int> firebaseFavorites =
          List<int>.from(currentUser.data()?['favorites'] ?? []);

      List<String> sharedPrefFavorites =
          SharedPref.prefs.getStringList(GeneralStrings.listFaves) ?? [];

      List<int> sharedPrefFavoritesInt =
          sharedPrefFavorites.map(int.parse).toList();

      for (int filmId in sharedPrefFavoritesInt) {
        if (!firebaseFavorites.contains(filmId)) {
          firebaseFavorites.add(filmId);
        }
      }

      await FirebaseFirestore.instance
          .collection(GeneralStrings.users)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'favorites': firebaseFavorites,
      }).then((_) {
        SharedPref.prefs.setStringList(GeneralStrings.listFaves, []);
        VariablesManager.favesMovies = [];
      });
    }
  }
}
