import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';
import 'main_route_model_view.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({super.key});

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  late final MainRouteModelView _model;

  @override
  void initState() {
    super.initState();
    _model = MainRouteModelView(context);
    _model.start();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) =>
          _getScaffold(isDark: VariablesManager.isDark),
    );
  }

  Widget _getScaffold({required bool isDark}) => Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            height: SizeManager.d50,
            onTap: (index) => _model.onTap(index),
            backgroundColor:
                isDark ? ColorManager.green4 : ColorManager.primary,
            color: ColorManager.primarySecond,
            items: _model.bottomNavigationBarItems),
        body: _model.onNavigationBarIconPress(),
      );
}
