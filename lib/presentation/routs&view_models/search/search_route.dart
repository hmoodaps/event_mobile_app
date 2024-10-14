import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_state_managment/bloc_manage.dart';
import '../../components/constants/stack_background_manager.dart';
import '../../components/constants/variables_manager.dart';
class SearchRoute extends StatefulWidget {
  const SearchRoute({super.key});

  @override
  State<SearchRoute> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  @override
  Widget build(BuildContext context) {
    EventsBloc bloc = EventsBloc.get(context);

    return BlocConsumer<EventsBloc , AppStates>(builder: (context  , state)=>getScaffold(isDark : VariablesManager.isDark), listener: (context  , state){});
  }
  Widget getScaffold({ required bool  isDark})=>Scaffold(
    body: stackBackGroundManager(isDark: isDark),
  );
  List<Widget> screenWidgets ()=>[];
}
