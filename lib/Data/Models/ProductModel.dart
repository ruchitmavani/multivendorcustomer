class ProductData {
  ProductData({
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
    required this.orderedQuantity,
    required this.productIsActive,
    required this.categoryIsActive,
    required this.cartDetails,
    required this.bulkPriceList,
    required this.isRequestPrice,
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
  List<String> taxId;
  int stockLeft;
  String unitType;
  List<String> productLiveTiming;
  String productDescription;
  List<ProductSize> productVariationSizes;
  List<ProductColor> productVariationColors;
  int productTotalRating;
  int productRatingCountRecord;
  double productRatingAverage;
  int orderedQuantity;
  bool productIsActive;
  bool categoryIsActive;
  CartDetails? cartDetails;
  List<dynamic>? bulkPriceList;
  bool isRequestPrice;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
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
    taxId: List<String>.from(json["tax_id"].map((x) => x)),
    stockLeft: json["stock_left"],
    unitType: json["unit_type"],
    productLiveTiming: List<String>.from(json["product_live_timing"].map((x) => x)),
    productDescription: json["product_description"],
    productVariationSizes: List<ProductSize>.from(json["product_variation_sizes"].map((x) => ProductSize.fromJson(x))),
    productVariationColors: List<ProductColor>.from(json["product_variation_colors"].map((x) => ProductColor.fromJson(x))),
    productTotalRating: json["product_total_rating"],
    productRatingCountRecord: json["product_rating_count_record"],
    productRatingAverage: json["product_rating_average"].toDouble(),
    orderedQuantity: json["ordered_quantity"],
    productIsActive: json["product_is_active"],
    categoryIsActive: json["category_is_active"],
    cartDetails: json["cart_details"] == null || json["cart_details"] == {}? null : CartDetails.fromJson(json["cart_details"]),
    bulkPriceList: json["bulk_price_list"] == null ? null : List<dynamic>.from(json["bulk_price_list"].map((x) => x)),
    isRequestPrice: json["is_request_price"] == null ? null : json["is_request_price"],
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
    "ordered_quantity": orderedQuantity,
    "product_is_active": productIsActive,
    "category_is_active": categoryIsActive,
    "cart_details": cartDetails == null ? null : cartDetails!.toJson(),
    "bulk_price_list": bulkPriceList == null ? null : List<dynamic>.from(bulkPriceList!.map((x) => x)),
    "is_request_price": isRequestPrice == null ? null : isRequestPrice,
  };
}

class CartDetails {
  CartDetails({
    required this.customerUniqId,
    required this.vendorUniqId,
    required this.productId,
    required this.productQuantity,
    required this.id,
    required this.cartId,
    required this.productSize,
    required this.productColor,
  });

  String customerUniqId;
  String vendorUniqId;
  String productId;
  int productQuantity;
  String id;
  String cartId;
  ProductSize productSize;
  ProductColor productColor;

  factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
    customerUniqId: json["customer_uniq_id"],
    vendorUniqId: json["vendor_uniq_id"],
    productId: json["product_id"],
    productQuantity: json["product_quantity"],
    id: json["_id"],
    cartId: json["cart_id"],
    productSize: ProductSize.fromJson(json["product_size"]),
    productColor: ProductColor.fromJson(json["product_color"]),
  );

  Map<String, dynamic> toJson() => {
    "customer_uniq_id": customerUniqId,
    "vendor_uniq_id": vendorUniqId,
    "product_id": productId,
    "product_quantity": productQuantity,
    "_id": id,
    "cart_id": cartId,
    "product_size": productSize.toJson(),
    "product_color": productColor.toJson(),
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

class ProductVariationColor {
  ProductVariationColor({
    required this.colorCode,
    required this.isActive,
  });

  String colorCode;
  bool isActive;

  factory ProductVariationColor.fromJson(Map<String, dynamic> json) => ProductVariationColor(
    colorCode: json["color_code"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "color_code": colorCode,
    "is_active": isActive,
  };
}

class ProductVariationSize {
  ProductVariationSize({
    required this.size,
    required this.mrp,
    required this.sellingPrice,
    required this.isActive,
  });

  String size;
  int mrp;
  int sellingPrice;
  bool isActive;

  factory ProductVariationSize.fromJson(Map<String, dynamic> json) => ProductVariationSize(
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