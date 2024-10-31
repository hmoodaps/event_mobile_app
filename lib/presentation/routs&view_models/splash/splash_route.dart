import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../bloc_state_managment/states.dart';
import 'splash_model_view.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({super.key});

  @override
  State<SplashRoute> createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  late SplashModelView _model;
  double _progressValue = 0.0; // Initial value for the progress indicator

  @override
  void initState() {
    super.initState();
    _model = SplashModelView();
    _model.context = context;
    _model.start(); // Start fetching data and splash screen logic
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
      builder: (context, state) => getScaffold(),
      listener: (context, state) {
        // Handle the progress updates based on Bloc events and states

        // When starting to fetch movies, update progress to 50%
        if (state is StartFetchMoviesState) {
          setState(() {
            _progressValue = 0.5;
          });
        }

        // When movies fetching is done, update progress to 75%
        if (state is InitFetchMoviesState) {
          setState(() {
            _progressValue = 0.75;
          });
        }

        // When starting to fetch Firebase data, update progress to 75%
        if (state is StartFetchFirebaseState) {
          setState(() {
            _progressValue = 0.75;
          });
        }

        // When Firebase fetching is done, update progress to 100%
        if (state is InitFetchFirebaseState) {
          setState(() {
            _progressValue = 1.0;
          });
          _model.endSplash(); // End the splash screen and navigate
        }
      },
    );
  }

  // UI for the splash screen with a progress indicator
  Widget getScaffold() => Scaffold(
    backgroundColor: ColorManager.primarySecond,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.cinemaAsset,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          CircularProgressIndicator(
            value: _progressValue, // Bind progress value to the state
            backgroundColor: Colors.grey[300],
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 20),
          Text(
            '${(_progressValue * 100).toInt()}%', // Display progress as percentage
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
