import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'app/MyApp/app.dart';
import 'app/dependencies_injection/dependency_injection.dart';
import 'firebase_options.dart';

// main function
// The app starts here and the control goes to the MyApp class in the app layer.
// The main function is made async because Firebase initialization needs to run during app startup.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
///////////////////////////////////////////////////////////////////////////////////////////
void main() async {
  // Ensures that the Flutter engine is properly initialized before doing any further tasks
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51QcB91PQGLUA69WNBFYkOXkxie9CAGZo1C0dwZNWCc3OL2SyZbxqvXsVuTCGjekRdfUtPGQoB4wTa8WiVM68ohsM00aOQDY9VP";

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) async {
    // Initialize all necessary dependencies (DI - Dependency Injection)
    await initAppModules().then((_) {
      runApp(MyApp());
    });
  });
}
