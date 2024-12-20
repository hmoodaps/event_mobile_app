import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';
import '../../bloc_state_managment/states.dart';

class SplashModelView extends BaseViewModel with SplashRouteMethods {
  late BuildContext context;
  late EventsBloc _bloc;

  SplashModelView(this.context);

  // Start the splash screen and initiating data fetch
  @override
  void start() async {
    _bloc = EventsBloc.get(context);
    _bloc.add(StartFetchMoviesEvent());
    if (VariablesManager.currentUser != null) {
      _bloc.add(GetCurrentUserResponseEvent());
    }
    startDelay();
  }

  // Delayed start for the splash screen before navigating
  @override
  Future<void> startDelay() async {
    // Listen for the fetch states and update the flags
    _bloc.stream.listen((state) {
      if (state is FetchMoviesResultState) {
        endSplash();
      }
      if (state is MoviesLoadedErrorState) {
        if (kDebugMode) {
          print(state.error);
        }
      }
    });
  }

  // End the splash screen and navigate based on guest status
  void endSplash() {
    if (VariablesManager.isGuest == false) {
      Navigator.pushReplacementNamed(
        context,
        VariablesManager.isFirstTimeOpened
            ? RouteStringsManager.onboardingRoute
            : SharedPref.prefs.getString(GeneralStrings.currentUser) == null
                ? RouteStringsManager.questionRoute
                : RouteStringsManager.mainRoute,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        RouteStringsManager.mainRoute,
      );
    }
    _bloc.add(StartFetchFirebaseEvent());
  }

  @override
  void dispose() {}
}

// Methods interface for the splash screen
mixin SplashRouteMethods {
  Future<void> startDelay();
}
