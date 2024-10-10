import 'package:elegant_notification/elegant_notification.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:flutter/cupertino.dart';

import 'font_manager.dart';
import 'general_strings.dart';


errorNotification({required BuildContext context , required String description }){
  return ElegantNotification.error(
    title: Text(GeneralStrings.error , style: TextStyleManager.lightTitle,),
    description: Text(description,style: TextStyleManager.lightBody,),
    animationDuration: Duration(seconds: SizeManager.i4),
    toastDuration: Duration(seconds: SizeManager.i6),
  ).show(context);
}
successNotification({required BuildContext context  , required String description }){
  return ElegantNotification(

    title: Text(GeneralStrings.success , style: TextStyleManager.lightTitle,),
    description: Text(description,style: TextStyleManager.lightBody,),
    animationDuration: Duration(seconds: SizeManager.i4),
    toastDuration: Duration(seconds: SizeManager.i6),
  ).show(context);
}

