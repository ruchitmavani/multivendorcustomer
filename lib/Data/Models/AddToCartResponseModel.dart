// To parse this JSON data, do
//
//     final addtoCartResponseModel = addtoCartResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'CartDataMoodel.dart';

AddtoCartResponseModel addtoCartResponseModelFromJson(String str) => AddtoCartResponseModel.fromJson(json.decode(str));

String addtoCartResponseModelToJson(AddtoCartResponseModel data) => json.encode(data.toJson());

class AddtoCartResponseModel {
  AddtoCartResponseModel({
    required this.customerUniqId,
    required this.vendorUniqId,
    required this.productId,
    required this.productQuantity,
    required this.id,
    required this.cartId,
    required this.productSize,
    required this.productColor,
    required this.createdDateTime,
  });

  String customerUniqId;
  String vendorUniqId;
  String productId;
  int productQuantity;
  String id;
  String cartId;
  ProductSize productSize;
  ProductColor productColor;
  DateTime createdDateTime;

  factory AddtoCartResponseModel.fromJson(Map<String, dynamic> json) => AddtoCartResponseModel(
    customerUniqId: json["customer_uniq_id"],
    vendorUniqId: json["vendor_uniq_id"],
    productId: json["product_id"],
    productQuantity: json["product_quantity"],
    id: json["_id"],
    cartId: json["cart_id"],
    productSize: ProductSize.fromJson(json["product_size"]),
    productColor: ProductColor.fromJson(json["product_color"]),
    createdDateTime: DateTime.parse(json["created_date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "customer_uniq_id": customerUniqId,
    "vendor_uniq_id": vendorUniqId,
    "product_id": productId,
    "product_quantity": productQuantity,
    "_id": id,
    "cart_id": cartId,
    "product_size": productSize.toJson(),
    "product_color": productColor.toJson(),
    "created_date_time": createdDateTime.toIso8601String(),
  };
}

