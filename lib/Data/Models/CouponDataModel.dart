import 'dart:convert';

CouponDataModel couponDataModelFromJson(String str) => CouponDataModel.fromJson(json.decode(str));

String couponDataModelToJson(CouponDataModel data) => json.encode(data.toJson());

class CouponDataModel {
  CouponDataModel({
    required this.vendorUniqId,
    required this.couponId,
    required this.couponName,
    required this.isCouponEnable,
    required this.saleAmount,
    required this.couponType,
    required this.flatAmount,
    required this.minAmount,
    required this.offerPercentage,
    required this.offerUptoAmount,
    required this.maxUsesPerCustomer,
    required this.beneficiaryCustomer,
  });

  String vendorUniqId;
  String couponId;
  String couponName;
  bool isCouponEnable;
  int saleAmount;
  String couponType;
  int flatAmount;
  int minAmount;
  int offerPercentage;
  int offerUptoAmount;
  int maxUsesPerCustomer;
  List<BeneficiaryCustomer> beneficiaryCustomer;

  factory CouponDataModel.fromJson(Map<String, dynamic> json) => CouponDataModel(
    vendorUniqId: json["vendor_uniq_id"],
    couponId: json["coupon_id"],
    couponName: json["coupon_name"],
    isCouponEnable: json["is_coupon_enable"],
    saleAmount: json["sale_amount"],
    couponType: json["coupon_type"],
    flatAmount: json["flat_amount"],
    minAmount: json["min_amount"],
    offerPercentage: json["offer_percentage"],
    offerUptoAmount: json["offer_upto_amount"],
    maxUsesPerCustomer: json["max_uses_per_customer"],
    beneficiaryCustomer: List<BeneficiaryCustomer>.from(json["beneficiary_customer"].map((x) => BeneficiaryCustomer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vendor_uniq_id": vendorUniqId,
    "coupon_id": couponId,
    "coupon_name": couponName,
    "is_coupon_enable": isCouponEnable,
    "sale_amount": saleAmount,
    "coupon_type": couponType,
    "flat_amount": flatAmount,
    "min_amount": minAmount,
    "offer_percentage": offerPercentage,
    "offer_upto_amount": offerUptoAmount,
    "max_uses_per_customer": maxUsesPerCustomer,
    "beneficiary_customer": List<dynamic>.from(beneficiaryCustomer.map((x) => x.toJson())),
  };
}

class BeneficiaryCustomer {
  BeneficiaryCustomer({
    required this.customerUniqId,
    required this.customerName,
  });

  String customerUniqId;
  String customerName;

  factory BeneficiaryCustomer.fromJson(Map<String, dynamic> json) => BeneficiaryCustomer(
    customerUniqId: json["customer_uniq_id"],
    customerName: json["customer_name"],
  );

  Map<String, dynamic> toJson() => {
    "customer_uniq_id": customerUniqId,
    "customer_name": customerName,
  };
}
