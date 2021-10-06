// To parse this JSON data, do
//
//     final newCartModel = newCartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'CartDataModel.dart';
import 'ProductModel.dart';

List<NewCartModel> newCartModelFromJson(String str) => List<NewCartModel>.from(json.decode(str).map((x) => NewCartModel.fromJson(x)));

String newCartModelToJson(List<NewCartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewCartModel {
  NewCartModel({
    required this.productId,
     required this.productQuantity,
    required this.productSize,
    required this.productColor,
    required this.productImageUrl,
    required this.productName,
    required this.productMrp,
    required this.productSellingPrice,
    required this.taxId,
    required this.taxDetails,
  });

  String productId;
  int productQuantity;
  ProductSize? productSize;
  ProductColor? productColor;
  List<String> productImageUrl;
  String productName;
  int productMrp;
  int productSellingPrice;
  List<String> taxId;
  List<TaxDetail> taxDetails;

  factory NewCartModel.fromJson(Map<String, dynamic> json) => NewCartModel(
    productId: json["product_id"],
    productQuantity: json["product_quantity"],
    productSize: json["product_size"] == null ? null : ProductSize.fromJson(json["product_size"]),
    productColor: json["product_color"] == null ? null : ProductColor.fromJson(json["product_color"]),
    productImageUrl: List<String>.from(json["product_image_url"].map((x) => x)),
    productName: json["product_name"],
    productMrp: json["product_mrp"],
    productSellingPrice: json["product_selling_price"],
    taxId: List<String>.from(json["tax_id"].map((x) => x)),
    taxDetails: List<TaxDetail>.from(json["tax_details"].map((x) => TaxDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_quantity": productQuantity,
    "product_size": productSize == null ? null : productSize!.toJson(),
    "product_color": productColor == null ? null : productColor!.toJson(),
    "product_image_url": List<dynamic>.from(productImageUrl.map((x) => x)),
    "product_name": productName,
    "product_mrp": productMrp,
    "product_selling_price": productSellingPrice,
    "tax_id": List<dynamic>.from(taxId.map((x) => x)),
    "tax_details": List<dynamic>.from(taxDetails.map((x) => x.toJson())),
  };
}