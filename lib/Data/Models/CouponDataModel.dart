// To parse this JSON data, do
//
//     final couponDataModel = couponDataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CouponDataModel couponDataModelFromJson(String str) => CouponDataModel.fromJson(json.decode(str));

String couponDataModelToJson(CouponDataModel data) => json.encode(data.toJson());

class CouponDataModel {
  CouponDataModel({
    required this.vendorUniqId,
    required this.couponId,
    required this.couponName,
    required this.isCouponEnable,
    required this.timeUsedCount,
    required this.customerUsedCount,
    required this.saleAmount,
    required this.couponType,
    required this.flatAmount,
    required this.minAmount,
    required this.offerPercentage,
    required this.offerUptoAmount,
    required this.validityFrom,
    required this.validityTo,
    required this.maxUsesPerCustomer,
    required this.beneficiaryCustomer,
    required this.id,
  });

  String vendorUniqId;
  String couponId;
  String couponName;
  bool isCouponEnable;
  int timeUsedCount;
  int customerUsedCount;
  int saleAmount;
  String couponType;
  int flatAmount;
  int minAmount;
  int offerPercentage;
  int offerUptoAmount;
  DateTime validityFrom;
  DateTime validityTo;
  int maxUsesPerCustomer;
  List<String> beneficiaryCustomer;
  String id;

  factory CouponDataModel.fromJson(Map<String, dynamic> json) => CouponDataModel(
    vendorUniqId: json["vendor_uniq_id"],
    couponId: json["coupon_id"],
    couponName: json["coupon_name"],
    isCouponEnable: json["is_coupon_enable"],
    timeUsedCount: json["time_used_count"],
    customerUsedCount: json["customer_used_count"],
    saleAmount: json["sale_amount"],
    couponType: json["coupon_type"],
    flatAmount: json["flat_amount"],
    minAmount: json["min_amount"],
    offerPercentage: json["offer_percentage"],
    offerUptoAmount: json["offer_upto_amount"],
    validityFrom: DateTime.parse(json["validity_from"]),
    validityTo: DateTime.parse(json["validity_to"]),
    maxUsesPerCustomer: json["max_uses_per_customer"],
    beneficiaryCustomer: List<String>.from(json["beneficiary_customer"].map((x) => x)),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_uniq_id": vendorUniqId,
    "coupon_id": couponId,
    "coupon_name": couponName,
    "is_coupon_enable": isCouponEnable,
    "time_used_count": timeUsedCount,
    "customer_used_count": customerUsedCount,
    "sale_amount": saleAmount,
    "coupon_type": couponType,
    "flat_amount": flatAmount,
    "min_amount": minAmount,
    "offer_percentage": offerPercentage,
    "offer_upto_amount": offerUptoAmount,
    "validity_from": validityFrom.toIso8601String(),
    "validity_to": validityTo.toIso8601String(),
    "max_uses_per_customer": maxUsesPerCustomer,
    "beneficiary_customer": List<dynamic>.from(beneficiaryCustomer.map((x) => x)),
    "_id": id,
  };
}
