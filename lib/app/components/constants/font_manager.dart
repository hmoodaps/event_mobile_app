import 'package:flutter/material.dart';

import '../../../presentation/bloc_state_managment/bloc_manage.dart';

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
