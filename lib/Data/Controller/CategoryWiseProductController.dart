import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/AllCategoryModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductContoller.dart';

class CategoryController {

  /*-----------Get Product Data-----------*/
  static Future<ResponseClass> getCategoryWiseProduct(String vendorId) async {
    String url = StringConstants.API_URL + StringConstants.category_wise__all_product_find;

    //body Data
    var data = {"vendor_uniq_id": "$vendorId"};

    ResponseClass<List<AllCategoryModel>> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getCategoryWiseProduct ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<AllCategoryModel> list =
        productList.map((e) => AllCategoryModel.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      print("getCategoryWiseProduct ->>>" + e.toString());
      return responseClass;
    }
  }
}