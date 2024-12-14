import 'package:flutter/material.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../../../data/local_storage/shared_local.dart';

class QuestionModelView extends QuestionNavigateFunctions {
  BuildContext context;

  QuestionModelView(this.context);

  @override
  navigateToLogin() {
    navigateTo(context, RouteStringsManager.loginRoute);
  }

  @override
  navigateToMain() {
    SharedPref.prefs.setBool(GeneralStrings.isGuest, true);
    Navigator.pushReplacementNamed(
      context,
      RouteStringsManager.mainRoute,
    );
  }

  @override
  navigateToRegister() {
    navigateTo(context, RouteStringsManager.registerRoute);
  }
}

abstract class QuestionNavigateFunctions {
  navigateToMain();

  navigateToRegister();

  navigateToLogin();
}
