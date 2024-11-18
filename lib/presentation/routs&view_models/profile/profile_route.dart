import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/handle_app_language/handle_app_language.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/handle_app_theme/handle_app_theme_colors.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  @override
  Widget build(BuildContext context) {
    EventsBloc bloc = EventsBloc.get(context);
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) => Scaffold(
              body: stackBackGroundManager(
                  isDark: false, otherWidget: screenWidgets(bloc)),
            ),
        listener: (context, state) {
          if (state is LogoutState) {
            SharedPref.prefs.remove(GeneralStrings.currentUser);
            Navigator.pushReplacementNamed(
              context,
              RouteStringsManager.questionRoute,
            );
          }
        });
  }

  List<Widget> screenWidgets(EventsBloc bloc) => [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            googleAndAppleButton(
                nameOfButton: "login",
                context: context,
                onTap: () {
                  navigateTo(context, RouteStringsManager.loginRoute);
                }),
            SizedBox(
              height: 10,
            ),
            googleAndAppleButton(
                nameOfButton: "logout",
                context: context,
                onTap: () {
                  bloc.add(LogoutEvent());
                }),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      bloc.add(ChangeColorModeEvent(AppColorsTheme.green));
                    },
                    child: Container(
                      height: 70,
                      width: 120,
                      color: Colors.green,
                    )),
                GestureDetector(
                    onTap: () {
                      bloc.add(ChangeColorModeEvent(AppColorsTheme.purple));
                    },
                    child: Container(
                      height: 70,
                      width: 120,
                      color: Colors.purple,
                    )),
                GestureDetector(
                    onTap: () {
                      bloc.add(ChangeColorModeEvent(AppColorsTheme.blue));
                    },
                    child: Container(
                      height: 70,
                      width: 120,
                      color: Colors.blue,
                    )),
              ],
            ),
            GestureDetector(
                onTap: () {
                  bloc.add(ChangeLanguageEvent(ApplicationLanguage.ar));
                },
                child: Container(
                  height: 70,
                  width: 120,
                  color: Colors.red,
                  child: Text(GeneralStrings.arabicLanguage),
                )),
            GestureDetector(
                onTap: () {
                  bloc.add(ChangeLanguageEvent(ApplicationLanguage.en));
                },
                child: Container(
                  height: 70,
                  width: 120,
                  color: Colors.red,
                  child: Text(GeneralStrings.englishLanguage),
                )),
            GestureDetector(
                onTap: () {
                  bloc.add(ChangeLanguageEvent(ApplicationLanguage.nl));
                },
                child: Container(
                  height: 70,
                  width: 120,
                  color: Colors.red,
                  child: Text(GeneralStrings.netherlandsLanguage),
                )),
          ],
        ),
      ];
}
