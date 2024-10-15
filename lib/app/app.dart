import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/components/constants/routs_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/routs&view_models/splash/splash_route.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  ///singleton instance from MyApp
  ///When you apply the Singleton pattern along
  ///with concepts like BLoC, Dependency Injection, and Clean Architecture
  ///, you ensure that there is a single instance of the core and critical
  /// objects throughout the application's lifecycle, allowing you to manage
  /// resources efficiently and avoid repeated initialization.
  static const MyApp _app = MyApp._internal();

  factory MyApp() => _app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc(),
      child: BlocBuilder<EventsBloc, AppStates>(builder: (context, state) {
        ThemeData? themeData =
            EventsBloc.get(context).toggleLightAndDark(context);
        return MaterialApp(
          onGenerateRoute: Routes.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: SplashRoute(),
        );
      }),
    );
  }
}
