import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductContoller.dart';

class CartController{

  /*-----------Get Cart Data-----------*/
  static Future<ResponseClass> getCartData(String customerId) async {
    String url = StringConstants.API_URL + StringConstants.cart_view;

    //body Data
    var data = {
      "customer_uniq_id": "$customerId"
    };

    ResponseClass<List<CartDataModel>> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getCartData ${response.data}");
        if(responseClass.success==false)
          return Future.error("No items in cart");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<CartDataModel> list =
        productList.map((e) => CartDataModel.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      print("getCartData ->>>" + e.toString());
      return responseClass;
    }
  }
}