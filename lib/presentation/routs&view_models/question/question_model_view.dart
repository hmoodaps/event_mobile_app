import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';

class QuestionModelView extends BaseViewModel with QuestionNavigateFunctions {
  @override
  void dispose() {}

  @override
  void start() {}

  @override
  navigateToLogin({required BuildContext context}) {
    navigateTo(context, RouteStringsManager.loginRoute);
  }

  @override
  navigateToMain({required BuildContext context}) {
    SharedPref.saveBool(key: GeneralStrings.isGuest, value: true);
    Navigator.pushNamedAndRemoveUntil(context, RouteStringsManager.mainRoute,(route)=>false );
  }

  @override
  navigateToRegister({required BuildContext context}) {
    navigateTo(context, RouteStringsManager.registerRoute);
  }
}

mixin QuestionNavigateFunctions {
  navigateToMain({required BuildContext context});

  navigateToRegister({required BuildContext context});

  navigateToLogin({required BuildContext context});
}
