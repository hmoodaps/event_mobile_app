import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';

class SearchRoute extends StatefulWidget {
  const SearchRoute({super.key});

  @override
  State<SearchRoute> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) =>
            getScaffold(isDark: VariablesManager.isDark),
        listener: (context, state) {});
  }

  Widget getScaffold({required bool isDark}) => Scaffold(
        body: stackBackGroundManager(isDark: isDark),
      );

  List<Widget> screenWidgets() => [];
}
