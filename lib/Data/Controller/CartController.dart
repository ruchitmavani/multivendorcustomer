import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductContoller.dart';

class CartController {
  /*-----------Get Cart Data-----------*/
  static Future<ResponseClass<List<CartDataModel>>> getCartData({required String vendorId,required String customerId}) async {
    String url = StringConstants.API_URL + StringConstants.cart_view;

    //body Data
    print("load cart calling");
    print("$customerId");
    var data = {
      "vendor_uniq_id" : "$vendorId",
      "customer_uniq_id": "$customerId"
    };

    ResponseClass<List<CartDataModel>> responseClass =
        ResponseClass(success: false, message: "Something went wrong",);
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("getCartData response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getCartData ${response.data}");
        // if (responseClass.success == false)
        //   return Future.error("No items in cart");
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

  /*-----------add to Cart-----------*/
  static Future<ResponseClass> addToCart(
    String customerId,
    String vendorId,
    String productId,
    int quantity,
    String size,
    int mrp,
    int sellingPrice,
    bool isActive,
      String colorCode,
      bool isColorActive,
  ) async {
    String url = StringConstants.API_URL + StringConstants.product_add_to_cart;

    //body Data
    var data = {
      "customer_uniq_id": "$customerId",
      "vendor_uniq_id": "$vendorId",
      "product_id": "$productId",
      "product_quantity": quantity,
      "product_size": {
        "size": "$size",
        "mrp": mrp,
        "selling_price": sellingPrice,
        "is_active": isActive
      },
      "product_color": {"color_code": "$colorCode", "is_active": isColorActive}
    };

    ResponseClass responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("addToCart ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<CartDataModel> list =
            productList.map((e) => CartDataModel.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      print("addToCart ->>>" + e.toString());
      return responseClass;
    }
  }
}
