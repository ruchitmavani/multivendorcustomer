// To parse this JSON data, do
//
//     final vendorModel = vendorModelFromJson(jsonString);

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:multi_vendor_customer/Data/Controller/VendorController.dart';

VendorModel vendorModelFromJson(String str) => VendorModel.fromJson(json.decode(str));

String vendorModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  VendorModel({
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
    required this.createdDateTime,
    required this.isOnline,
    required this.isDeliveryCharges,
    required this.isStorePickupEnable,
    required this.isWhatsappChatSupport,
    required this.colorTheme,
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
  List<String> businessHours;
  int profileCompletedPercentage;
  List<String> profilePercentageCount;
  DateTime createdDateTime;
  bool isOnline;
  bool isDeliveryCharges;
  bool isStorePickupEnable;
  bool isWhatsappChatSupport;
  String colorTheme;

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
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
    businessHours: List<String>.from(json["business_hours"].map((x) => x)),
    profileCompletedPercentage: json["profile_completed_percentage"],
    profilePercentageCount: List<String>.from(json["profile_percentage_count"].map((x) => x)),
    createdDateTime: DateTime.parse(json["created_date_time"]),
    isOnline: json["is_online"],
    isDeliveryCharges: json["is_delivery_charges"],
    isStorePickupEnable: json["is_store_pickup_enable"],
    isWhatsappChatSupport: json["is_whatsapp_chat_support"],
    colorTheme: json["color_theme"],
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
    "business_hours": List<dynamic>.from(businessHours.map((x) => x)),
    "profile_completed_percentage": profileCompletedPercentage,
    "profile_percentage_count": List<dynamic>.from(profilePercentageCount.map((x) => x)),
    "created_date_time": createdDateTime.toIso8601String(),
    "is_online": isOnline,
    "is_delivery_charges": isDeliveryCharges,
    "is_store_pickup_enable": isStorePickupEnable,
    "is_whatsapp_chat_support": isWhatsappChatSupport,
    "color_theme": colorTheme,
  };
}


class VendorModelWrapper with ChangeNotifier{
  VendorModel? vendorModel;
  bool isLoaded=false;

  Future loadVendorData()async{
    print("Calling");
    await VendorController.getVendorData(vendorId: "657202115727_9429828152").then(
            (value) {
          if (value.success) {
            print(value.success);
            vendorModel=value.data;
            isLoaded=true;
            print("loaded");
          }
        }, onError: (e) {
              print(e);
    });
  }
}