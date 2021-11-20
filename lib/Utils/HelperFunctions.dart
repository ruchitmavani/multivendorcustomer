import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:provider/provider.dart';

import 'Providers/CartProvider.dart';
import 'Providers/ColorProvider.dart';

bool isProductAvailable({required List<String> liveTimings}) {
  bool isAvailable = true;

  if (liveTimings.contains("All Time")) {
    return true;
  } else {
    for (int i = 0; i < liveTimings.length; i++) {
      List<String> timeList = liveTimings[i].split("-");
      DateTime fromTime = DateFormat("hh:mm aaa").parse(timeList[0].trim());
      DateTime toTime = DateFormat("hh:mm aaa").parse(timeList[1].trim());

      String currentTimeString = DateFormat("hh:mm aaa").format(DateTime.now());
      DateTime currentTime = DateFormat("hh:mm aaa").parse(currentTimeString);

      if (currentTime.isAfter(fromTime) && currentTime.isBefore(toTime)) {
        return true;
      } else
        isAvailable = false;
    }
  }

  return isAvailable;
}

Widget cartIconWidget(BuildContext context) {
  return Badge(
    elevation: 0,
    position: BadgePosition.topEnd(top: 5, end: -5),
    showBadge:
        Provider.of<CartDataWrapper>(context).totalItems != 0 ? true : false,
    badgeContent: Text('${Provider.of<CartDataWrapper>(context).totalItems}',
        style: TextStyle(fontSize: 10, color: Colors.white)),
    child: InkWell(
      onTap: () {
        GoRouter.of(context).push(PageCollection.cart);
      },
      child: Image.asset("images/cart_icon.png",
          width: 25,
          height: 25,
          color: Provider.of<CustomColor>(context).appPrimaryMaterialColor),
    ),
  );
}
