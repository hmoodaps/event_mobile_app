import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/components/constants/general_strings.dart';
import 'package:event_mobile_app/presentation/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/routs_manager.dart';
import 'package:flutter/cupertino.dart';

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
    navigateTo(context, RouteStringsManager.mainRoute);
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
