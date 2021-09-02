

class CartDataModel {
  CartDataModel({
    required this.id,
    required this.customerUniqId,
    required this.productId,
    required this.productQuantity,
    required this.cartId,
    required this.createdDateTime,
    required this.productColor,
    required this.productSize,
    required this.productWeight,
    required this.productDetails,
  });

  String id;
  String customerUniqId;
  String productId;
  int productQuantity;
  String cartId;
  DateTime createdDateTime;
  String productColor;
  String productSize;
  String productWeight;
  List<ProductDetail> productDetails;

  factory CartDataModel.fromJson(Map<String, dynamic> json) => CartDataModel(
    id: json["_id"],
    customerUniqId: json["customer_uniq_id"],
    productId: json["product_id"],
    productQuantity: json["product_quantity"],
    cartId: json["cart_id"],
    createdDateTime: DateTime.parse(json["created_date_time"]),
    productColor: json["product_color"],
    productSize: json["product_size"],
    productWeight: json["product_weight"],
    productDetails: List<ProductDetail>.from(json["product_details"].map((x) => ProductDetail.fromJson(x))),
  );
}

class ProductDetail {
  ProductDetail({
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
    required this.productVariationWeight,
    required this.productTotalRating,
    required this.productRatingCountRecord,
    required this.productRatingAverage,
    required this.createdDateTime,
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
  String taxId;
  int stockLeft;
  String unitType;
  List<String> productLiveTiming;
  String productDescription;
  List<dynamic> productVariationSizes;
  List<dynamic> productVariationColors;
  List<dynamic> productVariationWeight;
  int productTotalRating;
  int productRatingCountRecord;
  int productRatingAverage;
  DateTime createdDateTime;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
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
    taxId: json["tax_id"],
    stockLeft: json["stock_left"],
    unitType: json["unit_type"],
    productLiveTiming: List<String>.from(json["product_live_timing"].map((x) => x)),
    productDescription: json["product_description"],
    productVariationSizes: List<dynamic>.from(json["product_variation_sizes"].map((x) => x)),
    productVariationColors: List<dynamic>.from(json["product_variation_colors"].map((x) => x)),
    productVariationWeight: List<dynamic>.from(json["product_variation_weight"].map((x) => x)),
    productTotalRating: json["product_total_rating"],
    productRatingCountRecord: json["product_rating_count_record"],
    productRatingAverage: json["product_rating_average"],
    createdDateTime: DateTime.parse(json["created_date_time"])
  );
}
