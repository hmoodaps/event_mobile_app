import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/handle_app_language/handle_app_language.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../data/local_storage/shared_local.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import '../../presentation/bloc_state_managment/events.dart';
import '../components/constants/routs_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _app = MyApp._internal();

  factory MyApp() => _app;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showNoInternetDialog = false;

  void _showNoInternetDialog() {
    setState(() {
      showNoInternetDialog = true;
    });
    final navigatorContext = navigatorKey.currentContext;
    if (navigatorContext != null) {
      showDialog(
        context: navigatorContext,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(GeneralStrings.lostConnection(context)),
            content: Text(GeneralStrings.lostConnectionContent(context)),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc()..add(InternetStatusChangeEvent()),
      child: BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) {
          EventsBloc bloc = EventsBloc.get(context);
          if (kDebugMode) {
            print(
                'current user${SharedPref.prefs.getString(GeneralStrings.currentUser)}');
          }

          return MaterialApp(
            navigatorKey: navigatorKey,
            locale: Locale(TheAppLanguage.appLanguage),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateRoute: Routes.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            theme: bloc.toggleLightAndDark(context),
          );
        },
        listener: (context, state) {
          if (state is DisconnectedState) {
            _showNoInternetDialog();
          }

          if (state is ConnectedState &&
              showNoInternetDialog &&
              navigatorKey.currentContext != null) {
            Navigator.pop(navigatorKey.currentContext!);
          }
        },
      ),
    );
  }
}
