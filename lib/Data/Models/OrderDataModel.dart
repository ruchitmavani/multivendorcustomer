import 'dart:convert';

List<OrderDataModel> orderDataModelFromJson(String str) => List<OrderDataModel>.from(json.decode(str).map((x) => OrderDataModel.fromJson(x)));

String orderDataModelToJson(List<OrderDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDataModel {
  OrderDataModel({
    required this.customerUniqId,
    required this.vendorUniqId,
    required this.orderItems,
    required this.orderStatus,
    required this.rejectReason,
    required this.paymentType,
    required this.refNo,
    required this.deliveryApproxTime,
    required this.paidAmount,
    required this.refundAmount,
    required this.finalPaidAmount,
    required this.itemTotalAmount,
    required this.deliveryCharges,
    required this.taxAmount,
    required this.couponAmount,
    required this.id,
    required this.orderId,
  });

  String customerUniqId;
  String vendorUniqId;
  List<OrderItem> orderItems;
  String orderStatus;
  String rejectReason;
  String paymentType;
  String refNo;
  String deliveryApproxTime;
  int paidAmount;
  int refundAmount;
  int finalPaidAmount;
  int itemTotalAmount;
  int deliveryCharges;
  int taxAmount;
  int couponAmount;
  String id;
  String orderId;

  factory OrderDataModel.fromJson(Map<String, dynamic> json) => OrderDataModel(
    customerUniqId: json["customer_uniq_id"],
    vendorUniqId: json["vendor_uniq_id"],
    orderItems: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
    orderStatus: json["order_status"],
    rejectReason: json["reject_reason"],
    paymentType: json["payment_type"],
    refNo: json["ref_no"],
    deliveryApproxTime: json["delivery_approx_time"],
    paidAmount: json["paid_amount"],
    refundAmount: json["refund_amount"],
    finalPaidAmount: json["final_paid_amount"],
    itemTotalAmount: json["item_total_amount"],
    deliveryCharges: json["delivery_charges"],
    taxAmount: json["tax_amount"],
    couponAmount: json["coupon_amount"],
    id: json["_id"],
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_uniq_id": customerUniqId,
    "vendor_uniq_id": vendorUniqId,
    "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
    "order_status": orderStatus,
    "reject_reason": rejectReason,
    "payment_type": paymentType,
    "ref_no": refNo,
    "delivery_approx_time": deliveryApproxTime,
    "paid_amount": paidAmount,
    "refund_amount": refundAmount,
    "final_paid_amount": finalPaidAmount,
    "item_total_amount": itemTotalAmount,
    "delivery_charges": deliveryCharges,
    "tax_amount": taxAmount,
    "coupon_amount": couponAmount,
    "_id": id,
    "order_id": orderId,
  };
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.customerUniqId,
    required this.vendorUniqId,
    required this.productId,
    required this.productQuantity,
    required this.cartId,
    required this.productSize,
    required this.productColor,
    required this.productDetails,
  });

  String id;
  String customerUniqId;
  String vendorUniqId;
  String productId;
  int productQuantity;
  String cartId;
  ProductSize productSize;
  ProductColor productColor;
  ProductDetails productDetails;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["_id"],
    customerUniqId: json["customer_uniq_id"],
    vendorUniqId: json["vendor_uniq_id"],
    productId: json["product_id"],
    productQuantity: json["product_quantity"],
    cartId: json["cart_id"],
    productSize: ProductSize.fromJson(json["product_size"]),
    productColor: ProductColor.fromJson(json["product_color"]),
    productDetails: ProductDetails.fromJson(json["product_details"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customer_uniq_id": customerUniqId,
    "vendor_uniq_id": vendorUniqId,
    "product_id": productId,
    "product_quantity": productQuantity,
    "cart_id": cartId,
    "product_size": productSize.toJson(),
    "product_color": productColor.toJson(),
    "product_details": productDetails.toJson(),
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

class ProductDetails {
  ProductDetails({
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
  int orderedQuantity;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
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
    orderedQuantity: json["ordered_quantity"],
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
    "ordered_quantity": orderedQuantity,
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
