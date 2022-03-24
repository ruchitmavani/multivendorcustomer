// To parse this JSON data, do
//
//     final customerDataModel = customerDataModelFromJson(jsonString);

import 'dart:convert';

import 'AddressModel.dart';

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
  List<Address> customerAddress;
  DateTime customerDob;
  String id;
  String customerUniqId;

  factory CustomerDataModel.fromJson(Map<String, dynamic> json) => CustomerDataModel(
    customerName: json["customer_name"],
    customerEmailAddress: json["customer_email_address"],
    customerMobileNumber: json["customer_mobile_number"],
    customerAddress: List<Address>.from(json["customer_address"].map((x) => Address.fromJson(x))),
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
