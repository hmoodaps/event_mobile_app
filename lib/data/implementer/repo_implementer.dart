import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/data/mapper/mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../app/components/constants/general_strings.dart';
import '../../app/components/constants/route_strings_manager.dart';
import '../../app/components/constants/routs_manager.dart';
import '../../domain/model_objects/movies_model.dart';
import '../../domain/model_objects/user_model.dart';
import '../../domain/repository/repository.dart';
import '../network_data_handler/rest_api/rest_api_dio.dart';

class RepositoryImplementer implements Repository {
  final DioClint dioClient;

  RepositoryImplementer(this.dioClient);

  @override
  Future<Either<FailedResponse, List<MoviesModel>>> fetchMovies() async {
    VariablesManager.movies.clear();
    try {
      final response = await dioClient.getMovies();
      // convert response from MovieResponse to MoviesModel by (toDomain )
      final movies = response.map((movieResponse) => movieResponse.toDomain()).toList();
      VariablesManager.movies.addAll(movies);
      return Right(VariablesManager.movies);
    } catch (error) {
      return Left(FailedResponse(error: error.toString()));
    }
  }


  //navigator To The Main Route
  @override
  navigatorToTheMain(context) {
    navigateTo(context!, RouteStringsManager.mainRoute);
  }
// handle firebase auth by google and apple
//sign in with google
  @override
  Future<AuthCredential> signInWithGoogle(context) async {
    final GoogleSignInAccount? googleUser =
    await VariablesManager.googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return credential;
  }

//sign in with apple
//i didn't implement it correctly bcz they want 99$ ^_^
  @override
  Future<AuthCredential> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oAuthProvider = OAuthProvider("apple.com");

    final credential = oAuthProvider.credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    return credential;
  }

//create new user
  @override
  Future<UserCredential> createUserAtFirebase(
      {required GlobalKey<FormState>? formKey,
        required String email,
        required String password,
        required String fullName}) async {
    UserCredential credential = await VariablesManager.auth
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  }

//add user to firebase
  @override
  Future<void> addUserToFirebase(
      {required String? email,
        required String? fullName,
        String? uid,
        String? userPhotoUrl}) async {
    UserModel userModel = UserModel(
      email: email,
      fullName: fullName,
      id: uid,
      userPhotoUrl: userPhotoUrl,
    );
    if (!VariablesManager.userIds.contains(userModel.id)) {
      await FirebaseFirestore.instance
          .collection(GeneralStrings.users)
          .doc(VariablesManager.currentUser!.uid)
          .set(userModel.toJson());
    }
  }

// init firebase
  @override
  Future<List<String>> initFirebase() async {
    List<String> ids = [];
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection(GeneralStrings.users).get();
    for (var doc in snapshot.docs) {
      ids.add(doc.id) ;
    }
    return ids ;
  }
}

class FailedResponse{
  String error ;
  FailedResponse({required this.error});
}