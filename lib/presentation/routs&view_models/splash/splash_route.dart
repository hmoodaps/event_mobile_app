import 'package:event_mobile_app/presentation/routs&view_models/splash/splash_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/getSize/getSize.dart';
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
    _model = SplashModelView(context);
    _model.start();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(builder: (context, state) {
      return getScaffold();
    });
  }

  // UI for the splash screen with a progress indicator
  Widget getScaffold() => Scaffold(
        backgroundColor: ColorManager.primarySecond,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 4,
                  child: Image.asset(AssetsManager.just4prog)),
              SizedBox(height: GetSize.heightValue(SizeManager.d20, context)),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 4.5,
                  height: MediaQuery.of(context).size.width / 4.5,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    backgroundColor: Colors.transparent,
                    colors: ColorManager.colorsList,
                  )),
              SizedBox(height: GetSize.heightValue(SizeManager.d20, context)),
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
