import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/cupertino.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../app/dependencies_injection/dependency_injection.dart';
import '../../bloc_state_managment/events.dart';
import '../../bloc_state_managment/states.dart';

class SplashModelView extends BaseViewModel with SplashRouteMethods {
  late BuildContext context;
  late EventsBloc _bloc;

  // Start the splash screen and initiating data fetch
  @override
  void start() async {
    _bloc = instance();
    _bloc.add(StartFetchMoviesEvent());
  }

  // Delayed start for the splash screen before navigating
  @override
  Future<void> startDelay() async {

    // Listen for the fetch states and update the flags
    _bloc.stream.listen((state) {
      if (state is MoviesLoadedState) {
        endSplash();
      }
    });

  }

  // End the splash screen and navigate based on guest status
  void endSplash() {

    if (VariablesManager.isGuest == false) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        VariablesManager.isFirstTimeOpened
            ? RouteStringsManager.onboardingRoute
            : RouteStringsManager.questionRoute,
            (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteStringsManager.mainRoute, (route) => false);
    }
  }


  @override
  void dispose() {}
}

// Methods interface for the splash screen
mixin SplashRouteMethods {
  Future<void> startDelay();
}
