import 'package:event_mobile_app/app/components/constants/theme_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/local_storage/shared_local.dart';
import '../../../data/models/movie_model.dart';
import 'general_strings.dart';

class VariablesManager {
  static User? currentUser = FirebaseAuth.instance.currentUser;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static bool isDark = false;
  static bool isConnectedToTheInternet = true;
  static ThemeData? themeData = lightThemeData();
  static String? userEmail;

  static String? photoUrl;

  //initialize in splash screen
  static List<String> userIds = [];
  static List<MovieResponse> movies = [];

//sign in with google .>>
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '738356872374-8bdei58fqh2bkocfk0ph7dm3ud6jf4gl.apps.googleusercontent.com',
  );
  static final bool isFirstTimeOpened =
      SharedPref.getBool(GeneralStrings.isFirstTimeOpened) ?? true;
  static final bool isGuest = SharedPref.getBool(GeneralStrings.isGuest) ?? false;
  static  lightHeader(BuildContext context) => Theme.of(context).textTheme.bodyLarge;

  static lightTitle(BuildContext context) => Theme.of(context).textTheme.titleLarge;

  static lightBody(BuildContext context) => Theme.of(context).textTheme.bodyLarge;

  static lightParagraph(BuildContext context) => Theme.of(context).textTheme.labelLarge;

}
