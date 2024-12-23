import 'package:flutter/cupertino.dart';

class GetSize {
  static double widthValue(double value, BuildContext context) {
    return ((MediaQuery.sizeOf(context).width / 411.42857142857144) * value);
  }

  static double heightValue(double value, BuildContext context) {
    return ((MediaQuery.sizeOf(context).height / 891.4285714285714) * value);
  }
}
