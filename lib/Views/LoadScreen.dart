import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';
import 'package:provider/provider.dart';

import 'LandingScreen.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isLoading = true;
  bool isStoreExist = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    Uri url = Uri.parse(window.location.href);
    String id = url.path.substring(1).split('/').first;
    window.localStorage["storeId"] = id;
    if (id != "") {
      await Provider.of<VendorModelWrapper>(context, listen: false)
          .loadVendorData(id)
          .then((value) async {
        if (!mounted) return;
        log("vendor exist : $value");
        if (value == true) {
          String? path = window.location.pathname;
          log("load path ------- ${window.location.pathname}");
          // if (!path!.contains("/home")) {
          //   GoRouter.of(context).go('/' + storeConcat(PageCollection.home));
          // }
          setState(() {
            isStoreExist = true;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/wellsel.png",
                      width: 150, fit: BoxFit.fitWidth),
                  CircularProgressIndicator(),
                ],
              )
            : isStoreExist
                ? HomeScreen()
                : LandingScreen(),
      ),
    );
  }
}
