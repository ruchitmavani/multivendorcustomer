import 'package:flutter/material.dart';

const TextStyle titleStyle = TextStyle(
    fontSize: 11,
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins');
const TextStyle boldTitleText = TextStyle(
    fontSize: 13,
    color: Color(0xFF24293D),
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins');

class FontsTheme {
  static TextStyle boldTextStyle(
      {double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight,
        fontSize: size,
        fontFamily: "Poppins",
        color: color ?? Colors.black87);
  }

  static TextStyle subTitleStyle(
      {double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontWeight: fontWeight == null ? FontWeight.w600 : fontWeight,
        fontSize: size,
        fontFamily: "Poppins",
        color: color ?? Colors.black87);
  }

  static TextStyle descriptionText(
      {double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontSize: size,
        color: color == null ? Colors.grey : color,
        fontWeight: fontWeight,
        fontFamily: "Poppins");
  }
}
