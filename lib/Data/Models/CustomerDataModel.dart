// To parse this JSON data, do
//
//     final customerDataModel = customerDataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomerDataModel customerDataModelFromJson(String str) => CustomerDataModel.fromJson(json.decode(str));

String customerDataModelToJson(CustomerDataModel data) => json.encode(data.toJson());

class CustomerDataModel {
  CustomerDataModel({
    required this.customerName,
    required this.customerEmailAddress,
    required this.customerMobileNumber,
    required this.customerAddress,
    required this.customerDob,
    required this.id,
    required this.customerUniqId,
  });

  String customerName;
  String customerEmailAddress;
  String customerMobileNumber;
  List<CustomerAddress> customerAddress;
  DateTime customerDob;
  String id;
  String customerUniqId;

  factory CustomerDataModel.fromJson(Map<String, dynamic> json) => CustomerDataModel(
    customerName: json["customer_name"],
    customerEmailAddress: json["customer_email_address"],
    customerMobileNumber: json["customer_mobile_number"],
    customerAddress: List<CustomerAddress>.from(json["customer_address"].map((x) => CustomerAddress.fromJson(x))),
    customerDob: DateTime.parse(json["customer_DOB"]),
    id: json["_id"],
    customerUniqId: json["customer_uniq_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_name": customerName,
    "customer_email_address": customerEmailAddress,
    "customer_mobile_number": customerMobileNumber,
    "customer_address": List<dynamic>.from(customerAddress.map((x) => x.toJson())),
    "customer_DOB": customerDob.toIso8601String(),
    "_id": id,
    "customer_uniq_id": customerUniqId,
  };
}

class CustomerAddress {
  CustomerAddress({
    required this.type,
    required this.subAddress,
    required this.area,
    required this.city,
    required this.pincode,
  });

  String type;
  String subAddress;
  String area;
  String city;
  int pincode;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) => CustomerAddress(
    type: json["type"],
    subAddress: json["subAddress"],
    area: json["area"],
    city: json["city"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "subAddress": subAddress,
    "area": area,
    "city": city,
    "pincode": pincode,
  };
}
