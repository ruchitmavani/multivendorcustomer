import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CouponDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'ProductController.dart';

class CouponController{

  /*-----------Validate Coupon Data-----------*/
  static Future<ResponseClass<CouponDataModel>> validateCoupon({required String vendorId,required String couponName,required String customerId}) async {
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
        log("couponData ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = CouponDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("couponData ->>>" + e.toString());
      return responseClass;
    }
  }
}