import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductContoller.dart';

class OrderController {

  /*-----------Get Order Data-----------*/
  static Future<ResponseClass<List<OrderDataModel>>> getOrder(String customerId) async {
    String url = StringConstants.API_URL + StringConstants.my_order;

    //body Data
    var data = {"customer_uniq_id": "$customerId"};

    ResponseClass<List<OrderDataModel>> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getOrder ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<OrderDataModel> list =
        productList.map((e) => OrderDataModel.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      log("getOrder error->>>" + e.toString());
      return responseClass;
    }
  }
}