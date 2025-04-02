import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/dio_and_mapper_constants.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/data/mapper/mapper.dart';
import 'package:event_mobile_app/data/network_data_handler/rest_api/rest_api_dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../app/components/constants/variables_manager.dart';
import '../../../../domain/local_models/models.dart';
import '../../../../domain/local_models/reference_number_generator.dart';
import '../../../../domain/models/billing_info/billing_info.dart';
import '../../../../domain/models/model_objects/actor_model.dart';
import '../../../../domain/models/movie_model/movie_model.dart';
import '../../../../domain/models/user_model/user_model.dart';
import '../../../../domain/repository/main_repositories/repositories.dart';
import '../../failure_class/failure_class.dart';

class RepositoriesImplementer implements Repositories {
  final DioClient dioClient;

  RepositoriesImplementer(this.dioClient);

  // -------Getter to get the userId dynamically-------
  String? get userId => VariablesManager.firebaseAuthInstance.currentUser?.uid;

  //create user in the  server side
  @override
  Future<String> createGuest(String id) async {
    final url = '${AppConstants.createGuest}';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'id': id,
      }),
    );

    if (response.statusCode == 201) {
      print("successfully created user${jsonDecode(response.body)["token"]}");
      VariablesManager.currentUserToken = jsonDecode(response.body)["token"];
      return jsonDecode(response.body)["token"];
    } else {
      print('Failed to create guest: ${response.body}');
      return response.body;
    }
  }

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
  Future<Either<FailureClass, Map<String , dynamic>>> createUserAtFirebase(
      {required CreateUserRequirements req}) async {
    String token ="";
    return handleFirebaseOperation(() async {
      final userCredential = await VariablesManager.firebaseAuthInstance
          .createUserWithEmailAndPassword(
        email: req.email!,
        password: req.password!,
      );
      if (!VariablesManager.userIds.contains(userCredential.user?.uid))
        token =  await createGuest(userCredential.user!.uid);
      return {"token": token , "user":userCredential };
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
      print("tkoonaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${req.token}");
      final userResponse = UserResponse(
        email: req.email,
        fullName: req.fullName,
        id: userId,
        favorites: favorites,
        token: req.token
      );
       if (!VariablesManager.userIds.contains(userId))
      //   await createGuest(userId!);

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
  Future<Either<FailureClass, Map<String, dynamic>>> createUserAtFirebaseWithCredential(
      {required AuthCredential credential}) async {
    String token = "";
    return handleFirebaseOperation(() async {
      final userCredential = await VariablesManager.firebaseAuthInstance
          .signInWithCredential(credential);
      SharedPref.prefs
          .setString(GeneralStrings.currentUser, userCredential.user!.uid);
      await _addFavesFromGuestToUser();
      SharedPref.prefs
          .setString(GeneralStrings.currentUser, userCredential.user!.uid);
      if (!VariablesManager.userIds.contains(userCredential.user?.uid))
        token =  await createGuest(userCredential.user!.uid);
      print("token is  $token" );
      return {"user":userCredential.user! , "token" :token};
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

  @override
  Future<Either<FailureClass, UserResponse>> getCurrentUserResponse() async {
    print("🔵 [DEBUG] - getCurrentUserResponse started");

    if (userId == null) {
      print("❌ [ERROR] - User ID is null (User not authenticated)");
      return Left(FailureClass(error: "User not authenticated"));
    }

    try {
      print("🟢 [INFO] - Fetching user data from Firestore...");
      final userDoc = await VariablesManager.firestoreInstance
          .collection(GeneralStrings.users)
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        print("❌ [ERROR] - User document not found in Firestore");
        return Left(FailureClass(error: "User document not found."));
      }

      // طباعة البيانات المسترجعة من Firestore
      print("📄 [FIRESTORE DATA] - ${userDoc.data()}");

      // تحويل البيانات إلى كائن UserResponse
      final userResponse = UserResponse.fromJson(userDoc.data()!);

      // تحويل قائمة الفواتير إلى domain model
      final transformedBills = userResponse.bills?.map((bill) => bill.toDomain()).toList();

      // تحويل UserResponse إلى domain model مع الفواتير المحولة
      final userDomain = userResponse.toDomain().copyWith(bills: transformedBills);

      print("🟢 [INFO] - Converted to domain model: $userDomain");

      // التحقق من قيمة token
      print("🟢 [INFO] - Token before return: ${userDomain.token}");

      return Right(userDomain);
    } catch (error, stacktrace) {
      print("❌ [ERROR] - Exception caught: $error");
      print("🔴 [STACKTRACE] - $stacktrace");
      return Left(FailureClass(error: "An unexpected error occurred."));
    }
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

  @override
  Future<Either<FailureClass, List<ActorModel>>> fetchActorsData(
      {required List<String> actors}) async {
    return await handleFirebaseOperation(() async {
      try {
        final result = await compute(fetchActorsDataIsolate, actors);
        return result;
      } catch (e) {
        throw Exception("Error in Isolate: $e");
      }
    });
  }

  Future<List<ActorModel>> fetchActorsDataIsolate(List<String> actors) async {
    List<ActorModel> actorsModel = [];

    for (String actor in actors) {
      final response = await http.get(Uri.parse(
          'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=$actor&prop=extracts|pageimages&exintro=true&explaintext=true&piprop=original'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final page = data['query']['pages'].values.first;
        if (page != null && page['title'] != null && page['original'] != null) {
          String title = page['title'];
          bool isExists =
              actorsModel.any((existingActor) => existingActor.title == title);

          if (!isExists) {
            actorsModel.add(ActorModel.fromJson(data));
          }
        }
      }
    }

    return actorsModel;
  }


  @override
  Future<void> addBillingInfoToUser({required BillingInfo billingInfo}) async {
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);

    DocumentSnapshot userSnapshot = await userDocRef.get();

    // if (userSnapshot.exists) {
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

      List<dynamic> existingBills = userData['bills'] ?? [];
      existingBills.add(billingInfo.toDomain().toJson());

      await userDocRef.update({
        'bills': existingBills,
      }).then((value) => print("existingBills ${existingBills.length}"),);
    // } else {
    //   await userDocRef.set({
    //     'bills': [billingInfo.toJson()],
    //   });
    // }


  }
  @override

  Future<String> generateUniqueReferenceNumber() async {
    String refNumber;
    bool exists = true;
    final firestore = FirebaseFirestore.instance;

    do {
      refNumber = generateReferenceNumber();

      final querySnapshot = await firestore
          .collection('bills')
          .where('referenceNumber', isEqualTo: refNumber)
          .get();

      exists = querySnapshot.docs.isNotEmpty;

    } while (exists);

    return refNumber;
  }

}
