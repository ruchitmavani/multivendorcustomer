import 'dart:convert';

List<OrderDataModel> orderDataModelFromJson(String str) => List<OrderDataModel>.from(json.decode(str).map((x) => OrderDataModel.fromJson(x)));

String orderDataModelToJson(List<OrderDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDataModel {
  OrderDataModel({
    required this.id,
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
    required this.orderId,
    required this.vendorDetails,
  });

  String id;
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
  String orderId;
  VendorDetails vendorDetails;

  factory OrderDataModel.fromJson(Map<String, dynamic> json) => OrderDataModel(
    id: json["_id"],
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
    orderId: json["order_id"],
    vendorDetails: VendorDetails.fromJson(json["vendor_details"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
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
    "order_id": orderId,
    "vendor_details": vendorDetails.toJson(),
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
    required this.productIsActive,
    required this.categoryIsActive,
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
  double productRatingAverage;
  bool productIsActive;
  bool categoryIsActive;

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
    productIsActive: json["product_is_active"],
    categoryIsActive: json["category_is_active"],
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
    "product_is_active": productIsActive,
    "category_is_active": categoryIsActive,
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

class VendorDetails {
  VendorDetails({
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
  List<BusinessHour> businessHours;
  int profileCompletedPercentage;
  List<String> profilePercentageCount;
  DateTime createdDateTime;
  bool isOnline;
  bool isDeliveryCharges;
  bool isStorePickupEnable;
  bool isWhatsappChatSupport;
  String colorTheme;

  factory VendorDetails.fromJson(Map<String, dynamic> json) => VendorDetails(
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
    "business_hours": List<dynamic>.from(businessHours.map((x) => x.toJson())),
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

class BusinessHour {
  BusinessHour({
    required this.day,
    required this.openTime,
    required this.closeTime,
    required this.isOpen,
  });

  String day;
  String openTime;
  String closeTime;
  bool isOpen;

  factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
    day: json["day"],
    openTime: json["openTime"],
    closeTime: json["closeTime"],
    isOpen: json["isOpen"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "openTime": openTime,
    "closeTime": closeTime,
    "isOpen": isOpen,
  };
}