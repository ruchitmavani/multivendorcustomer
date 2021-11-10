import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/AllCategoryModel.dart';
import 'package:multi_vendor_customer/Data/Models/CategoryNameModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

import 'ProductController.dart';

class CategoryController {
  /*-----------Get Product Data-----------*/
  static Future<ResponseClass> getCategoryWiseProduct(String vendorId,String sortKey) async {
    String url = StringConstants.api_url +
        StringConstants.customer_category_wise_all_product_find;

    //body Data
    var data = (sharedPrefs.customer_id.isEmpty)
        ? {"vendor_uniq_id": "$vendorId",  "sort" : "$sortKey"}
        : {
            "vendor_uniq_id": "$vendorId",
            "customer_uniq_id": "${sharedPrefs.customer_id}",
      "sort" : "$sortKey"
          };

    print("all product $data");
    ResponseClass<List<AllCategoryModel>> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      print("getCategoryWiseProduct response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getCategoryWiseProduct ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<AllCategoryModel> list =
            productList.map((e) => AllCategoryModel.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      print("getCategoryWiseProduct ->>>" + e.toString());
      return responseClass;
    }
  }


  /*-----------Get Category Name Data-----------*/
  static Future<ResponseClass> getCategoryName() async {
    String url = StringConstants.api_url +
        StringConstants.vendor_all_category_name;

    //body Data
    var data ={"vendor_uniq_id": "${sharedPrefs.vendor_uniq_id}"};
    print(data);

    print("all product $data");
    ResponseClass<List<CategoryNameModel>> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      print("getCategoryName response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getCategoryNAme ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        List productList = response.data["data"];
        List<CategoryNameModel> list =
        productList.map((e) => CategoryNameModel.fromJson(e)).toList();
        responseClass.data = list;
      }
      return responseClass;
    } catch (e) {
      print("getCategoryName ->>>" + e.toString());
      return responseClass;
    }
  }
}
