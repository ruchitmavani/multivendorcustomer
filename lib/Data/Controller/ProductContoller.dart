import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

Dio dio = new Dio();

class ProductController {
  /*-----------Get Product Data-----------*/
  static Future<ResponseClass> getProductData(
      {required String vendorId,
      required String categoryId,
      required int limit,
      required int page}) async {
    String url = StringConstants.API_URL + StringConstants.vendor_all_product;

    //body Data
    var data = {
      "vendor_uniq_id": "$vendorId",
      "category_id": "$categoryId",
      "limit": limit,
      "page": page
    };

    ResponseClass<List<ProductData>> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getProductData ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<ProductData> list =
            productList.map((e) => ProductData.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      print("getProductData ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Get Trending Product Data-----------*/
  static Future<ResponseClass> getTrendingProduct(
      {required String vendorId}) async {
    String url = StringConstants.API_URL + StringConstants.top_selling_product;

    //body Data
    var data = {"vendor_uniq_id": "$vendorId"};

    ResponseClass<List<ProductData>> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getTrendingProductData ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<ProductData> list =
            productList.map((e) => ProductData.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      print("getTrendingProductData ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Search Product Data-----------*/
  static Future<ResponseClass> searchProduct(
      {required String vendorId,required String searchString}) async {
    String url = StringConstants.API_URL + StringConstants.search_product;

    //body Data
    var data = {
      "vendor_uniq_id" : "$vendorId",
      "text" : "$searchString"
    };

    ResponseClass<List<ProductData>> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("searchProduct ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<ProductData> list =
            productList.map((e) => ProductData.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      print("searchProduct ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Find Product Data-----------*/
  static Future<ResponseClass<ProductData>> findProduct(
      {required String productId,required String customerId}) async {
    String url = StringConstants.API_URL + StringConstants.find_a_product;

    //body Data
    var data = {
      "product_id" : "$productId",
      "customer_uniq_id": "$customerId"
    };

    ResponseClass<ProductData> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("find product response -> ${response.data}");
      if (response.statusCode == 200) {
        log("findProduct ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = ProductData.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("findProduct ->>>" + e.toString());
      return responseClass;
    }
  }
}
