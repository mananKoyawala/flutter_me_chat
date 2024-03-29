import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Constants.dart';

// ignore: must_be_immutable
class TheTextFeild extends StatelessWidget {
  TheTextFeild({
    super.key,
    this.readOnly,
    this.autofocus,
    this.textInputAction,
    this.border,
    this.controller,
    this.showCursor,
    required this.funValidate,
    this.cursorColor,
    this.obsecureText,
    this.textInputType,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.labelText,
    this.hintText,
    this.borderRadius,
    this.fieldColor,
    required this.isborder,
    this.onClickColor,
    this.borderWidth,
    this.onTap,
  });

  double bottomInsets = MediaQuery.of(Get.context!).viewInsets.bottom;

  final bool? readOnly;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final InputBorder? border;
  final TextEditingController? controller;
  final bool? showCursor;
  final String? Function(String?) funValidate;
  final Color? cursorColor;
  final bool? obsecureText;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final String? labelText;
  final String? hintText;
  final double? borderRadius;
  final Color? fieldColor;
  final bool isborder;
  final Color? onClickColor;
  final double? borderWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: readOnly ?? false,
        autofocus: autofocus ?? false,
        textInputAction: textInputAction,
        showCursor: showCursor,
        controller: controller,
        validator: funValidate,
        onTap: onTap,
        cursorColor: cursorColor ?? black,
        obscureText: obsecureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        scrollPadding: EdgeInsets.only(bottom: bottomInsets + 65.0),
        onChanged: onChanged,
        maxLines: maxLines,
        style: textStyle ??
            TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: black),
        maxLength: maxLength,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          counterText: "",
          labelText: labelText,
          prefixIcon: prefixIcon,
          errorStyle: const TextStyle(fontSize: 14),
          labelStyle: labelStyle ??
              const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w400, color: black),
          enabledBorder: isborder == false
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 20))),
          errorBorder: isborder == false
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                )
              : OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 20))),
          focusedErrorBorder: isborder == false
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 20))),
          focusedBorder: isborder == false
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: onClickColor ?? black, width: borderWidth ?? 1.5),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(
                      color: onClickColor ?? black, width: borderWidth ?? 1.5),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 20))),
          border: isborder == false
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                )
              : OutlineInputBorder(
                  borderSide: BorderSide(color: fieldColor ?? black),
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius ?? 20))),
        ));
  }
}
