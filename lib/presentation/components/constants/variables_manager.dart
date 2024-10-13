import 'package:event_mobile_app/domain/models/movie_model.dart';
import 'package:event_mobile_app/presentation/components/constants/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class VariablesManager{
  static ThemeData? themeData = lightThemeData();
  static bool isDark = false;
  static String ? userEmail ;
  static String ? photoUrl ;
  //initialize in splash screen
  static List<String> userIds =[];
  static List<MovieModel> movies =[];

//sign in with google .>>
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
    '738356872374-8bdei58fqh2bkocfk0ph7dm3ud6jf4gl.apps.googleusercontent.com',
  );

}