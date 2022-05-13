import 'dart:developer';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/PaymentDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Data/Models/TokenModel.dart';
import 'package:multi_vendor_customer/Data/Models/VandorPaymentDetailsModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:nanoid/nanoid.dart';

import 'ProductController.dart';

class PaymentController {
  /*-----------Generate Order id Data-----------*/
  static Future<TokenModel?> generateOrderId(
    double amount,
  ) async {
    String url =
        StringConstants.api_url + StringConstants.create_payment_orderId;

    String orderID = customAlphabet('1234567890abcdefghijklmnopqrstuvwxyz', 10);

    // print(orderID);
    // print(amount);

    //body Data
    var data = {
      "orderId": orderID,
      "orderAmount": amount,
    };

    TokenModel? responseClass ;
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("generate order id response -> ${response.data}");
      if (response.statusCode == 200) {
        log("generate order id ${response.data}");
        // response.data.add
        responseClass = TokenModel.fromJson(response.data,orderID);
      }
      return responseClass;
    } catch (e) {
      log("generate order id error->>>" + e.toString());
      return null;
    }
  }  /*-----------Get Vendor id-----------*/
  static Future<ResponseClass<PaymentDetailsModel>> getBankDetails() async {
    String url = StringConstants.api_url + StringConstants.view_payment_details;

    ResponseClass<PaymentDetailsModel> responseClass =
    ResponseClass(success: false, message: "Something went wrong");

    var data = {
      "vendor_uniq_id": sharedPrefs.vendor_uniq_id,
    };

    try {
      Response response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        log("payment details get ${response.data}");
        responseClass.success = true;
        responseClass.message = response.data["message"];
        responseClass.data =
            PaymentDetailsModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("payment details get order->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Payment Verify Data-----------*/
  //todo deprecated
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