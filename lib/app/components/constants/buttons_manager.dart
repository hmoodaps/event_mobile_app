import 'package:event_mobile_app/app/components/constants/getSize/getSize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'size_manager.dart';

class ButtonManager {
  static Widget myButton({
    required BuildContext context,
    required String buttonName,
    IconData? prefixIcon,
    IconData? suffixIcon,
    required void Function() onTap,
    required Color color,
    Color? shadowColor,
    Color? textColor,
    double? height,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: ContainerManager.myContainer(
            height: height != null
                ? GetSize.heightValue(height, context)
                : GetSize.heightValue(SizeManager.d70, context),
            shadowColor: shadowColor,
            color: color,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(SizeManager.d12),
                child: Row(
                  children: [
                    Icon(prefixIcon, color: ColorManager.privateGrey),
                    Spacer(),
                    Text(
                      buttonName,
                      style: TextStyleManager.titleStyle(context)
                          ?.copyWith(color: textColor),
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
      List<Color>? colors,
      Color? color,
      Color? shadowColor,
      List<double>? stops,
      double? height}) {
    return Container(
      height: height != null
          ? GetSize.heightValue(height, context)
          : GetSize.heightValue(SizeManager.d70, context),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(SizeManager.d20),
        ),
        gradient: LinearGradient(
            colors: colors ?? [],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: stops ?? []),
        boxShadow: [
          myShadow(shadowColor: shadowColor),
        ],
      ),
      child: child,
    );
  }

  static BoxShadow myShadow({Color? shadowColor}) {
    return BoxShadow(
      color: shadowColor ?? Colors.grey.shade800,
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
  Color? suffixSvgColor,
  Color? shadowColor,
  int? delay,
}) {
  return StaggeredAnimatedWidget(
    delay: delay ?? SizeManager.i1400,
    child: GestureDetector(
      onTap: onTap,
      child: ContainerManager.myContainer(
        shadowColor: shadowColor ?? Colors.white,
        color: color ?? Colors.grey.shade400,
        context: context,
        child: Padding(
          padding: EdgeInsets.all(SizeManager.d12),
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
                      height: GetSize.heightValue(SizeManager.d50, context),
                      width: GetSize.widthValue(SizeManager.d70, context),
                    ),
                  SizedBox(width: GetSize.widthValue(SizeManager.d20, context)),
                  Text(nameOfButton,
                      style: TextStyleManager.titleStyle(context)),
                  Spacer(),
                  if (sufixSvgAssetPath != null)
                    SvgPicture.asset(
                      sufixSvgAssetPath,
                      color: suffixSvgColor ?? Colors.black,
                      height: GetSize.heightValue(SizeManager.d50, context),
                      width: GetSize.widthValue(SizeManager.d70, context),
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
