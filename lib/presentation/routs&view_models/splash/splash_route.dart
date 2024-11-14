import 'package:event_mobile_app/app/components/constants/notification_handler.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/size_manager.dart';
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
    _model.startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
      builder: (context, state) {
        return getScaffold();
      },
      listener: (context, state) {
        if (state is StartFetchMoviesState) {
          setState(() {
            _progressValue = 0.25;
          });
        }
        if (state is MoviesLoadedState) {
          setState(() {
            _progressValue = 1.0;
          });
        }
        // if (state is StartFetchFirebaseState) {
        //   setState(() {
        //     _progressValue = 0.75;
        //   });
        // }
        // if (state is InitFetchFirebaseState) {
        //   setState(() {
        //     _progressValue = 5.0;
        //   });
        //   if (VariablesManager.movies.isNotEmpty) {
        //     _model.endSplash();
        //   }
        // }
        if (state is InitFetchMoviesErrorState) {
          errorNotification(context: context, description: state.error);
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
          SizedBox(height: SizeManager.d20),
          LinearProgressIndicator(
            value: _progressValue, // Bind progress value to the state
            backgroundColor: Colors.grey[300],
            color: Colors.blueAccent,
          ),
          SizedBox(height: SizeManager.d20),
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

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}
