import 'package:event_mobile_app/presentation/components/constants/font_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

TextFormField textFormField({
  bool? readOnly,
  required TextEditingController controller,
  String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  bool? obscureText,
  TextInputType? keyboardType,
  void Function()? onEditingComplete,
  Widget? suffix,
  Widget? prefix,
  String? hintText,
  String? labelText,
  bool? filled,
  Color? fillColor,
}) {
  return defaultTextFormField(
    controller: controller,
    hintText: hintText,
    fillColor: fillColor,
    filled: filled,
    labelText: labelText,
    suffix: suffix,
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    prefix: prefix,
    keyboardType: keyboardType,
    obscureText: obscureText,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    readOnly: readOnly,
    disabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.privateBlue),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(SizeManager.d2),
            bottomRight: Radius.circular(SizeManager.d20),
            bottomLeft: Radius.circular(SizeManager.d2),
            topLeft: Radius.circular(20))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.privateBlue),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(SizeManager.d2),
            bottomRight: Radius.circular(SizeManager.d20),
            bottomLeft: Radius.circular(SizeManager.d2),
            topLeft: Radius.circular(20))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.privateYalow),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeManager.d2),
            bottomLeft: Radius.circular(SizeManager.d20),
            bottomRight: Radius.circular(SizeManager.d2),
            topRight: Radius.circular(20))),
  );
}

// searchFormField
TextFormField searchFormField({
  bool? readOnly,
  required TextEditingController controller,
  String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  bool? obscureText,
  TextInputType? keyboardType,
  void Function()? onEditingComplete,
  Widget? suffix,
  Widget? prefix,
  String? hintText,
  String? labelText,
  bool? filled,
  Color? fillColor,
}) {
  return defaultTextFormField(
    controller: controller,
    hintText: hintText,
    fillColor: fillColor,
    filled: filled,
    labelText: labelText,
    suffix: suffix,
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    prefix: prefix,
    keyboardType: keyboardType,
    obscureText: obscureText,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    readOnly: readOnly,
    border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.privateBlue),
        borderRadius: BorderRadius.all(Radius.circular(SizeManager.d200))),
  );
}

//default Text Form Field
TextFormField defaultTextFormField({
  bool? readOnly,
  required TextEditingController controller,
  String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  bool? obscureText,
  TextInputType? keyboardType,
  void Function()? onEditingComplete,
  Widget? suffix,
  Widget? prefix,
  String? hintText,
  String? labelText,
  bool? filled,
  Color? fillColor,
  OutlineInputBorder? focusedBorder,
  OutlineInputBorder? enabledBorder,
  OutlineInputBorder? border,
  OutlineInputBorder? disabledBorder,
}) {
  return TextFormField(
    readOnly: readOnly ?? false,
    controller: controller,
    validator: validator,
    cursorErrorColor: Colors.red,
    cursorColor: ColorManager.privateYalow,
    textInputAction: TextInputAction.next,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    obscureText: obscureText ?? false,
    keyboardType: keyboardType,
    onEditingComplete: onEditingComplete,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(SizeManager.d18),
      labelText: labelText,
      labelStyle: TextStyleManager.lightBody,
      filled: filled ?? false,
      fillColor: fillColor,
      errorStyle: const TextStyle(fontFamily: 'cinzel', color: Colors.red),
      focusColor: ColorManager.primarySecond,
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red)),
      suffix: Padding(
          padding: EdgeInsets.only(left: SizeManager.d8), child: suffix),
      prefix: Padding(
          padding: EdgeInsets.only(right: SizeManager.d8), child: prefix),
      hintText: hintText,
      focusedBorder: focusedBorder,
      enabledBorder: enabledBorder,
      border: border,
      disabledBorder: disabledBorder,
    ),
  );
}
