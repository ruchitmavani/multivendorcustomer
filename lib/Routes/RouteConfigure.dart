import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Routes/ExtensionMethods.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/AboutUs.dart';
import 'package:multi_vendor_customer/Views/CartScreen.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';
import 'package:multi_vendor_customer/Views/LoadScreen.dart';
import 'package:multi_vendor_customer/Views/Location.dart';
import 'package:multi_vendor_customer/Views/LoginScreen.dart';
import 'package:multi_vendor_customer/Views/MyAccount.dart';
import 'package:multi_vendor_customer/Views/MyOrder.dart';
import 'package:multi_vendor_customer/Views/SavedAddress.dart';
import 'package:multi_vendor_customer/Views/SearchScreen.dart';
import 'package:provider/provider.dart';

class RouteConfig {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    var routingData = settings.name!.getRoutingData;
    print("== ${routingData.route}");
    List<String> length=routingData.route.split("/");
    print(length);
      // if(length.last=="home"){
      //   return MaterialPageRoute<void>(
      //             builder: (context) => HomeScreen(),
      //             settings: settings,
      //           );
      // }


    switch (length.last) {
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
        var id = routingData['categoryId'];
        var name = routingData['categoryName'];
        return MaterialPageRoute<void>(
          builder: (context) => CategorySubScreen(
            categoryId: id,
            categoryName: name,
          ),
          settings: settings,
        );
      case PageCollection.myOrders:
        return MaterialPageRoute<void>(
          builder: (context) => MyOrder(),
          settings: settings,
        );
      case PageCollection.savedAddress:
        return MaterialPageRoute<void>(
          builder: (context) => SavedAddress(),
          settings: settings,
        );
      case PageCollection.location:
        return MaterialPageRoute<void>(
          builder: (context) => Location(),
          settings: settings,
        );
      case PageCollection.search:
        return MaterialPageRoute<void>(
          builder: (context) => Search(),
          settings: settings,
        );
    }
  }
}
