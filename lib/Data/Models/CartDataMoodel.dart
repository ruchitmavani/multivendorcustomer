import 'dart:convert';

CartDataModel cartDataModelFromJson(String str) => CartDataModel.fromJson(json.decode(str));

String cartDataModelToJson(CartDataModel data) => json.encode(data.toJson());

class CartDataModel {
  CartDataModel({
    required this.customerUniqId,
    required this.vendorUniqId,
    required this.productId,
    required this.productQuantity,
    required this.productSize,
    required this.productColor,
    required this.id,
    required this.cartId,
  });

  String customerUniqId;
  String vendorUniqId;
  List<ProductId> productId;
  int productQuantity;
  List<ProductSize> productSize;
  List<ProductColor> productColor;
  String id;
  String cartId;

  factory CartDataModel.fromJson(Map<String, dynamic> json) => CartDataModel(
    customerUniqId: json["customer_uniq_id"],
    vendorUniqId: json["vendor_uniq_id"],
    productId: List<ProductId>.from(json["product_id"].map((x) => ProductId.fromJson(x))),
    productQuantity: json["product_quantity"],
    productSize: List<ProductSize>.from(json["product_size"].map((x) => ProductSize.fromJson(x))),
    productColor: List<ProductColor>.from(json["product_color"].map((x) => ProductColor.fromJson(x))),
    id: json["_id"],
    cartId: json["cart_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_uniq_id": customerUniqId,
    "vendor_uniq_id": vendorUniqId,
    "product_id": List<dynamic>.from(productId.map((x) => x.toJson())),
    "product_quantity": productQuantity,
    "product_size": List<dynamic>.from(productSize.map((x) => x.toJson())),
    "product_color": List<dynamic>.from(productColor.map((x) => x.toJson())),
    "_id": id,
    "cart_id": cartId,
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

class ProductId {
  ProductId({
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
  List<ProductSize> productVariationSizes;
  List<ProductColor> productVariationColors;
  int productTotalRating;
  int productRatingCountRecord;
  int productRatingAverage;
  String id;

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
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
    productVariationSizes: List<ProductSize>.from(json["product_variation_sizes"].map((x) => ProductSize.fromJson(x))),
    productVariationColors: List<ProductColor>.from(json["product_variation_colors"].map((x) => ProductColor.fromJson(x))),
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

class TaxId {
  TaxId({
    required this.isTaxEnable,
    required this.id,
    required this.taxId,
    required this.vendorUniqId,
    required this.taxName,
    required this.taxPercentage,
  });

  bool isTaxEnable;
  String id;
  String taxId;
  String vendorUniqId;
  String taxName;
  int taxPercentage;

  factory TaxId.fromJson(Map<String, dynamic> json) => TaxId(
    isTaxEnable: json["is_tax_enable"],
    id: json["_id"],
    taxId: json["tax_id"],
    vendorUniqId: json["vendor_uniq_id"],
    taxName: json["tax_name"],
    taxPercentage: json["tax_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "is_tax_enable": isTaxEnable,
    "_id": id,
    "tax_id": taxId,
    "vendor_uniq_id": vendorUniqId,
    "tax_name": taxName,
    "tax_percentage": taxPercentage,
  };
}
