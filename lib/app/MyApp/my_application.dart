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
import '../../presentation/routs&view_models/more_detail_route/more_detail_view.dart';
import '../components/constants/routs_manager.dart';
import '../dependencies_injection/dependency_injection.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late bool showNoInternetDialog;

  @override
  void initState() {
    super.initState();
    showNoInternetDialog = false;
  }

  void _showNoInternetDialog({required EventsBloc bloc}) {
    showNoInternetDialog = true;
    bloc.add(ShowNoInternetDialog());
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
    EventsBloc bloc = instance<EventsBloc>();
    return BlocConsumer<EventsBloc, AppStates>(
      builder: (context, state) {
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

          home: MoreDetailView(),
          // SharedPref.getBool(GeneralStrings.isManual)!
          //   ? TheAppMode.appMode
          //   : bloc.toggleLightAndDark(context),
        );
      },
      listener: (context, state) {
        if (state is DisconnectedState) {
          _showNoInternetDialog(bloc: bloc);
        }

        if (state is ConnectedState &&
            showNoInternetDialog &&
            navigatorKey.currentContext != null) {
          Navigator.pop(navigatorKey.currentContext!);
        }
      },
    );
  }
}
