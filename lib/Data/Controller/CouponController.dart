import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CouponDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'ProductContoller.dart';

class CouponController{

  /*-----------Get Cart Data-----------*/
  static Future<ResponseClass> validateCoupon({required String vendorId,required String couponName,required String customerId}) async {
    String url = StringConstants.API_URL + StringConstants.vendor_coupon_validate;

    //body Data
    var data ={
      "vendor_uniq_id" : "$vendorId",
      "coupon_name" : "$couponName",
      "customer_uniq_id":"$customerId"
    };

    ResponseClass<CouponDataModel> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getCartData ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = CouponDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("getCartData ->>>" + e.toString());
      return responseClass;
    }
  }
}