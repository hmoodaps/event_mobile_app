import 'package:flutter/material.dart';

import '../../bloc_state_managment/bloc_manage.dart';

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
    EventsBloc bloc = EventsBloc.get(context);

    return bloc.lightHeader(context);
  }

  static TextStyle? lightTitle(BuildContext context) {
    EventsBloc bloc = EventsBloc.get(context);

    return bloc.lightTitle(context);
  }

  static TextStyle? lightBody(BuildContext context) {
    EventsBloc bloc = EventsBloc.get(context);

    return bloc.lightBody(context);
  }

  static TextStyle? lightParagraph(BuildContext context) {
    EventsBloc bloc = EventsBloc.get(context);

    return bloc.lightParagraph(context);
  }
}
