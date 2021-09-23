import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

import 'ProductController.dart';

class OrderController {
  /*-----------Get Order Data-----------*/
  static Future<ResponseClass<List<OrderDataModel>>> getOrder(
      String customerId) async {
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

  /*-----------add Order-----------*/
  static Future<ResponseClass<List<OrderDataModel>>> addOrder(
      {required String type,
      required int paidAmount,
      required int refundAmount,
      required int finalPaid,
      required int totalAmount,
      required int deliveryCharge,
      required int couponAmount,
      required int taxAmount,
      required String couponId,
      required CustomerAddress address}) async {
    String url = StringConstants.API_URL + StringConstants.add_order;

    //body Data
    var data = couponAmount == 0
        ? {
            "customer_uniq_id": "${sharedPrefs.customer_id}",
            "vendor_uniq_id": "${sharedPrefs.vendor_uniq_id}",
            "payment_type": "$type",
            "paid_amount": paidAmount,
            "refund_amount": refundAmount,
            "final_paid_amount": finalPaid,
            "item_total_amount": totalAmount,
            "delivery_charges": deliveryCharge,
            "tax_amount": taxAmount,
            "coupon_amount": couponAmount,
            "delivery_address": address.toJson(),
          }
        : {
            "customer_uniq_id": "${sharedPrefs.customer_id}",
            "vendor_uniq_id": "${sharedPrefs.vendor_uniq_id}",
            "payment_type": "$type",
            "paid_amount": paidAmount,
            "refund_amount": refundAmount,
            "final_paid_amount": finalPaid,
            "item_total_amount": totalAmount,
            "delivery_charges": deliveryCharge,
            "tax_amount": taxAmount,
            "coupon_amount": couponAmount,
            "coupon_id": "$couponId",
            "delivery_address": address.toJson(),
          };

    ResponseClass<List<OrderDataModel>> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("addOrder ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<OrderDataModel> list =
            productList.map((e) => OrderDataModel.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      log("addOrder error->>>" + e.toString());
      return responseClass;
    }
  }
}
