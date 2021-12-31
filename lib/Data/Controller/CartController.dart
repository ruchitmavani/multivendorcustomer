import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/AddToCartResponseModel.dart';
import 'package:multi_vendor_customer/Data/Models/NewCartModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductController.dart';

class CartController {
  /*-----------Get Cart Data-----------*/
  // static Future<ResponseClass<List<NewCartModel>>> getCartData(
  //     {required String vendorId, required String customerId}) async {
  //   String url = StringConstants.api_url + StringConstants.cart_view;
  //
  //   //body Data
  //   print("$customerId");
  //   var data = {
  //     "vendor_uniq_id": "$vendorId",
  //     "customer_uniq_id": "$customerId"
  //   };
  //
  //   ResponseClass<List<NewCartModel>> responseClass = ResponseClass(
  //     success: false,
  //     message: "Something went wrong",
  //   );
  //   try {
  //     Response response = await dio.post(
  //       url,
  //       data: data,
  //     );
  //
  //     log("getCartData response -> ${response.data}");
  //     if (response.statusCode == 200) {
  //       responseClass.success = response.data["is_success"];
  //       responseClass.message = response.data["message"];
  //       List productList = response.data["data"];
  //       List<NewCartModel> list =
  //           productList.map((e) => NewCartModel.fromJson(e)).toList();
  //       responseClass.data = list;
  //     }
  //     return responseClass;
  //   } catch (e) {
  //     print("getCartData ->>>" + e.toString());
  //     return responseClass;
  //   }
  // }

  /*-----------add to Cart-----------*/
  static Future<ResponseClass<AddtoCartResponseModel>> addToCart({
    required String customerId,
    required String vendorId,
    required String productId,
    required int quantity,
    required String size,
    required int mrp,
    required int sellingPrice,
    required bool isActive,
    required String colorCode,
    required bool isColorActive,
    required bool isVarientAvailable,
  }) async {
    String url = StringConstants.api_url + StringConstants.product_add_to_cart;

    //body Data
    var data = isVarientAvailable
        ? {
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
            "product_color": {
              "color_code": "$colorCode",
              "is_active": isColorActive
            }
          }
        : {
            "customer_uniq_id": "$customerId",
            "vendor_uniq_id": "$vendorId",
            "product_id": "$productId",
            "product_quantity": quantity,
          };

    ResponseClass<AddtoCartResponseModel> responseClass =
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
        responseClass.data =
            AddtoCartResponseModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("addToCart ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------update Cart-----------*/
  static Future<ResponseClass> update({
    required Map<String, dynamic> jsonMap,
  }) async {
    String url = StringConstants.api_url + StringConstants.cart_details_update;

    print(jsonMap);
    //body Data
    var data = jsonMap;

    ResponseClass responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("updateCart response -> ${response.data}");
      if (response.statusCode == 200) {
        log("updateCart  ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = response.data["data"];
      }
      return responseClass;
    } catch (e) {
      print("update Cart ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------delete Cart-----------*/
  static Future<ResponseClass> deleteCart({
    required String cartId,
  }) async {
    String url = StringConstants.api_url + StringConstants.delete_cart;

    //body Data
    var data = {
      "cart_id": "$cartId",
    };

    ResponseClass responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        log("deleteCart ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = response.data["data"];
      }
      return responseClass;
    } catch (e) {
      print("deleteCart ->>>" + e.toString());
      return responseClass;
    }
  }
}
