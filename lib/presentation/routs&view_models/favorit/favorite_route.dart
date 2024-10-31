import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../bloc_state_managment/states.dart';
class FavoriteRoute extends StatefulWidget {
  const FavoriteRoute({super.key});

  @override
  State<FavoriteRoute> createState() => _FavoriteRouteState();
}

class _FavoriteRouteState extends State<FavoriteRoute> {
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
