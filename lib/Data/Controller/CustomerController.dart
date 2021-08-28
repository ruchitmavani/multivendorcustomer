import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductContoller.dart';


class CustomerController{

  /*-----------Get Customer Data-----------*/
  static Future<ResponseClass> getCustomerData(String customerId) async {
    String url = StringConstants.API_URL + StringConstants.customer_view;

    //body Data
    var data = {
      "customer_uniq_id": "$customerId"
    };

    ResponseClass<CustomerDataModel> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("getCustomerData ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = CustomerDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("getCustomerData ->>>" + e.toString());
      return responseClass;
    }
  }

  
}