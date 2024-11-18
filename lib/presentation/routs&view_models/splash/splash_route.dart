import 'package:event_mobile_app/presentation/routs&view_models/splash/splash_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/notification_handler.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({super.key});

  @override
  State<SplashRoute> createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  late SplashModelView _model;

  @override
  void initState() {
    super.initState();
    _model = SplashModelView();
    _model.context = context;
    _model.start();
    _model.startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
      builder: (context, state) {
        return getScaffold();
      },
      listener: (context, state) {
        if (state is MoviesLoadedErrorState) {
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
              Image.asset(AssetsManager.just4prog),
              SizedBox(height: SizeManager.d20),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    backgroundColor: Colors.transparent,
                    colors: ColorManager.colorsList,
                  )),
              SizedBox(height: SizeManager.d20),
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
