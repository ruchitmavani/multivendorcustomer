import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/BannerDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductController.dart';

class BannerController {
  /*-----------Get Banner Data-----------*/
  static Future<ResponseClass<List<BannerDataModel>>> getBannerData(
      String vendorId) async {
    String url = StringConstants.api_url + StringConstants.vendor_all_banner;

    //body Data
    var data = {"vendor_uniq_id": "$vendorId"};

    ResponseClass<List<BannerDataModel>> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List asList = response.data["data"];
        List<BannerDataModel> list =
        asList.map((e) => BannerDataModel.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      log("getBannerData ->>>" + e.toString());
      return responseClass;
    }
  }
}
