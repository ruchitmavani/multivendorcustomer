import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Controller/VendorController.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

class VendorModelWrapper with ChangeNotifier {
  VendorDataModel? vendorModel;
  bool isLoaded = false;

  Future loadVendorData(String vendorId) async {
    await VendorController.getVendorData(vendorId: vendorId)
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
        sharedPrefs.colorTheme=vendorModel!.colorTheme;
        sharedPrefs.tax=vendorModel!.taxDetails.map((e) => e.taxPercentage.toString()).toList();
      }
    }, onError: (e) {
      print(e);
    });

   IpInfoApi.getIPAddress();

  }
}


class IpInfoApi {
  static Future<String?> getIPAddress() async {
    try {
      final response = await dio.get('https://api.ipify.org');
      print(response.data);
      return response.statusCode == 200 ? response.data : null;
    } catch (e) {
      return null;
    }
  }
}