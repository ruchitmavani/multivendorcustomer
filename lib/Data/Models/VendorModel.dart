import 'dart:convert';

import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';

import 'ProductModel.dart';

VendorDataModel vendorDataModelFromJson(String str) => VendorDataModel.fromJson(json.decode(str));

String vendorDataModelToJson(VendorDataModel data) => json.encode(data.toJson());

class VendorDataModel {
  VendorDataModel({
    required this.vendorUniqId,
    required this.businessName,
    required this.businessCategory,
    required this.mobileNumber,
    required this.emailAddress,
   required this.gstNumber,
    required this.storeLink,
    required this.logo,
    required this.latitude,
    required this.longitude,
    required this.coverImageUrl,
    required this.awordImageUrl,
    required this.address,
    required this.aboutBusiness,
    required this.businessHours,
    required this.profileCompletedPercentage,
    required this.profilePercentageCount,
    required this.isOnline,
    required this.isDeliveryCharges,
    required this.deliveryCharges,
    required this.freeDeliveryAboveAmount,
    required this.isStorePickupEnable,
    required this.isWhatsappChatSupport,
    required this.colorTheme,
    required this.taxDetails,
    required this.isOnlinePayment,
  });

  String vendorUniqId;
  String businessName;
  String businessCategory;
  String mobileNumber;
  String emailAddress;
  String gstNumber;
  String storeLink;
  String logo;
  double latitude;
  double longitude;
  String coverImageUrl;
  List<String> awordImageUrl;
  String address;
  String aboutBusiness;
  List<BusinessHour> businessHours;
  int profileCompletedPercentage;
  List<String> profilePercentageCount;
  bool isOnline;
  bool isDeliveryCharges;
  bool isOnlinePayment;
  double deliveryCharges;
  int freeDeliveryAboveAmount;
  bool isStorePickupEnable;
  bool isWhatsappChatSupport;
  String colorTheme;
  List<TaxDetail> taxDetails;

  factory VendorDataModel.fromJson(Map<String, dynamic> json) => VendorDataModel(
    vendorUniqId: json["vendor_uniq_id"],
    businessName: json["business_name"],
    businessCategory: json["business_category"],
    mobileNumber: json["mobile_number"],
    emailAddress: json["email_address"],
    gstNumber: json["gst_number"],
    storeLink: json["store_link"],
    logo: json["logo"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    coverImageUrl: json["cover_image_url"],
    awordImageUrl: List<String>.from(json["aword_image_url"].map((x) => x)),
    address: json["address"],
    aboutBusiness: json["about_business"],
    businessHours: List<BusinessHour>.from(json["business_hours"].map((x) => BusinessHour.fromJson(x))),
    profileCompletedPercentage: json["profile_completed_percentage"],
    profilePercentageCount: List<String>.from(json["profile_percentage_count"].map((x) => x)),
    isOnline: json["is_online"],
    isOnlinePayment: json["is_online_payment"],
    isDeliveryCharges: json["is_delivery_charges"],
    deliveryCharges: json["delivery_charges"],
    freeDeliveryAboveAmount: json["free_delivery_above_amount"],
    isStorePickupEnable: json["is_store_pickup_enable"],
    isWhatsappChatSupport: json["is_whatsapp_chat_support"],
    colorTheme: json["color_theme"],
    taxDetails: List<TaxDetail>.from(json["tax_details"].map((x) => TaxDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vendor_uniq_id": vendorUniqId,
    "business_name": businessName,
    "business_category": businessCategory,
    "mobile_number": mobileNumber,
    "email_address": emailAddress,
    "gst_number": gstNumber,
    "store_link": storeLink,
    "logo": logo,
    "latitude": latitude,
    "longitude": longitude,
    "cover_image_url": coverImageUrl,
    "aword_image_url": List<dynamic>.from(awordImageUrl.map((x) => x)),
    "address": address,
    "about_business": aboutBusiness,
    "business_hours": List<dynamic>.from(businessHours.map((x) => x.toJson())),
    "profile_completed_percentage": profileCompletedPercentage,
    "profile_percentage_count": List<dynamic>.from(profilePercentageCount.map((x) => x)),
    "is_online": isOnline,
    "is_delivery_charges": isDeliveryCharges,
    "delivery_charges": deliveryCharges,
    "free_delivery_above_amount": freeDeliveryAboveAmount,
    "is_store_pickup_enable": isStorePickupEnable,
    "is_whatsapp_chat_support": isWhatsappChatSupport,
    "color_theme": colorTheme,
    "tax_details": List<dynamic>.from(taxDetails.map((x) => x.toJson())),
  };
}
