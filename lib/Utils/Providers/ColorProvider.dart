import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';

import '../SharedPrefs.dart';

class ThemeColorProvider extends ChangeNotifier{
  MaterialColor appPrimaryMaterialColor = MaterialColor(
      int.parse(
          sharedPrefs.colorTheme == "" ? "4294922320" : sharedPrefs.colorTheme),
      appPrimaryColor);
  updateColor(){
    appPrimaryMaterialColor = MaterialColor(
        int.parse(
            sharedPrefs.colorTheme == "" ? "4294922320" : sharedPrefs.colorTheme),
        appPrimaryColor);
    notifyListeners();
  }
}