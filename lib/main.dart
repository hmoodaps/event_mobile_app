import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/local_storage/shared_local.dart';
import 'data/network_data_handler/internet_checker/internet_checker.dart';
import 'data/network_data_handler/remote_requests/dio_requests_handler.dart';
import 'firebase_options.dart';
import 'app/MyApp/app.dart';

//main ,,,
// the app will start from here to the app.dart(where myApp class in the app layer)
// we made the main fun (asyncable) bcz we have to run firebase in the init ..

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPref.init();
   DioHelper.init();
  runApp(MyApp());
}
