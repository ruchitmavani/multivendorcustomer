import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';

import 'ProductController.dart';

class VendorController {
  /*-----------Get Product Data-----------*/
  static Future<ResponseClass> getVendorData({required String vendorId}) async {
    String url = StringConstants.api_url + StringConstants.vendor_view;
    String ip = "";
    ip = await IpInfoApi.getIPAddress();
    //body Data
    var data = {"store_link": "$vendorId", "customer_ip": "$ip"};

    ResponseClass<VendorDataModel> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        log("getVendorData ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = response.data["data"] != {}
            ? VendorDataModel.fromJson(response.data["data"])
            : null;
      }
      return responseClass;
    } catch (e) {
      log("getVendorData ->>>" + e.toString());
      return responseClass;
    }
  }
}
