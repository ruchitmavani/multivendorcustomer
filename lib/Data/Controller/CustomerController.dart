import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductController.dart';

class CustomerController {
  /*-----------Get Customer Data-----------*/
  static Future<ResponseClass> getCustomerData(String customerId) async {
    String url = StringConstants.api_url + StringConstants.customer_view;

    //body Data
    var data = {"customer_uniq_id": "$customerId"};

    ResponseClass<CustomerDataModel> responseClass =
        ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = CustomerDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      log("getCustomerData ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Update Customer Data-----------*/
  static Future<ResponseClass> updateCustomerData({required String customerId,required String name,
    required String mobileNumber,
    required List<Map<String,dynamic>> address,
    required String email,
    required String dob}) async {
    String url = StringConstants.api_url + StringConstants.customer_update;

    //body Data
    var data = {
      "customer_uniq_id": "$customerId",
      "customer_name": "$name",
      "customer_email_address": "$email",
      "customer_mobile_number": "$mobileNumber",
      "customer_DOB":"$dob",
      "customer_address": address
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
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = CustomerDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      log("updateCustomerData ->>>" + e.toString());
      return responseClass;
    }
  }
}
