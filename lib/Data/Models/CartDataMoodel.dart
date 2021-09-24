// To parse this JSON data, do
//
//     final cartDataModel = cartDataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CartDataModel> cartDataModelFromJson(String str) => List<CartDataModel>.from(json.decode(str).map((x) => CartDataModel.fromJson(x)));

String cartDataModelToJson(List<CartDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartDataModel {
  CartDataModel({
    required this.id,
    required this.customerUniqId,
    required this.vendorUniqId,
    required this.productId,
    required this.productQuantity,
    required this.cartId,
    required this.productSize,
    required this.productColor,
    required this.createdDateTime,
    required this.productDetails,
  });

  String id;
  String customerUniqId;
  String vendorUniqId;
  String productId;
  int productQuantity;
  String cartId;
  ProductSize? productSize;
  ProductColor? productColor;
  DateTime createdDateTime;
  List<CartProductDetail> productDetails;

  factory CartDataModel.fromJson(Map<String, dynamic> json) => CartDataModel(
    id: json["_id"],
    customerUniqId: json["customer_uniq_id"],
    vendorUniqId: json["vendor_uniq_id"],
    productId: json["product_id"],
    productQuantity: json["product_quantity"],
    cartId: json["cart_id"],
    productSize: json["product_size"] == null ? null : ProductSize.fromJson(json["product_size"]),
    productColor: json["product_color"] == null ? null : ProductColor.fromJson(json["product_color"]),
    createdDateTime: DateTime.parse(json["created_date_time"]),
    productDetails: List<CartProductDetail>.from(json["product_details"].map((x) => CartProductDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customer_uniq_id": customerUniqId,
    "vendor_uniq_id": vendorUniqId,
    "product_id": productId,
    "product_quantity": productQuantity,
    "cart_id": cartId,
    "product_size": productSize == null ? null : productSize!.toJson(),
    "product_color": productColor == null ? null : productColor!.toJson(),
    "created_date_time": createdDateTime.toIso8601String(),
    "product_details": List<dynamic>.from(productDetails.map((x) => x.toJson())),
  };
}

class ProductColor {
  ProductColor({
    required this.colorCode,
    required this.isActive,
  });

  String colorCode;
  bool isActive;

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
    colorCode: json["color_code"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "color_code": colorCode,
    "is_active": isActive,
  };
}

class CartProductDetail {
  CartProductDetail({
    required this.id,
    required this.vendorUniqId,
    required this.categoryId,
    required this.productId,
    required this.productImageUrl,
    required this.productVideoUrl,
    required this.productYoutubeUrl,
    required this.isYoutubeUrl,
    required this.productName,
    required this.productMrp,
    required this.productSellingPrice,
    required this.bulkPriceList,
    required this.isRequestPrice,
    required this.taxId,
    required this.stockLeft,
    required this.unitType,
    required this.productLiveTiming,
    required this.productDescription,
    required this.productVariationSizes,
    required this.productVariationColors,
    required this.productTotalRating,
    required this.productRatingCountRecord,
    required this.productRatingAverage,
    required this.categoryIsActive,
    required this.productIsActive,
    required this.orderedQuantity,
    required this.createdDateTime,
    required this.v,
    required this.taxDetails,
  });

  String id;
  String vendorUniqId;
  String categoryId;
  String productId;
  List<String> productImageUrl;
  String productVideoUrl;
  String productYoutubeUrl;
  bool isYoutubeUrl;
  String productName;
  int productMrp;
  int productSellingPrice;
  List<dynamic> bulkPriceList;
  bool isRequestPrice;
  List<String> taxId;
  int stockLeft;
  String unitType;
  List<String> productLiveTiming;
  String productDescription;
  List<ProductSize> productVariationSizes;
  List<ProductColor> productVariationColors;
  int productTotalRating;
  int productRatingCountRecord;
  int productRatingAverage;
  bool categoryIsActive;
  bool productIsActive;
  int orderedQuantity;
  DateTime createdDateTime;
  int v;
  List<TaxDetail> taxDetails;

  factory CartProductDetail.fromJson(Map<String, dynamic> json) => CartProductDetail(
    id: json["_id"],
    vendorUniqId: json["vendor_uniq_id"],
    categoryId: json["category_id"],
    productId: json["product_id"],
    productImageUrl: List<String>.from(json["product_image_url"].map((x) => x)),
    productVideoUrl: json["product_video_url"],
    productYoutubeUrl: json["product_youtube_url"],
    isYoutubeUrl: json["is_youtube_url"],
    productName: json["product_name"],
    productMrp: json["product_mrp"],
    productSellingPrice: json["product_selling_price"],
    bulkPriceList: List<dynamic>.from(json["bulk_price_list"].map((x) => x)),
    isRequestPrice: json["is_request_price"],
    taxId: List<String>.from(json["tax_id"].map((x) => x)),
    stockLeft: json["stock_left"],
    unitType: json["unit_type"],
    productLiveTiming: List<String>.from(json["product_live_timing"].map((x) => x)),
    productDescription: json["product_description"],
    productVariationSizes: List<ProductSize>.from(json["product_variation_sizes"].map((x) => ProductSize.fromJson(x))),
    productVariationColors: List<ProductColor>.from(json["product_variation_colors"].map((x) => ProductColor.fromJson(x))),
    productTotalRating: json["product_total_rating"],
    productRatingCountRecord: json["product_rating_count_record"],
    productRatingAverage: json["product_rating_average"],
    categoryIsActive: json["category_is_active"],
    productIsActive: json["product_is_active"],
    orderedQuantity: json["ordered_quantity"],
    createdDateTime: DateTime.parse(json["created_date_time"]),
    v: json["__v"],
    taxDetails: List<TaxDetail>.from(json["tax_details"].map((x) => TaxDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "vendor_uniq_id": vendorUniqId,
    "category_id": categoryId,
    "product_id": productId,
    "product_image_url": List<dynamic>.from(productImageUrl.map((x) => x)),
    "product_video_url": productVideoUrl,
    "product_youtube_url": productYoutubeUrl,
    "is_youtube_url": isYoutubeUrl,
    "product_name": productName,
    "product_mrp": productMrp,
    "product_selling_price": productSellingPrice,
    "bulk_price_list": List<dynamic>.from(bulkPriceList.map((x) => x)),
    "is_request_price": isRequestPrice,
    "tax_id": List<dynamic>.from(taxId.map((x) => x)),
    "stock_left": stockLeft,
    "unit_type": unitType,
    "product_live_timing": List<dynamic>.from(productLiveTiming.map((x) => x)),
    "product_description": productDescription,
    "product_variation_sizes": List<dynamic>.from(productVariationSizes.map((x) => x.toJson())),
    "product_variation_colors": List<dynamic>.from(productVariationColors.map((x) => x.toJson())),
    "product_total_rating": productTotalRating,
    "product_rating_count_record": productRatingCountRecord,
    "product_rating_average": productRatingAverage,
    "category_is_active": categoryIsActive,
    "product_is_active": productIsActive,
    "ordered_quantity": orderedQuantity,
    "created_date_time": createdDateTime.toIso8601String(),
    "__v": v,
    "tax_details": List<dynamic>.from(taxDetails.map((x) => x.toJson())),
  };
}

class ProductSize {
  ProductSize({
    required this.size,
    required this.mrp,
    required this.sellingPrice,
    required this.isActive,
  });

  String size;
  int mrp;
  int sellingPrice;
  bool isActive;

  factory ProductSize.fromJson(Map<String, dynamic> json) => ProductSize(
    size: json["size"],
    mrp: json["mrp"],
    sellingPrice: json["selling_price"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "mrp": mrp,
    "selling_price": sellingPrice,
    "is_active": isActive,
  };
}

class TaxDetail {
  TaxDetail({
    required this.isTaxEnable,
    required this.id,
    required this.taxId,
    required this.vendorUniqId,
    required this.taxName,
    required this.taxPercentage,
    required this.createdDateTime,
    required this.v,
  });

  bool isTaxEnable;
  String id;
  String taxId;
  String vendorUniqId;
  String taxName;
  int taxPercentage;
  DateTime createdDateTime;
  int v;

  factory TaxDetail.fromJson(Map<String, dynamic> json) => TaxDetail(
    isTaxEnable: json["is_tax_enable"],
    id: json["_id"],
    taxId: json["tax_id"],
    vendorUniqId: json["vendor_uniq_id"],
    taxName: json["tax_name"],
    taxPercentage: json["tax_percentage"],
    createdDateTime: DateTime.parse(json["created_date_time"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "is_tax_enable": isTaxEnable,
    "_id": id,
    "tax_id": taxId,
    "vendor_uniq_id": vendorUniqId,
    "tax_name": taxName,
    "tax_percentage": taxPercentage,
    "created_date_time": createdDateTime.toIso8601String(),
    "__v": v,
  };
}
