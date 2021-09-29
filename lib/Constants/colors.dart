import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

Map<int, Color> appPrimaryColor = {
  50: Color.fromRGBO(extRed(), extGreen(), extBlue(), .1),
  100: Color.fromRGBO(extRed(), extGreen(), extBlue(), .2),
  200: Color.fromRGBO(extRed(), extGreen(), extBlue(), .3),
  300: Color.fromRGBO(extRed(), extGreen(), extBlue(), .4),
  400: Color.fromRGBO(extRed(), extGreen(), extBlue(), .5),
  500: Color.fromRGBO(extRed(), extGreen(), extBlue(), .6),
  600: Color.fromRGBO(extRed(), extGreen(), extBlue(), .7),
  700: Color.fromRGBO(extRed(), extGreen(), extBlue(), .8),
  800: Color.fromRGBO(extRed(), extGreen(), extBlue(), .9),
  900: Color.fromRGBO(extRed(), extGreen(), extBlue(), 1)
};

MaterialColor appPrimaryMaterialColor = MaterialColor(
    int.parse(
        sharedPrefs.colorTheme == "" ? "4294922320" : sharedPrefs.colorTheme),
    appPrimaryColor);

int extRed() {
  return Color(int.parse(
          sharedPrefs.colorTheme == "" ? "4294922320" : sharedPrefs.colorTheme))
      .red;
}

int extGreen() {
  return Color(int.parse(
          sharedPrefs.colorTheme == "" ? "4294922320" : sharedPrefs.colorTheme))
      .green;
}

int extBlue() {
  return Color(int.parse(
          sharedPrefs.colorTheme == "" ? "4294922320" : sharedPrefs.colorTheme))
      .blue;
}
