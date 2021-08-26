import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Views/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black87),
                textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.w600,color: Colors.black87,fontFamily: "Poppins")),
                actionsIconTheme:
                    IconThemeData(color: appPrimaryMaterialColor)),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  primary: Colors.grey.shade600,
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Poppins",
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  side: BorderSide(width: 1.2, color: Colors.grey.shade700)
                //backgroundColor: Colors.green,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: appPrimaryMaterialColor,
                elevation: 0,
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    fontSize: 15),
              ),
            ),
            fontFamily: 'Poppins',
            primaryColor: appPrimaryMaterialColor,
            primarySwatch: Colors.grey,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(),
            )),
        debugShowCheckedModeBanner: false,
        home: LoginScreen());
  }
}
