import 'dart:convert';
import 'dart:io';
import 'package:event_mobile_app/app/components/constants/buttons_manager.dart';
import 'package:event_mobile_app/app/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/app/components/constants/routs_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/stack_background_manager.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: stackBackGroundManager(isDark: false,
      otherWidget:screenWidgets()
    ),
  );
}

List<Widget> screenWidgets() => [
  Center(child: googleAndAppleButton(nameOfButton: "login", context: context , onTap: (){navigateTo(context, RouteStringsManager.loginRoute);}),),


];
}
