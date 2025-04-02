import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mobile_app/data/mapper/mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/local_storage/shared_local.dart';
import '../../../domain/models/model_objects/actor_model.dart';
import '../../../domain/models/movie_model/movie_model.dart';
import '../../../domain/models/user_model/user_model.dart';
import 'general_strings.dart';

class VariablesManager {
  static bool isDark = false;
  static List<String> userIds = [];
  static List<MovieResponse> movies = [];
  static List<MovieResponse> favesMovies = [];
  static List<MovieResponse> cartMovies = [];
  static List<ActorModel> actors = [];
  static UserResponse _currentUserResponse = UserResponse();
  static UserResponse get currentUserResponse => _currentUserResponse;
  static set currentUserResponse(UserResponse currentUserResponse) {
    _currentUserResponse = currentUserResponse;
  }
  static final firebaseAuthInstance = FirebaseAuth.instance;
  static final firestoreInstance = FirebaseFirestore.instance;

  static String? currentUser =
      SharedPref.prefs.getString(GeneralStrings.currentUser) ??
          FirebaseAuth.instance.currentUser?.uid;
  static String? currentUserToken = '';

//sign in with google .>>
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    serverClientId:
        '369796753935-l561iq0q34qadmolhc8r2uv4lim1ltmh.apps.googleusercontent.com',
  );
  static final bool isFirstTimeOpened =
      SharedPref.prefs.getBool(GeneralStrings.isFirstTimeOpened) ?? true;
  static final bool isGuest =
      SharedPref.prefs.getBool(GeneralStrings.isGuest) ?? false;
}
