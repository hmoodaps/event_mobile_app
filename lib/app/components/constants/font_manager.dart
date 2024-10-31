import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
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

  static TextStyle? lightHeader(BuildContext context) {

    return VariablesManager.lightHeader(context);
  }

  static TextStyle? lightTitle(BuildContext context) {

    return VariablesManager.lightTitle(context);
  }

  static TextStyle? lightBody(BuildContext context) {
    return VariablesManager.lightBody(context);
  }

  static TextStyle? lightParagraph(BuildContext context) {

    return VariablesManager.lightParagraph(context);
  }
}
