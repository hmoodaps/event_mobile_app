import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:flutter/material.dart';

import 'general_strings.dart';

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w700;
  static const FontWeight bold = FontWeight.w900;
}

TextStyle _textStyle({
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

class TextStyleManager {
  static TextStyle lightHeader = _textStyle(
      fontWeight: FontWeightManager.bold,
      fontSize: SizeManager.d24,
      fontFamily: GeneralStrings.sand,
      color: VariablesManager.isDark ? Colors.white : Colors.black);

  static TextStyle lightTitle = _textStyle(
      fontWeight: FontWeight.bold,
      fontSize: SizeManager.d20,
      fontFamily: GeneralStrings.sand,
      color: VariablesManager.isDark ? Colors.white : Colors.black);

  static TextStyle lightBody = _textStyle(
      fontWeight: FontWeightManager.light,
      fontSize: SizeManager.d16,
      fontFamily: GeneralStrings.sand,
      color: VariablesManager.isDark ? Colors.white : Colors.black);

  static TextStyle lightParagraph = _textStyle(
      fontWeight: FontWeightManager.regular,
      fontSize: SizeManager.d14,
      fontFamily: GeneralStrings.cinzel,
      color: VariablesManager.isDark ? Colors.white : Colors.black);
}
