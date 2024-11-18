import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/local_storage/shared_local.dart';
import '../../../data/models/movie_model.dart';
import 'general_strings.dart';

class VariablesManager {
  static bool isDark = false;
  static List<String> userIds = [];
  static List<MovieResponse> movies = [];

//sign in with google .>>
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    serverClientId:
        '369796753935-l561iq0q34qadmolhc8r2uv4lim1ltmh.apps.googleusercontent.com',
  );
  static final bool isFirstTimeOpened =
      SharedPref.getBool(GeneralStrings.isFirstTimeOpened) ?? true;
  static final bool isGuest =
      SharedPref.getBool(GeneralStrings.isGuest) ?? false;
}
