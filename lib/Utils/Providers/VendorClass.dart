import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Controller/VendorController.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

class VendorModelWrapper with ChangeNotifier {
  VendorDataModel? vendorModel;
  bool isLoaded = false;
  String isShopOpen="";

  Future<bool?> loadVendorData(String vendorId) async {
    bool res = false;
    await VendorController.getVendorData(vendorId: vendorId).then((value) {
      if (value.success && value.data != null) {
        vendorModel = value.data;
        isLoaded = true;
        sharedPrefs.vendor_uniq_id = vendorModel!.vendorUniqId;
        sharedPrefs.vendor_email_address = vendorModel!.emailAddress;
        sharedPrefs.businessName = vendorModel!.businessName;
        sharedPrefs.isWhatsappSupport = vendorModel!.isWhatsappChatSupport;
        sharedPrefs.vendorMobileNumber = vendorModel!.mobileNumber;
        sharedPrefs.logo = vendorModel!.logo;
        sharedPrefs.gstNumber = vendorModel!.gstNumber;
        sharedPrefs.longitude = vendorModel!.longitude;
        sharedPrefs.latitude = vendorModel!.latitude;
        sharedPrefs.businessCategory = vendorModel!.businessCategory;
        sharedPrefs.storeLink = vendorModel!.storeLink;
        sharedPrefs.colorTheme = vendorModel!.colorTheme;
        sharedPrefs.tax = vendorModel!.taxDetails
            .map((e) => e.taxPercentage.toString())
            .toList();
        isShopOpen= getShopTimingStatus();
        res = true;
      } else {
        res = false;
      }
    }, onError: (e) {
      print(e);
      res = false;
    });

    return res;
  }

  String todayIndex = DateFormat('EEEE').format(DateTime.now());

  int weekIndex(List<BusinessHour> list) {
    return list.indexWhere(
        (element) => element.day.toLowerCase() == todayIndex.toLowerCase());
  }

  String getShopTimingStatus() {
    List<BusinessHour> list = vendorModel!.businessHours;
    if (vendorModel!.isOnline) {
      // if (list[weekIndex(list)].isOpen == false) {
      //   return "Closed";
      // } else {
      //   TimeOfDay startTime = TimeOfDay.fromDateTime(
      //       DateFormat.jm().parse(list[weekIndex(list)].openTime));
      //   TimeOfDay endTime = TimeOfDay.fromDateTime(
      //       DateFormat.jm().parse(list[weekIndex(list)].closeTime));
      //   TimeOfDay currentTime = TimeOfDay.now();
      //   if (currentTime.hour > startTime.hour &&
      //       currentTime.hour < endTime.hour) {
      //     return "${list[weekIndex(list)].openTime} - ${list[weekIndex(list)].closeTime}";
      //   } else if ((currentTime.hour == startTime.hour &&
      //           currentTime.minute > startTime.minute) ||
      //       (currentTime.hour == endTime.hour &&
      //           currentTime.minute < endTime.minute)) {
      //     return "${list[weekIndex(list)].openTime} - ${list[weekIndex(list)].closeTime}";
      //   } else {
      //     return "Closed";
      //   }
      // }
      return "${list[weekIndex(list)].openTime} - ${list[weekIndex(list)].closeTime}";

    } else {
      return "Offline";
    }
  }
}

class IpInfoApi {
  static Future<String> getIPAddress() async {
    try {
      final response = await dio.get('https://api.ipify.org');
      print(response.data);
      return response.statusCode == 200 ? response.data : "";
    } catch (e) {
      return "";
    }
  }
}
