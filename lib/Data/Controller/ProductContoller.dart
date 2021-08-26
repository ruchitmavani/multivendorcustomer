import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';
import 'package:multi_vendor_customer/Utils/StringConstants.dart';

Dio dio = new Dio();

class ProductController {
  /*-----------Get Product Data-----------*/

  static Future<ResponseClass> getProductData(String vendorId) async {
    String url = StringConstants.API_URL + StringConstants.vendor_all_product;

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

}
