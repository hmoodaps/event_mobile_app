import 'package:elegant_notification/elegant_notification.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';
import 'general_strings.dart';

errorNotification(
    {required BuildContext context,
    required String description,
    required Color backgroundColor}) {
  return ElegantNotification.error(
    background: backgroundColor,
    title: Text(
      GeneralStrings.error,
      style: TextStyleManager.lightTitle(context),
    ),
    description: Text(
      description,
      style: TextStyleManager.lightBody(context),
    ),
    animationDuration: Duration(seconds: SizeManager.i4),
    toastDuration: Duration(seconds: SizeManager.i6),
  ).show(context);
}

successNotification(
    {required BuildContext context,
    required String description,
    required Color backgroundColor}) {
  return ElegantNotification(
    background: backgroundColor,
    title: Text(
      GeneralStrings.success,
      style: TextStyleManager.lightTitle(context),
    ),
    description: Text(
      description,
      style: TextStyleManager.lightBody(context),
    ),
    animationDuration: Duration(seconds: SizeManager.i4),
    toastDuration: Duration(seconds: SizeManager.i6),
  ).show(context);
}
