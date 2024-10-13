import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakeUserDetailsRoute extends StatefulWidget {
  const TakeUserDetailsRoute({super.key});

  @override
  State<TakeUserDetailsRoute> createState() => _TakeUserDetailsRouteState();
}

class _TakeUserDetailsRouteState extends State<TakeUserDetailsRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) => getScaffold(),
        listener: (context, state) {});
  }

  Widget getScaffold() {
    return Scaffold(

    );
  }
}
