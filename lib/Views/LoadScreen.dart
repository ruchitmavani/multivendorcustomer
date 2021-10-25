import 'dart:html';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/main.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loadData();
    });
  }

  loadData() async {
    Uri url = Uri.parse(window.location.href);
    String id = url.path.substring(1).split('/').first;
    print("path $id");
    // id = 'veer0961';
    window.localStorage["storeId"] = id;

    if (id != "")
      await Provider.of<VendorModelWrapper>(context, listen: false)
          .loadVendorData(id)
          .then((value)async {
        // if (!mounted) return;

        print("load path ------- ${window.location.pathname}");
        String path = window.location.pathname!;
        if (!path.contains("home"))
          GoRouter.of(context).push('/' + storeConcate(PageCollection.home));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text("Store is Loading"),
          ],
        ),
      ),
    );
  }
}
