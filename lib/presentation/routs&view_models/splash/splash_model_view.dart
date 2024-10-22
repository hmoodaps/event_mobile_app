import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/events.dart';
import '../../components/constants/route_strings_manager.dart';
import '../../components/constants/size_manager.dart';
import '../../components/constants/variables_manager.dart';

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
    _bloc = EventsBloc.get(context);
    await _startLoading();
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
      VariablesManager.movies.clear();
      VariablesManager.movies = await fetchMovies();
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
      VariablesManager.userIds.clear();
      List<String> ids = await initFirebase();
      VariablesManager.userIds.addAll(ids);
      _bloc.add(InitFetchFirebaseEvent());
    } catch (e) {
      _bloc.add(InitFetchFirebaseErrorEvent(e.toString()));
    }
  }
}

// Methods interface for the splash screen
mixin SplashRouteMethods {
  Future<void> startDelay();
  Future<void> initFetchMovies();
  Future<void> initFetchFirebase();
}
