import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Routes/ExtensionMethods.dart';
import 'package:multi_vendor_customer/Views/AboutUs.dart';
import 'package:multi_vendor_customer/Views/CartScreen.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';
import 'package:multi_vendor_customer/Views/LoginScreen.dart';
import 'package:multi_vendor_customer/Views/MyAccount.dart';
import 'package:multi_vendor_customer/Views/MyOrder.dart';

class RouteConfig {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    var routingData = settings.name!.getRoutingData;
    switch (routingData.route) {
      case PageCollection.home:
        return MaterialPageRoute<void>(
          builder: (context) => HomeScreen(),
          settings: settings,
        );
      case PageCollection.cart:
        return MaterialPageRoute<void>(
          builder: (context) => CartScreen(),
          settings: settings,
        );
      case PageCollection.login:
        return MaterialPageRoute<void>(
          builder: (context) => LoginScreen(),
          settings: settings,
        );
      case PageCollection.about_us:
        return MaterialPageRoute<void>(
          builder: (context) => AboutUs(),
          settings: settings,
        );
      case PageCollection.myAccount:
        return MaterialPageRoute<void>(
          builder: (context) => MyAccount(),
          settings: settings,
        );
      case PageCollection.categories:
        return MaterialPageRoute<void>(
          builder: (context) => CategorySubScreen(),
          settings: settings,
        );
      case PageCollection.myOrders:
        return MaterialPageRoute<void>(
          builder: (context) => MyOrder(),
          settings: settings,
        );
    }
  }
}
