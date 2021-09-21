import 'dart:convert';

RatingDataModel ratingDataModelFromJson(String str) => RatingDataModel.fromJson(json.decode(str));

String ratingDataModelToJson(RatingDataModel data) => json.encode(data.toJson());

class RatingDataModel {
  RatingDataModel({
    required this.productId,
    required this.productRatingCount,
    required this.orderId,
    required this.customerName,
    required this.customerMobileNumber,
    required this.ratingId,
    required this.customerUniqId,
  });

  String productId;
  int productRatingCount;
  String orderId;
  String customerName;
  String customerMobileNumber;
  String ratingId;
  String customerUniqId;

  factory RatingDataModel.fromJson(Map<String, dynamic> json) => RatingDataModel(
    productId: json["product_id"],
    productRatingCount: json["product_rating_count"],
    orderId: json["order_id"],
    customerName: json["customer_name"],
    customerMobileNumber: json["customer_mobile_number"],
    ratingId: json["rating_id"],
    customerUniqId: json["customer_uniq_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_rating_count": productRatingCount,
    "order_id": orderId,
    "customer_name": customerName,
    "customer_mobile_number": customerMobileNumber,
    "rating_id": ratingId,
    "customer_uniq_id": customerUniqId,
  };
}
