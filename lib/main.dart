// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Routes/RouteConfigure.dart';
import 'package:multi_vendor_customer/Utils/Hive/DemoHive.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Utils/SharedPrefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await sharedPrefs.init();
  await Hive.initFlutter();
  Hive.registerAdapter(DemoHiveAdapter());
  await Hive.openBox<DemoHive>("demo");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VendorModelWrapper()),
      ChangeNotifierProvider(create: (_) => CartDataWrapper()),
    ],
    child: MyApp(),
  ));
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
              textTheme: TextTheme(
                  headline6: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontFamily: "Poppins")),
              actionsIconTheme: IconThemeData(color: appPrimaryMaterialColor)),
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
      initialRoute: PageCollection.home,
      onGenerateRoute: RouteConfig.onGenerateRoute,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => HomeScreen());
      },
    );
  }
}
