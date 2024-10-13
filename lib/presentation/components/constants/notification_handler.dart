import 'package:elegant_notification/elegant_notification.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';
import 'general_strings.dart';


errorNotification({required BuildContext context , required String description }){
  return ElegantNotification.error(
    background:     VariablesManager.isDark ? Colors.white : Colors.black,
    title: Text(GeneralStrings.error , style: TextStyleManager.lightTitle,),
    description: Text(description,style: TextStyleManager.lightBody,),
    animationDuration: Duration(seconds: SizeManager.i4),
    toastDuration: Duration(seconds: SizeManager.i6),
  ).show(context);
}
successNotification({required BuildContext context  , required String description }){
  return ElegantNotification(
    background:VariablesManager.isDark ? Colors.white : Colors.black,
    title: Text(GeneralStrings.success , style: TextStyleManager.lightTitle,),
    description: Text(description,style: TextStyleManager.lightBody,),
    animationDuration: Duration(seconds: SizeManager.i4),
    toastDuration: Duration(seconds: SizeManager.i6),
  ).show(context);
}

