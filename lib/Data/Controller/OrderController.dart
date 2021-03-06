import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/NewCartModel.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:nanoid/nanoid.dart';

import '../Models/AddressModel.dart';
import 'ProductController.dart';

class OrderController {
  /*-----------Get Order Data-----------*/
  static Future<ResponseClass<List<OrderDataModel>>> getOrder(
      String customerId) async {
    String url = StringConstants.api_url + StringConstants.my_order;

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
      required double paidAmount,
      required double refundAmount,
      required double orderAmount,
      required double totalAmount,
      required double deliveryCharge,
      required List<NewCartModel> orders,
      required double couponAmount,
      required double taxAmount,
      required List<SimpleTaxModel> taxPercentage,
      required String couponId,
      required Address address,
      required String refNo}) async {
    String url = StringConstants.api_url + StringConstants.add_order;

    //body Data
    List<AddOrder> productList = [];
    for (int i = 0; i < orders.length; i++) {
      productList.add(orders.elementAt(i).productSize == null &&
              orders.elementAt(i).productColor == null
          ? AddOrder(
              productId: orders.elementAt(i).productId,
              productQuantity: orders.elementAt(i).productQuantity,
            )
          : orders.elementAt(i).productSize == null
              ? AddOrder(
                  productId: orders.elementAt(i).productId,
                  productColor: orders.elementAt(i).productColor,
                  productQuantity: orders.elementAt(i).productQuantity)
              : orders.elementAt(i).productColor == null
                  ? AddOrder(
                      productId: orders.elementAt(i).productId,
                      productSize: orders.elementAt(i).productSize,
                      productQuantity: orders.elementAt(i).productQuantity)
                  : AddOrder(
                      productId: orders.elementAt(i).productId,
                      productSize: orders.elementAt(i).productSize,
                      productColor: orders.elementAt(i).productColor,
                      productQuantity: orders.elementAt(i).productQuantity));
    }

    var data = couponAmount == 0
        ? {
            "customer_uniq_id": "${sharedPrefs.customer_id}",
            "vendor_uniq_id": "${sharedPrefs.vendor_uniq_id}",
            "order_items": productList,
            "payment_type": "$type",
            "paid_amount": paidAmount,
            "refund_amount": refundAmount,
            "order_amount": orderAmount,
            "item_total_amount": totalAmount,
            "delivery_charges": deliveryCharge,
            "tax_amount": taxAmount,
            "tax_percentage": taxPercentage,
            "coupon_amount": couponAmount,
            "delivery_address": address.toJson(),
            "ref_no": refNo,
          }
        : {
            "customer_uniq_id": "${sharedPrefs.customer_id}",
            "vendor_uniq_id": "${sharedPrefs.vendor_uniq_id}",
            "order_items": productList,
            "payment_type": "$type",
            "paid_amount": paidAmount,
            "refund_amount": refundAmount,
            "order_amount": orderAmount,
            "item_total_amount": totalAmount,
            "delivery_charges": deliveryCharge,
            "tax_amount": taxAmount,
            "tax_percentage": taxPercentage,
            "coupon_amount": couponAmount,
            "coupon_id": "$couponId",
            "delivery_address": address.toJson(),
            "ref_no": refNo,
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

  /*-----------Accept Order -----------*/
  static Future<ResponseClass> acceptOrder(String orderId) async {
    String url = StringConstants.api_url + StringConstants.accept_order;

    //body Data
    var data = {"order_id": "$orderId"};

    ResponseClass responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("Accept order response -> ${response.data}");
      if (response.statusCode == 200) {
        log("Accept order ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = response.data["data"];
      }
      return responseClass;
    } catch (e) {
      log("Accept order error->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Reject Order -----------*/
  //todo deprecated
  static Future<ResponseClass> rejectOrder(
      {required String orderId, required String reason}) async {
    String url = StringConstants.api_url + StringConstants.reject_order;

    //body Data
    var data = {
      "order_id": "$orderId",
      "is_rejected_by_customer": true,
      "order_status": "Rejected",
      "reject_reason": "$reason",
      "refund_note": reason,
      "refundId": customAlphabet("0123456789abcdefghijklmnnopqrstuvwxyz", 10),
    };

    ResponseClass responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("reject order response -> ${response.data}");
      if (response.statusCode == 200) {
        log("reject order ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = response.data["data"];
      }
      return responseClass;
    } catch (e) {
      log("reject order error->>>" + e.toString());
      return responseClass;
    }
  }
}
