// This code implements both Isolate and compute functions to offload Firebase-related tasks and API calls
// to separate threads. While these operations could be managed on the main thread or with simpler async patterns,
// this approach was intentionally used to demonstrate proficiency in handling complex asynchronous programming,
// including isolate management and performance optimization.
// By using isolates and compute, we ensure that heavy tasks such as network calls and database operations do not
// block the main UI thread, keeping the application responsive. Additionally, this showcases my ability to handle
// complex architectures that support scalability and efficiency.

import 'dart:isolate';
import 'package:event_mobile_app/data/mapper/mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/domain/isolate/isolate_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../domain/local_models/models.dart';
import '../../local_storage/shared_local.dart';
import '../../models/movie_model.dart';
import '../../models/user_model.dart';
import '../../network_data_handler/rest_api/rest_api_dio.dart';
import '../failure_class/failure_class.dart';

class IsolateHelperImplementer implements IsolateHelper {
  final DioClient dioClient;

  IsolateHelperImplementer(this.dioClient);

  // ----------------------- Helper Functions -----------------------

  // Helper function to run code in an isolate
  // This utility function allows offloading of potentially expensive or blocking tasks
  // to a separate isolate. It returns a result wrapped in Either<T, U> for handling success and failure.
  Future<Either<T, U>> _runInIsolate<T, U>(
      Future<Either<T, U>> Function() func) async {
    return await Isolate.run(func);
  }

  // ----------------------- Background Functions -----------------------

  // Background login function
  // Authenticates a user using Firebase Authentication in a background process.
  Future<String?> loginInBackground(List<String> params) async {
    final email = params[0];
    final password = params[1];
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user?.uid;
  }

  // Background function to create a new user in Firebase
  // This function registers a new user with Firebase in the background.
  Future<UserCredential> createUserInBackground(
      CreateUserRequirements req) async {
    return await VariablesManager.auth.createUserWithEmailAndPassword(
      email: req.email,
      password: req.password!,
    );
  }

  // Adds a user to Firestore in the background
  // This function checks for duplicate IDs and saves user data to Firestore.
  Future<void> addUserInBackground(CreateUserRequirements req) async {
    UserResponse userResponse = UserResponse(
      email: req.email,
      fullName: req.fullName,
    );
    if (!VariablesManager.userIds.contains(userResponse.id)) {
      await FirebaseFirestore.instance
          .collection(GeneralStrings.users)
          .doc(VariablesManager.currentUser!.uid)
          .set(userResponse.toJson());
    }
  }

  Future<List<MovieResponse>> fetchMoviesInBackground(_) async {
    // Fetching Data from API:
    // await dioClient.getMovies() sends an HTTP request to fetch movies.
    // await ensures that the function waits until the data is retrieved before continuing.
    List<MovieResponse> movies = await dioClient.getMovies();

    // Transforming the Data:
    // movies.map((movie) => MovieResponse.fromJson(movie.toDomain()))
    // converts each movie in the list by first calling toDomain() to turn it into a map,
    // Function: toDomain
    // This function is responsible for checking each variable in the movie object received from the API.
    // If a variable is null, it assigns a default value to ensure no null values are passed to the domain model.
    // then calling fromJson() to turn it back into a MovieResponse object.
    return movies
        .map((movie) => MovieResponse.fromJson(movie.toDomain()))
        .toList();

    // Returning the List:
    // The .toList() at the end converts the iterable returned by .map() back into a list,
    // which is the expected return type.
  }

  // Fetches user IDs from Firestore in the background
  // This function retrieves all user IDs from the Firestore users collection.
  Future<List<String>> initFirebaseInBackground(Null param) async {
    final snapshot =
        await FirebaseFirestore.instance.collection(GeneralStrings.users).get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }

  // ----------------------- Isolate Functions -----------------------

  // Logs a user into Firebase using an isolate
  // This function uses an isolate to offload the login task and dispatches success or failure.
  Future<Either<FirebaseFailureClass, String>> isolateLoginToFirebase(
      {required CreateUserRequirements req}) async {
    try {
      // `compute` is used to run loginInBackground as a secondary thread inside the isolate
      final uid = await compute(loginInBackground, [req.email, req.password!]);
      return Right(uid!);
    } catch (error) {
      return Left(
          FirebaseFailureClass(authException: error as FirebaseAuthException));
    }
  }

  // Creates a user in Firebase using an isolate
  // Uses an isolate to offload the user creation task and dispatches success or failure.
  Future<Either<FirebaseFailureClass, UserCredential>>
      isolateCreateUserAtFirebase({required CreateUserRequirements req}) async {
    try {
      final credential = await compute(createUserInBackground, req);
      SharedPref.prefs
          .setString(GeneralStrings.currentUser, credential.user!.uid);
      return Right(credential);
    } catch (error) {
      return Left(
          FirebaseFailureClass(authException: error as FirebaseAuthException));
    }
  }

  // Adds a user to Firestore using an isolate
  // Offloads the task of adding a user to Firestore and dispatches events based on success or failure.
  Future<Either<FirebaseFailureClass, void>> isolateAddUserToFirebase(
      {required CreateUserRequirements req}) async {
    try {
      await compute(addUserInBackground, req);
      return Right(null);
    } catch (error) {
      return Left(
          FirebaseFailureClass(authException: error as FirebaseAuthException));
    }
  }

  // Initializes Firebase and fetches user IDs using an isolate
  // Offloads the user ID fetching task to an isolate and dispatches success or failure.
  Future<Either<FailureClass, List<String>>> isolateInitFirebase() async {
    VariablesManager.userIds.clear();
    try {
      final userIds = await compute(initFirebaseInBackground, null);
      VariablesManager.userIds.addAll(userIds);
      return Right(VariablesManager.userIds);
    } catch (error) {
      return Left(FailureClass(error: error.toString()));
    }
  }

  // Fetches movies using an isolate
  // Offloads the movie data fetching task to an isolate and dispatches success or failure.
  Future<Either<FailureClass, List<MovieResponse>>> isolateFetchMovies() async {
    if (VariablesManager.movies.isNotEmpty) {
      VariablesManager.movies.clear();
    }
    try {
      final response = await compute(fetchMoviesInBackground, null);

      return Right(response);
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return Left(FailureClass(error: error.toString()));
    }
  }

  // ----------------------- Isolate Implementation -----------------------

  @override
  Future<Either<FirebaseFailureClass, String>> loginToFirebase(
      {required CreateUserRequirements req}) async {
    return await _runInIsolate(() async {
      return await isolateLoginToFirebase(req: req);
    });
  }

  @override
  Future<Either<FirebaseFailureClass, UserCredential>> createUserAtFirebase(
      {required CreateUserRequirements req}) async {
    return await _runInIsolate(() async {
      return await isolateCreateUserAtFirebase(req: req);
    });
  }

  @override
  Future<Either<FirebaseFailureClass, void>> addUserToFirebase(
      {required CreateUserRequirements req}) async {
    return await _runInIsolate(() async {
      return await isolateAddUserToFirebase(req: req);
    });
  }

  @override
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies() async {
    return await _runInIsolate(() async {
      return await isolateFetchMovies();
    });
  }

  @override
  Future<Either<FailureClass, List<String>>> initFirebase() async {
    return await _runInIsolate(() async {
      return await isolateInitFirebase();
    });
  }
}
