import 'dart:convert';

ProductData productDataFromJson(String str) => ProductData.fromJson(json.decode(str));

String productDataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  ProductData({
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
    required this.id,
  });

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
  List<TaxId> taxId;
  int stockLeft;
  String unitType;
  List<String> productLiveTiming;
  String productDescription;
  List<ProductVariationSize> productVariationSizes;
  List<ProductVariationColor> productVariationColors;
  int productTotalRating;
  int productRatingCountRecord;
  double productRatingAverage;
  String id;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
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
    taxId: List<TaxId>.from(json["tax_id"].map((x) => TaxId.fromJson(x))),
    stockLeft: json["stock_left"],
    unitType: json["unit_type"],
    productLiveTiming: List<String>.from(json["product_live_timing"].map((x) => x)),
    productDescription: json["product_description"],
    productVariationSizes: List<ProductVariationSize>.from(json["product_variation_sizes"].map((x) => ProductVariationSize.fromJson(x))),
    productVariationColors: List<ProductVariationColor>.from(json["product_variation_colors"].map((x) => ProductVariationColor.fromJson(x))),
    productTotalRating: json["product_total_rating"],
    productRatingCountRecord: json["product_rating_count_record"],
    productRatingAverage: json["product_rating_average"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
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
    "tax_id": List<dynamic>.from(taxId.map((x) => x.toJson())),
    "stock_left": stockLeft,
    "unit_type": unitType,
    "product_live_timing": List<dynamic>.from(productLiveTiming.map((x) => x)),
    "product_description": productDescription,
    "product_variation_sizes": List<dynamic>.from(productVariationSizes.map((x) => x.toJson())),
    "product_variation_colors": List<dynamic>.from(productVariationColors.map((x) => x.toJson())),
    "product_total_rating": productTotalRating,
    "product_rating_count_record": productRatingCountRecord,
    "product_rating_average": productRatingAverage,
    "_id": id,
  };
}

class ProductVariationColor {
  ProductVariationColor({
    required this.color,
    required this.mrp,
  });

  String color;
  int mrp;

  factory ProductVariationColor.fromJson(Map<String, dynamic> json) => ProductVariationColor(
    color: json["color"],
    mrp: json["mrp"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "mrp": mrp,
  };
}

class ProductVariationSize {
  ProductVariationSize({
    required this.size,
    required this.mrp,
  });

  String size;
  int mrp;

  factory ProductVariationSize.fromJson(Map<String, dynamic> json) => ProductVariationSize(
    size: json["size"],
    mrp: json["mrp"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "mrp": mrp,
  };
}

class TaxId {
  TaxId({
    required this.isTaxEnable,
    required this.id,
    required this.taxId,
    required this.vendorUniqId,
    required this.taxName,
    required this.taxPercentage,
    required this.createdDateTime
  });

  bool isTaxEnable;
  String id;
  String taxId;
  String vendorUniqId;
  String taxName;
  int taxPercentage;
  DateTime createdDateTime;

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    isTaxEnable: json["is_tax_enable"],
    id: json["_id"],
    taxId: json["tax_id"],
    vendorUniqId: json["vendor_uniq_id"],
    taxName: json["tax_name"],
    taxPercentage: json["tax_percentage"],
    createdDateTime: DateTime.parse(json["created_date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "is_tax_enable": isTaxEnable,
    "_id": id,
    "tax_id": taxId,
    "vendor_uniq_id": vendorUniqId,
    "tax_name": taxName,
    "tax_percentage": taxPercentage,
    "created_date_time": createdDateTime.toIso8601String()
  };
}
