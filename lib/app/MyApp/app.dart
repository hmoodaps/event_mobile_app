import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/bloc_state_managment/events.dart';
import 'my_application.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _app = MyApp._internal();

  factory MyApp() => _app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc()
        ..add(SharedPref.prefs.getString(GeneralStrings.currentUser) != null
            ? GetCurrentUserResponseEvent()
            : GetFavesItemsEvent())
        ..add(InternetStatusChangeEvent()),
      child: Application(),
    );
  }
}