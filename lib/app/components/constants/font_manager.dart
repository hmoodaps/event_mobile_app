import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/app/dependencies_injection/dependency_injection.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/material.dart';


class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w700;
  static const FontWeight bold = FontWeight.w900;
}

class TextStyleManager {
  static TextStyle textStyle({
    required FontWeight fontWeight,
    required double fontSize,
    required String fontFamily,
    required Color color,
  }) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color);
  }

  static TextStyle? header(BuildContext context) {

    return EventsBloc.headerStyle(context);
  }

  static TextStyle? titleStyle(BuildContext context) {

    return EventsBloc.titleStyle(context);
  }

  static TextStyle? bodyStyle(BuildContext context) {
    return EventsBloc.bodyStyle(context);
  }

  static TextStyle? paragraphStyle(BuildContext context) {

    return EventsBloc.paragraphStyle(context);
  }
  static TextStyle? smallParagraphStyle(BuildContext context) {

    return EventsBloc.smallParagraphStyle(context);
  }
}
