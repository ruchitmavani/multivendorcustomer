import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';

import 'ProductController.dart';

class VendorController {
  /*-----------Get Product Data-----------*/
  static Future<ResponseClass> getVendorData({required String vendorId}) async {
    String url = StringConstants.API_URL + StringConstants.vendor_view;

    //body Data
    var data = {"store_link": "$vendorId"};

    print(data);
    ResponseClass<VendorDataModel> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      print("vendor response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getVendorData ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = VendorDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("getVendorData ->>>" + e.toString());
      return responseClass;
    }
  }
}
