import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/data/remote_data_source/dio_requests_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPref.init();
  //TODO : YOU HAVE TO PUT TOKEN
  DioHelper.init('token');
  runApp( MyApp());
}

