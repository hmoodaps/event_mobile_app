import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/data/network_data_handler/internet_checker/internet_checker.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../bloc_state_managment/events.dart';

class SplashModelView extends BaseViewModel with SplashRouteMethods {
  late BuildContext context;
  late EventsBloc _bloc;
  // Delayed start for the splash screen before navigating
  @override
  Future<void> startDelay() async {
    await Future.delayed(Duration(seconds: SizeManager.i4), endSplash);
  }

  // End the splash screen and navigate based on guest status
  void endSplash() {
    VariablesManager.isGuest == false
        ? Navigator.pushNamedAndRemoveUntil(
      context,
      VariablesManager.isFirstTimeOpened
          ? RouteStringsManager.onboardingRoute
          : RouteStringsManager.questionRoute,
          (route) => false,
    )
        : Navigator.pushNamedAndRemoveUntil(
        context, RouteStringsManager.mainRoute, (route) => false);
  }

  // Starting the splash screen and initiating data fetch
  @override
  void start() async {
    _bloc =  EventsBloc.get(context);
    final InternetChecker checker;
    checker = InternetCheckerImp(InternetConnectionChecker()); // Initialize the checker
    if(await checker.isConnect){
      //the device connect with internet >> you can inter the app
      await _startLoading();
    }else{
      //the device not connect with internet
      //TODO : DO SOMETHING ELSE >>

    }
  }

  // Start fetching movies and Firebase data
  Future<void> _startLoading() async {
    startDelay();
    await initFetchMovies();
    //await initFetchFirebase();
  }

  @override
  void dispose() {}

  // Initialize movie data fetching
  @override
  Future<void> initFetchMovies() async {
    try {
      _bloc.add(StartFetchMoviesEvent());
            // TODO : init fetching movies here
      _bloc.add(InitFetchMoviesEvent());
    } catch (e) {
      _bloc.add(InitFetchMoviesErrorEvent(e.toString()));
    }
  }

  // Initialize Firebase data fetching
  @override
  Future<void> initFetchFirebase() async {
    try {
      _bloc.add(StartFetchFirebaseEvent());
      //TODO : INIT FIREBASE HERE
      _bloc.add(InitFetchFirebaseEvent());
    } catch (e) {
      _bloc.add(InitFetchFirebaseErrorEvent(e.toString()));
    }
  }

  // Future<Either<AppEvents, AppEvents>> fetchFirebase() async {
  //   _bloc.add(StartFetchFirebaseEvent());
  //   try {
  //     // TODO: INIT FIREBASE HERE
  //     _bloc.add(InitFetchFirebaseEvent());
  //     return Right(InitFetchFirebaseEvent());
  //   } catch (error) {
  //     return Left(InitFetchFirebaseErrorEvent(error.toString()));
  //   }
  // }

}

// Methods interface for the splash screen
mixin SplashRouteMethods {
  Future<void> startDelay();
  Future<void> initFetchMovies();
  Future<void> initFetchFirebase();
}
