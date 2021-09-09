import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/Response.dart';

import 'ProductContoller.dart';

class AuthController{

  /*-----------Get Auth Data-----------*/
  static Future<ResponseClass> sendOtp(String mobileNumber) async {
    String url = StringConstants.API_URL + StringConstants.vendor_send_sms;

    //body Data
    var data = {
      "mobile_number": "$mobileNumber"
    };

    ResponseClass<String> responseClass =
    ResponseClass(success: false, message: "Something went wrong");
    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      log("response -> ${response.data}");
      if (response.statusCode == 200) {
        log("otp ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = response.data["data"];
      }
      return responseClass;
    } catch (e) {
      print("otp ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Register Customer----------*/
  static Future<ResponseClass> register(
      {required String name,
      required String mobileNumber,
      required List<Map<String,dynamic>> address,
      required String email,
      required String dob}) async {
    String url = StringConstants.API_URL + StringConstants.customer_registration;

    //body Data
    var data = {
      "customer_name": "$name",
      "customer_mobile_number" : "$mobileNumber",
      "customer_address" : address,
      "customer_email_address" : "$email",
      "customer_DOB" : "$dob"
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
        log("register ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = CustomerDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("register ->>>" + e.toString());
      return responseClass;
    }
  }

  /*-----------Get Login Data-----------*/
  static Future<ResponseClass<CustomerDataModel>> login(String mobileNumber) async {
    String url = StringConstants.API_URL + StringConstants.customer_login;

    //body Data
    var data = {
      "customer_mobile_number": "$mobileNumber"
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
        log("login ${response.data}");
        responseClass.success = response.data["is_success"];
        responseClass.message = response.data["message"];
        responseClass.data = CustomerDataModel.fromJson(response.data["data"]);
      }
      return responseClass;
    } catch (e) {
      print("login ->>>" + e.toString());
      return responseClass;
    }
  }
}