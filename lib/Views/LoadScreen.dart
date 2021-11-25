import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/main.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    Uri url = Uri.parse(window.location.href);
    String id = url.path.substring(1).split('/').first;
    print("path $id");
    if (id == "login") return;
    window.localStorage["storeId"] = id;
    if (id != "") {
      await Provider.of<VendorModelWrapper>(context, listen: false)
          .loadVendorData(id)
          .then((value) async {
        if (!mounted) return;
        log("vendor exist : ${value} -------");
        if (value == true) {
          String? path = window.location.pathname;
          print("load path ------- ${window.location.pathname}");
          GoRouter.of(context).go('/' + storeConcat(PageCollection.home));
          // else
          //   GoRouter.of(context).go('/' + "${path}");
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
                  CircularProgressIndicator(),
                ],
              )
            : Text("Store not found"),
      ),
    );
  }
}
