import 'dart:convert';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';

AllCategoryModel allCategoryModelFromJson(String str) =>
    AllCategoryModel.fromJson(json.decode(str));

String allCategoryModelToJson(AllCategoryModel data) =>
    json.encode(data.toJson());

class AllCategoryModel {
  AllCategoryModel({
    required this.id,
    required this.categoryLiveTimings,
    required this.categoryIsActive,
    required this.categoryNoOfProduct,
    required this.categoryIsInStock,
    required this.categoryProductStock,
    required this.vendorUniqId,
    required this.categoryId,
    required this.categoryName,
    required this.createdDateTime,
    required this.productDetails,
  });

  String id;
  List<String> categoryLiveTimings;
  bool categoryIsActive;
  int categoryNoOfProduct;
  bool categoryIsInStock;
  int categoryProductStock;
  String vendorUniqId;
  String categoryId;
  String categoryName;
  DateTime createdDateTime;
  List<ProductData> productDetails;

  factory AllCategoryModel.fromJson(Map<String, dynamic> json) =>
      AllCategoryModel(
          id: json["_id"],
          categoryLiveTimings:
              List<String>.from(json["category_live_timings"].map((x) => x)),
          categoryIsActive: json["category_is_active"],
          categoryNoOfProduct: json["category_no_of_product"],
          categoryIsInStock: json["category_is_in_stock"],
          categoryProductStock: json["category_product_stock"],
          vendorUniqId: json["vendor_uniq_id"],
          categoryId: json["category_id"],
          categoryName: json["category_name"],
          createdDateTime: DateTime.parse(json["created_date_time"]),
          productDetails: json["product_details"]
              .map<ProductData>((x) => ProductData.fromJson(x))
              .toList());

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_live_timings":
            List<dynamic>.from(categoryLiveTimings.map((x) => x)),
        "category_is_active": categoryIsActive,
        "category_no_of_product": categoryNoOfProduct,
        "category_is_in_stock": categoryIsInStock,
        "category_product_stock": categoryProductStock,
        "vendor_uniq_id": vendorUniqId,
        "category_id": categoryId,
        "category_name": categoryName,
        "created_date_time": createdDateTime.toIso8601String(),
        "product_details": List<dynamic>.from(productDetails.map((x) => x)),
      };
}
