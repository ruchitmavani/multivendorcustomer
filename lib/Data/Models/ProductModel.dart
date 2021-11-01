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
    required this.stockLeft,
    required this.unitType,
    required this.productLiveTiming,
    required this.productDescription,
    required this.productVariationSizes,
    required this.productVariationColors,
    required this.productTotalRating,
    required this.productRatingCountRecord,
    required this.productRatingAverage,
    required this.productIsActive,
    required this.categoryIsActive,
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
  double productMrp;
  double productSellingPrice;
  int stockLeft;
  String unitType;
  List<String> productLiveTiming;
  String productDescription;
  List<ProductSize>? productVariationSizes;
  List<ProductColor>? productVariationColors;
  int productTotalRating;
  int productRatingCountRecord;
  double productRatingAverage;
  bool productIsActive;
  bool categoryIsActive;
  List<BulkPriceList>? bulkPriceList;
  bool isRequestPrice;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["_id"],
        vendorUniqId: json["vendor_uniq_id"],
        categoryId: json["category_id"],
        productId: json["product_id"],
        productImageUrl:
            List<String>.from(json["product_image_url"].map((x) => x)),
        productVideoUrl: json["product_video_url"],
        productYoutubeUrl: json["product_youtube_url"],
        isYoutubeUrl: json["is_youtube_url"],
        productName: json["product_name"],
        productMrp: json["product_mrp"],
        productSellingPrice: json["product_selling_price"],
        stockLeft: json["stock_left"],
        unitType: json["unit_type"],
        productLiveTiming:
            List<String>.from(json["product_live_timing"].map((x) => x)),
        productDescription: json["product_description"],
        productVariationSizes: json["product_variation_sizes"] == []
            ? null
            : List<ProductSize>.from(json["product_variation_sizes"]
                .map((x) => ProductSize.fromJson(x))),
        productVariationColors: json["product_variation_colors"] == []
            ? null
            : List<ProductColor>.from(json["product_variation_colors"]
                .map((x) => ProductColor.fromJson(x))),
        productTotalRating: json["product_total_rating"],
        productRatingCountRecord: json["product_rating_count_record"],
        productRatingAverage: json["product_rating_average"].toDouble(),
        productIsActive: json["product_is_active"],
        categoryIsActive: json["category_is_active"],
        bulkPriceList: List<BulkPriceList>.from(json["bulk_price_list"].map((x) => BulkPriceList.fromJson(x))),
        isRequestPrice:
            json["is_request_price"] == null ? null : json["is_request_price"],
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
        "stock_left": stockLeft,
        "unit_type": unitType,
        "product_live_timing":
            List<dynamic>.from(productLiveTiming.map((x) => x)),
        "product_description": productDescription,
        "product_variation_sizes":
            List<dynamic>.from(productVariationSizes!.map((x) => x.toJson())),
        "product_variation_colors":
            List<dynamic>.from(productVariationColors!.map((x) => x.toJson())),
        "product_total_rating": productTotalRating,
        "product_rating_count_record": productRatingCountRecord,
        "product_rating_average": productRatingAverage,
        "product_is_active": productIsActive,
        "category_is_active": categoryIsActive,
        "bulk_price_list": bulkPriceList == null
            ? null
            : List<dynamic>.from(bulkPriceList!.map((x) => x.toJson())),
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
  ProductSize? productSize;
  ProductColor? productColor;

  factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
        customerUniqId: json["customer_uniq_id"],
        vendorUniqId: json["vendor_uniq_id"],
        productId: json["product_id"],
        productQuantity: json["product_quantity"],
        id: json["_id"],
        cartId: json["cart_id"],
        productSize: json["product_size"] == null
            ? null
            : ProductSize.fromJson(json["product_size"]),
        productColor: json["product_color"] == null
            ? null
            : ProductColor.fromJson(json["product_color"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_uniq_id": customerUniqId,
        "vendor_uniq_id": vendorUniqId,
        "product_id": productId,
        "product_quantity": productQuantity,
        "_id": id,
        "cart_id": cartId,
        "product_size": productSize == null ? null : productSize!.toJson(),
        "product_color": productColor == null ? null : productColor!.toJson(),
      };
}

class ProductColor {
  ProductColor({
    required this.colorCode,
    required this.isActive,
  });

  int colorCode;
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
  double mrp;
  double sellingPrice;
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

  factory ProductVariationColor.fromJson(Map<String, dynamic> json) =>
      ProductVariationColor(
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

  factory ProductVariationSize.fromJson(Map<String, dynamic> json) =>
      ProductVariationSize(
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
  });

  bool isTaxEnable;
  String id;
  String taxId;
  String vendorUniqId;
  String taxName;
  int taxPercentage;

  factory TaxDetail.fromJson(Map<String, dynamic> json) => TaxDetail(
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

class BulkPriceList {
  BulkPriceList({
    required this.fromQty,
    required this.toQty,
    required this.pricePerUnit,
  });

  int fromQty;
  int toQty;
  double pricePerUnit;

  factory BulkPriceList.fromJson(Map<String, dynamic> json) => BulkPriceList(
    fromQty: json["fromQty"],
    toQty: json["toQty"],
    pricePerUnit: json["price_per_unit"],
  );

  Map<String, dynamic> toJson() => {
    "fromQty": fromQty,
    "toQty": toQty,
    "price_per_unit": pricePerUnit,
  };
}