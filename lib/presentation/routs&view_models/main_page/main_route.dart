import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/main_page/main_route_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/variables_manager.dart';

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
    _model = MainRouteModelView();
    _model.context = context;
    _model.start();
  }

  @override
  Widget build(BuildContext context) {
  //  EventsBloc bloc = EventsBloc.get(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) =>
            getScaffold(isDark: VariablesManager.isDark),
        listener: (context, state) {});
  }

  Widget getScaffold({required bool isDark}) =>
      Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
            height: SizeManager.d50,
            onTap: (index) => _model.onTap(index),
            backgroundColor: isDark
                ? ColorManager.green4
                : ColorManager.primary,
            color: ColorManager.primarySecond,
            items: _model.bottomNavigationBarItems),
        body: _model.onNavigationBarIconPress(),
      );
}
