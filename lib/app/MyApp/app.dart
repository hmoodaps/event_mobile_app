import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/routs&view_models/splash/splash_route.dart';
import '../components/constants/routs_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _app = MyApp._internal();

  factory MyApp() => _app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData? themeData;

  @override
  void initState() {
    super.initState();
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
