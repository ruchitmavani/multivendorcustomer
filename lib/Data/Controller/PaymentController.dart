import 'dart:developer';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/PaymentDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

import 'ProductController.dart';

class PaymentController {
  /*-----------Generate Order id Data-----------*/
  static Future<ResponseClass<OrderId>> generateOrderId(int amount) async {
    String url =
        StringConstants.api_url + StringConstants.create_payment_orderId;

    //body Data
    var data = {
      "vendor_uniq_id": sharedPrefs.vendor_uniq_id,
      "amount": amount,
    };

    ResponseClass<OrderId> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("generate order id response -> ${response.data}");
      if (response.statusCode == 200) {
        log("generate order id ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = OrderId.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      log("generate order id error->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Payment Verify Data-----------*/
  static Future<ResponseClass> paymentVerify() async {
    String url = StringConstants.api_url + StringConstants.payment_verify;

    //body Data
    var data = {
      "razorpay_payment_id": "${window.localStorage["payment_id"]}",
      "order_id": "${window.localStorage["orderId"]}",
      "razorpay_signature": "${window.localStorage["signature"]}",
      "vendor_uniq_id": sharedPrefs.vendor_uniq_id
    };

    ResponseClass responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("payment verify response -> ${response.data}");
      if (response.statusCode == 200) {
        log("payment verify id ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = response.data["data"];
      }
      return responseClass;
    } catch (e) {
      log("payment verify error->>>" + e.toString());
      return responseClass;
    }
  }
}
