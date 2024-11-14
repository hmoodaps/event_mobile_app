import 'package:elegant_notification/elegant_notification.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';
import 'general_strings.dart';

errorNotification(
    {required BuildContext context,
    required String description,
     Color ? backgroundColor}) {
  return ElegantNotification.error(
    background: backgroundColor ?? Colors.white,
    title: Text(
      GeneralStrings.error(context),
      style: TextStyleManager.titleStyle(context),
    ),
    description: Text(
      description,
      style: TextStyleManager.bodyStyle(context),
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
      GeneralStrings.success(context),
      style: TextStyleManager.titleStyle(context),
    ),
    description: Text(
      description,
      style: TextStyleManager.bodyStyle(context),
    ),
    animationDuration: Duration(seconds: SizeManager.i4),
    toastDuration: Duration(seconds: SizeManager.i6),
  ).show(context);
}
