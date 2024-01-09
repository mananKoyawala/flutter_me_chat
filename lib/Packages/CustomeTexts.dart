import 'package:flutter/material.dart';

class TextFW700 extends StatelessWidget {
  const TextFW700(
      {super.key,
      required this.text,
      this.textcolor,
      this.fontWeight,
      required this.fontSize,
      this.textAlign,
      this.fontFamily,
      this.decoration,
      this.overflow,
      this.maxLines});
  final String text;
  final Color? textcolor;
  final FontWeight? fontWeight;
  final double fontSize;
  final TextAlign? textAlign;
  final String? fontFamily;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w700,
          color: textcolor ?? Colors.black,
          fontFamily: fontFamily,
          decoration: decoration),
    );
  }
}

class TextFW600 extends StatelessWidget {
  const TextFW600(
      {super.key,
      required this.text,
      this.textcolor,
      this.fontWeight,
      required this.fontSize,
      this.textAlign,
      this.fontStyle,
      this.fontFamily,
      this.decoration,
      this.overflow,
      this.maxLines});
  final String text;
  final Color? textcolor;
  final FontWeight? fontWeight;
  final double fontSize;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textcolor ?? Colors.black,
          decoration: decoration),
    );
  }
}

class TextFW500 extends StatelessWidget {
  const TextFW500(
      {super.key,
      required this.text,
      this.textColor,
      this.fontWeight,
      required this.fontSize,
      this.textAlign,
      this.fontStyle,
      this.fontFamily,
      this.decoration,
      this.overflow,
      this.maxLines});
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double fontSize;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: textColor ?? Colors.black,
          decoration: decoration),
    );
  }
}

class TextFW400 extends StatelessWidget {
  const TextFW400(
      {super.key,
      required this.text,
      this.textcolor,
      this.fontWeight,
      required this.fontSize,
      this.textAlign,
      this.fontStyle,
      this.fontFamily,
      this.decoration,
      this.overflow,
      this.maxLines});
  final String text;
  final Color? textcolor;
  final FontWeight? fontWeight;
  final double fontSize;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: textcolor ?? Colors.black,
          decoration: decoration),
    );
  }
}

class TextStyles {
  static textStyleW700(BuildContext context, String text, Color textColor,
      double fontSize, FontWeight fontWeight) {
    return TextSpan(
        text: text,
        style: TextStyle(
            color: textColor, fontSize: fontSize, fontWeight: fontWeight));
  }

  static textStyleW500(BuildContext context, Color textColor, double fontSize) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: textColor,
      fontSize: fontSize,
    );
  }

  static textStyleW300(BuildContext context, Color textColor, double fontSize) {
    return TextStyle(
      fontWeight: FontWeight.w300,
      color: textColor,
      fontSize: fontSize,
    );
  }

  textStyleW400(BuildContext context, Color textColor, double fontSize) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      color: textColor,
      fontSize: fontSize,
    );
  }
}
