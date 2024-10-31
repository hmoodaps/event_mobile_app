import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import '../../data/local_storage/shared_local.dart';
import '../../presentation/routs&view_models/splash/splash_route.dart';
import '../components/constants/general_strings.dart';
import '../components/constants/routs_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _app = MyApp._internal();

  factory MyApp() => _app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData? themeData; // State variable for theme data

  @override
  void initState() {
    super.initState();
    _initializeAppTheme();
  }

  Future<void> _initializeAppTheme() async {
    // Check for the existence of values in SharedPreferences
    String? toggleModeType = SharedPref.prefs.getString(GeneralStrings.toggleModeType);

    // If the value is null, set the default values
    if (toggleModeType == null) {
      // Set the default values
      await SharedPref.prefs.setString(GeneralStrings.toggleModeType, GeneralStrings.basedOnPhone);
      // Set the default theme
      themeData = AppTheme.light.themeData;
    } else {
      // Load the theme from SharedPreferences
      AppTheme loadedTheme = await AppThemeExtension.loadFromPreferences();
      themeData = loadedTheme.themeData;
    }

    // Update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc(),
      child: BlocBuilder<EventsBloc, AppStates>(
        builder: (context, state) {
          // Ensure themeData is initialized
          if (themeData == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            onGenerateRoute: Routes.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            theme: themeData,
            home: const SplashRoute(),
          );
        },
      ),
    );
  }
}
