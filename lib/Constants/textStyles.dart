import 'package:flutter/material.dart';

// TextStyle boldTitleText = TextStyle(
//     fontSize: 13,
//     color: appPrimaryMaterialColor,
//     fontWeight: FontWeight.w600,
//     fontFamily: 'Poppins');

class FontsTheme {
  static TextStyle boldTextStyle(
      {double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontWeight: fontWeight == null ? FontWeight.w700 : fontWeight,
        fontSize: size == null ? 13 : size,
        fontFamily: "Poppins",
        color: color ?? Colors.black87);
  }

  static TextStyle subTitleStyle(
      {double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight,
        fontSize: size == null ? 12 : size,
        fontFamily: "Poppins",
        color: color ?? Colors.black87);
  }

  static TextStyle digitStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
        fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight,
        fontFamily: "Montserrat",
        fontSize: fontSize == null ? 11 : fontSize,
        color: color == null ? Colors.black87 : color);
  }

  static TextStyle valueStyle(
      {double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontWeight: fontWeight == null ? FontWeight.w500 : fontWeight,
        fontFamily: "Poppins",
        fontSize: size == null ? 13 : size,
        color: color == null ? Colors.black87 : color);
  }

  static TextStyle descriptionText(
      {double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontSize: size == null ? 12 : size,
        color: color == null ? Colors.grey : color,
        fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight,
        fontFamily: "Poppins");
  }

  static TextStyle gilroyText({double? size, Color? color,}) {
    return TextStyle(
        fontSize: size == null ? 12 : size,
        color: color == null ? Colors.grey : color,
        fontWeight: FontWeight.w700,
        fontFamily: "Gilroy");
  }
}
