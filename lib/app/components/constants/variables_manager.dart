import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mobile_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/local_storage/shared_local.dart';
import '../../../data/models/movie_model.dart';
import 'general_strings.dart';

class VariablesManager {
  static bool isDark = false;
  static List<String> userIds = [];
  static List<MovieResponse> movies = [];
  static List<MovieResponse> favesMovies = [];
  static List<MovieResponse> cartMovies = [];
  static UserResponse currentUserRespon = UserResponse();
  static final firebaseAuthInstance = FirebaseAuth.instance;
  static final firestoreInstance = FirebaseFirestore.instance;

  static String? currentUser =
      SharedPref.prefs.getString(GeneralStrings.currentUser) ??
          FirebaseAuth.instance.currentUser?.uid;

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
