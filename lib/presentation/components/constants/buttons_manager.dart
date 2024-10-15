import 'package:event_mobile_app/presentation/components/constants/color_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:flutter/material.dart';

import 'font_manager.dart';

class ButtonManager {
  static Widget myButton({
    required BuildContext context,
    required String buttonName,
    IconData? prefixIcon,
    IconData? suffixIcon,
    required void Function() onTap,
    required Color color,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: ContainerManager.myContainer(
            color: color,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(SizeManager.d12),
                child: Row(
                  children: [
                    Icon(prefixIcon, color: ColorManager.privateGrey),
                    Spacer(),
                    Text(
                      buttonName,
                      style: TextStyleManager.lightTitle(context),
                    ),
                    Spacer(),
                    Icon(suffixIcon, color: ColorManager.privateGrey),
                  ],
                ),
              ),
            ),
            context: context),
      );
}

class ContainerManager {
  static Widget myContainer(
      {required Widget child,
      required BuildContext context,
      Color? color,
      double? height}) {
    return Container(
      height: height ?? SizeManager.d70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(SizeManager.d20),
        ),
        color: color ?? Colors.red,
        boxShadow: [
          myShadow(),
        ],
      ),
      child: child,
    );
  }

  static BoxShadow myShadow() {
    return BoxShadow(
      color: Colors.grey.shade800,
      // لون الظل مع الشفافية
      offset: Offset(SizeManager.d4, SizeManager.d10),
      // موضع الظل (إزاحة عمودية)
      blurRadius: SizeManager.d8,
      // مدى تمويه الظل
      spreadRadius: SizeManager.d1, // مدى انتشار الظل
    );
  }
}
