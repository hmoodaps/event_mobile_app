import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'app/dependencies_injection/dependency_injection.dart';
import 'firebase_options.dart';
import 'app/MyApp/app.dart';

// main function
// The app starts here and the control goes to the MyApp class in the app layer.
// The main function is made async because Firebase initialization needs to run during app startup.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // Ensures that the Flutter engine is properly initialized before doing any further tasks
  WidgetsFlutterBinding.ensureInitialized();

  // Setting the system UI mode to manual and enabling the top overlay (like status bar)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top // Shows only the top system UI (like the status bar)
  ]);

  // Initializing Firebase with the platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Firebase options based on the platform (iOS/Android)
  );

  // Initialize all necessary dependencies (DI - Dependency Injection)
  await initAppModules();


  // Run the MyApp widget to start the application
    runApp(MyApp());

}
