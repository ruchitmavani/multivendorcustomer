import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/RatingDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

import 'ProductController.dart';

class RatingController {
  /*-----------Rate Product-----------*/
  static Future<ResponseClass<RatingDataModel>> rateProduct(
      {required String productId,
      required int rating,
      required String orderId,
      required String customerName}) async {
    String url = StringConstants.API_URL + StringConstants.customer_add_rating;

    //body Data
    var data = {
      "customer_uniq_id": "${sharedPrefs.customer_id}",
      "product_id": "$productId",
      "product_rating_count": rating,
      "order_id": "$orderId",
      "customer_name": "${sharedPrefs.customer_name}",
      "customer_mobile_number": "${sharedPrefs.customer_mobileNo}"
    };

    ResponseClass<RatingDataModel> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("rating response -> ${response.data}");
      if (response.statusCode == 200) {
        log("rating ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = RatingDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("rating ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------View Rating-----------*/
  static Future<ResponseClass<RatingDataModel>> viewRating(
      {required String productId}) async {
    String url = StringConstants.API_URL + StringConstants.view_rating;

    //body Data
    var data = {
      "customer_uniq_id": "${sharedPrefs.customer_id}",
      "product_id": "$productId",
    };

    ResponseClass<RatingDataModel> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("rating response -> ${response.data}");
      if (response.statusCode == 200) {
        log("rating ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = RatingDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("rating ->>>" + e.toString());
      return responseClass;
    }
  }
}
