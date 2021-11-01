import 'dart:developer';
import 'dart:html';
import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/NewCartModel.dart';
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
      required double paidAmount,
      required double refundAmount,
      required double orderAmount,
      required double totalAmount,
      required double deliveryCharge,
      required List<NewCartModel> orders,
      required double couponAmount,
      required double taxAmount,
        required double taxPercentage,
      required String couponId,
      required CustomerAddress address}) async {
    String url = StringConstants.API_URL + StringConstants.add_order;

    print(window.localStorage);
    //body Data
    List<AddOrder> productList = [];
    for (int i = 0; i < orders.length; i++) {
      print(i);
      productList.add(orders.elementAt(i).productSize!.size == "" &&
              orders.elementAt(i).productColor!.colorCode == 0
          ? AddOrder(
              productId: orders.elementAt(i).productId,
              productQuantity: orders.elementAt(i).productQuantity)
          : orders.elementAt(i).productSize!.size == ""
              ? AddOrder(
                  productId: orders.elementAt(i).productId,
                  productColor: orders.elementAt(i).productColor,
                  productQuantity: orders.elementAt(i).productQuantity)
              : orders.elementAt(i).productColor!.colorCode == 0
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
      "tax_percentage" : taxPercentage,
            "coupon_amount": couponAmount,
            "delivery_address": address.toJson(),
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
          };

    print("addOrder $data");

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
    String url = StringConstants.API_URL + StringConstants.accept_order;

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
  static Future<ResponseClass> rejectOrder({required String orderId,required String reason}) async {
    String url = StringConstants.API_URL + StringConstants.reject_order;

    //body Data
    var data = {
      "order_id": "$orderId",
      "is_rejected_by_customer": true,
      "order_status": "Rejected",
      "reject_reason": "$reason",
      "razorpay_payment_id": "pay_IAeuocTTDp9zFC"
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
