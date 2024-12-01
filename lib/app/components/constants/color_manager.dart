import 'package:flutter/material.dart';

// Manages and updates the application's colors.
class ColorManager {
  static Color primary = Colors.grey;
  static Color primarySecond = Colors.grey;
  static const Color privateYalow = Color(0xFFFFBB00);
  static const Color privateGrey = Color(0xFF828282);
  static const Color privateBlue = Color(0xFF40E0D0);
  static const Color privateWhite = Color(0xFFF5F5DC);
  static const Color lightBlue = Colors.cyanAccent;

  static Color green1 = Colors.grey;
  static Color green2 = Colors.grey;
  static Color green3 = Colors.grey;
  static Color green4 = Colors.grey;

  static List<Color> colorsList = [
    primary,
    privateYalow,
    privateGrey,
    privateBlue,
    green1,
    green2,
    green3,
  ];

  // Updates the app's colors based on the selected theme.
  static void updateColors(AppColorManager appColorManager) {
    print("Updating colors...");
    primary = appColorManager.primary;
    primarySecond = appColorManager.primarySecond;
    green1 = appColorManager.green1;
    green2 = appColorManager.green2;
    green3 = appColorManager.green3;
    green4 = appColorManager.green4;
    print("Colors updated: $primary, $primarySecond, $green1");
  }
}

// Abstract class for managing app color themes.
abstract class AppColorManager {
  late Color primary;
  late Color primarySecond;

  late Color green1;
  late Color green2;
  late Color green3;
  late Color green4;
}
