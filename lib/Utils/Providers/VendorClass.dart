import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Data/Controller/VendorController.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

class VendorModelWrapper with ChangeNotifier {
  VendorDataModel? vendorModel;
  bool isLoaded = false;

  Future loadVendorData() async {
    await VendorController.getVendorData(vendorId: "4502021105036_7698178411")
        .then((value) {
      if (value.success) {
        print(value.success);
        vendorModel = value.data;
        isLoaded = true;
        print("loaded");
        sharedPrefs.vendor_uniq_id=vendorModel!.vendorUniqId;
        sharedPrefs.vendor_email_address=vendorModel!.emailAddress;
        sharedPrefs.businessName=vendorModel!.businessName;
        sharedPrefs.isWhatsappSupport=vendorModel!.isWhatsappChatSupport;
        sharedPrefs.vendorMobileNumber=vendorModel!.mobileNumber;
        sharedPrefs.logo=vendorModel!.logo;
        sharedPrefs.gstNumber=vendorModel!.gstNumber;
        sharedPrefs.longitude=vendorModel!.longitude;
        sharedPrefs.latitude=vendorModel!.latitude;
        sharedPrefs.businessCategory=vendorModel!.businessCategory;
        sharedPrefs.storeLink=vendorModel!.storeLink;
      }
    }, onError: (e) {
      print(e);
    });
  }
}
