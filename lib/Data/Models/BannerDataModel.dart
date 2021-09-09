import 'dart:convert';

List<BannerDataModel> bannerDataModelFromJson(String str) => List<BannerDataModel>.from(json.decode(str).map((x) => BannerDataModel.fromJson(x)));

String bannerDataModelToJson(List<BannerDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerDataModel {
  BannerDataModel({
    required this.bannerId,
    required this.bannerUrl,
    required this.id,
    required this.vendorUniqId,
  });

  String bannerId;
  String bannerUrl;
  String id;
  String vendorUniqId;

  factory BannerDataModel.fromJson(Map<String, dynamic> json) => BannerDataModel(
    bannerId: json["banner_id"],
    bannerUrl: json["banner_url"],
    id: json["_id"],
    vendorUniqId: json["vendor_uniq_id"],
  );

  Map<String, dynamic> toJson() => {
    "banner_id": bannerId,
    "banner_url": bannerUrl,
    "_id": id,
    "vendor_uniq_id": vendorUniqId,
  };
}
