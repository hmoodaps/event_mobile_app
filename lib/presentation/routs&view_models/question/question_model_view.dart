import 'package:flutter/material.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../../../data/local_storage/shared_local.dart';

class QuestionModelView extends QuestionNavigateFunctions {
  @override
  navigateToLogin({required BuildContext context}) {
    navigateTo(context, RouteStringsManager.loginRoute);
  }

  @override
  navigateToMain({required BuildContext context}) {
    SharedPref.saveBool(key: GeneralStrings.isGuest, value: true);
    Navigator.pushReplacementNamed(
        context, RouteStringsManager.mainRoute, );
  }

  @override
  navigateToRegister({required BuildContext context}) {
    navigateTo(context, RouteStringsManager.registerRoute);
  }
}

abstract class QuestionNavigateFunctions {
  navigateToMain({required BuildContext context});

  navigateToRegister({required BuildContext context});

  navigateToLogin({required BuildContext context});
}
