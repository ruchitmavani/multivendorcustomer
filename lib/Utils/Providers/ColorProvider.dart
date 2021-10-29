import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';

import '../SharedPrefs.dart';

class CustomColor extends ChangeNotifier{
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

  bool thatThingHappened = false;
}