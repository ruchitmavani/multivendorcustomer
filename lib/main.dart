import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white,elevation: 0,actionsIconTheme: IconThemeData(color:appPrimaryMaterialColor)),
        fontFamily: 'Poppins'
      ),
      debugShowCheckedModeBanner: false,
      home:HomeScreen()
    );
  }
}
