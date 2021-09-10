import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Data/Controller/VendorController.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';

class VendorModelWrapper with ChangeNotifier {
  VendorDataModel? vendorModel;
  bool isLoaded = false;

  Future loadVendorData() async {
    print("Calling");
    await VendorController.getVendorData(vendorId: "657202115727_9429828152")
        .then((value) {
      if (value.success) {
        print(value.success);
        vendorModel = value.data;
        isLoaded = true;
        print("loaded");
      }
    }, onError: (e) {
      print(e);
    });
  }
}
