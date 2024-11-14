import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import 'color_manager.dart';
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
                padding:  EdgeInsets.all(SizeManager.d12),
                child: Row(
                  children: [
                    Icon(prefixIcon, color: ColorManager.privateGrey),
                    Spacer(),
                    Text(
                      buttonName,
                      style: TextStyleManager.titleStyle(context),
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

Widget googleAndAppleButton({
  required String nameOfButton,
  required BuildContext context,
  void Function()? onTap,
  String? prefixSvgAssetPath,
  String? sufixSvgAssetPath,
  Color? color,
  int?delay,

}) {
  return StaggeredAnimatedWidget(
    delay: delay ?? SizeManager.i1400,
    child: GestureDetector(
      onTap: onTap,
      child: ContainerManager.myContainer(
        color: color ?? Colors.grey.shade400,
        context: context,
        child: Padding(
          padding:  EdgeInsets.all(SizeManager.d12),
          child: Align(
            alignment: Alignment.center,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  if (prefixSvgAssetPath != null)
                    SvgPicture.asset(
                      prefixSvgAssetPath,
                      height: SizeManager.d50,
                      width: SizeManager.d70,
                    ),
                  SizedBox(width: SizeManager.d20),
                  Text(
                    nameOfButton,
                      style:TextStyleManager.titleStyle(context)                  ),
                  Spacer(),
                  if (sufixSvgAssetPath != null)
                    SvgPicture.asset(
                      sufixSvgAssetPath,
                      height: SizeManager.d50,
                      width: SizeManager.d70,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}