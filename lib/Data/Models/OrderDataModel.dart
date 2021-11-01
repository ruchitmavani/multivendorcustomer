import 'dart:convert';

import 'ProductModel.dart';

List<OrderDataModel> orderDataModelFromJson(String str) =>
    List<OrderDataModel>.from(
        json.decode(str).map((x) => OrderDataModel.fromJson(x)));

String orderDataModelToJson(List<OrderDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    required this.orderAmount,
    required this.itemTotalAmount,
    required this.deliveryCharges,
    required this.taxAmount,
    required this.taxPercentage,
    required this.couponAmount,
    required this.couponId,
    required this.updatedDeliveryCharges,
    required this.orderId,
    required this.deliveryAddress,
    required this.vendorDetails,
  });

  String id;
  String customerUniqId;
  String vendorUniqId;
  List<OrderItem> orderItems;
  List<String> orderStatus;
  String rejectReason;
  String paymentType;
  String refNo;
  String deliveryApproxTime;
  double paidAmount;
  double refundAmount;
  double orderAmount;
  double itemTotalAmount;
  double deliveryCharges;
  double taxAmount;
  double taxPercentage;
  double couponAmount;
  String couponId;
  int updatedDeliveryCharges;
  String orderId;
  DeliveryAddress deliveryAddress;
  VendorDetails vendorDetails;

  factory OrderDataModel.fromJson(Map<String, dynamic> json) => OrderDataModel(
        id: json["_id"],
        customerUniqId: json["customer_uniq_id"],
        vendorUniqId: json["vendor_uniq_id"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        orderStatus: List<String>.from(json["order_status"].map((x) => x)),
        rejectReason: json["reject_reason"],
        paymentType: json["payment_type"],
        refNo: json["ref_no"],
        deliveryApproxTime: json["delivery_approx_time"],
        paidAmount: json["paid_amount"],
        refundAmount: json["refund_amount"],
        orderAmount: json["order_amount"],
        itemTotalAmount: json["item_total_amount"],
        deliveryCharges: json["delivery_charges"],
        taxAmount: json["tax_amount"],
        taxPercentage: json["tax_percentage"],
        couponAmount: json["coupon_amount"],
        couponId: json["coupon_id"],
        updatedDeliveryCharges: json["updated_delivery_charges"],
        orderId: json["order_id"],
        deliveryAddress: DeliveryAddress.fromJson(json["delivery_address"]),
        vendorDetails: VendorDetails.fromJson(json["vendor_details"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customer_uniq_id": customerUniqId,
        "vendor_uniq_id": vendorUniqId,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "order_status": List<dynamic>.from(orderStatus.map((x) => x)),
        "reject_reason": rejectReason,
        "payment_type": paymentType,
        "ref_no": refNo,
        "delivery_approx_time": deliveryApproxTime,
        "paid_amount": paidAmount,
        "refund_amount": refundAmount,
        "final_paid_amount": orderAmount,
        "item_total_amount": itemTotalAmount,
        "delivery_charges": deliveryCharges,
        "tax_amount": taxAmount,
        "tax_percentage": taxPercentage,
        "coupon_amount": couponAmount,
        "coupon_id": couponId,
        "updated_delivery_charges": updatedDeliveryCharges,
        "order_id": orderId,
        "delivery_address": deliveryAddress.toJson(),
        "vendor_details": vendorDetails.toJson(),
      };
}

class DeliveryAddress {
  DeliveryAddress({
    required this.type,
    required this.subAddress,
    required this.area,
    required this.city,
    required this.pincode,
  });

  String type;
  String subAddress;
  String area;
  String city;
  int pincode;

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        type: json["type"],
        subAddress: json["subAddress"],
        area: json["area"],
        city: json["city"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "subAddress": subAddress,
        "area": area,
        "city": city,
        "pincode": pincode,
      };
}

class OrderItem {
  OrderItem({
    required this.productId,
    required this.productSize,
    required this.productColor,
    required this.productQuantity,
    required this.productDetails,
    required this.isReject,
    required this.updatedQuantity,
  });

  String productId;
  ProductSize? productSize;
  ProductColor? productColor;
  int productQuantity;
  ProductDetails productDetails;
  bool? isReject;
  int? updatedQuantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"],
        productSize: json["product_size"] == null
            ? null
            : ProductSize.fromJson(json["product_size"]),
        productColor: json["product_color"] == null
            ? null
            : ProductColor.fromJson(json["product_color"]),
        productQuantity: json["product_quantity"],
        productDetails: ProductDetails.fromJson(json["product_details"]),
        isReject: json["is_reject"],
        updatedQuantity:
            json["updated_quantity"] == null ? null : json["updated_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_size": productSize == null ? null : productSize!.toJson(),
        "product_color": productColor == null ? null : productColor!.toJson(),
        "product_quantity": productQuantity,
        "product_details": productDetails.toJson(),
        "is_reject": isReject,
        "updated_quantity": updatedQuantity == null ? null : updatedQuantity,
      };
}

class ProductDetails {
  ProductDetails(
      {required this.vendorUniqId,
      required this.categoryId,
      required this.productId,
      required this.productImageUrl,
      required this.productVideoUrl,
      required this.productYoutubeUrl,
      required this.isYoutubeUrl,
      required this.productName,
      required this.productMrp,
      required this.productSellingPrice,
      required this.bulkPriceList,
      required this.isRequestPrice,
      required this.stockLeft,
      required this.unitType,
      required this.productLiveTiming,
      required this.productDescription,
      required this.productVariationSizes,
      required this.productVariationColors,
      required this.productTotalRating,
      required this.productRatingCountRecord,
      required this.productRatingAverage,
      required this.categoryIsActive,
      required this.productIsActive,
      required this.orderedQuantity,
      required this.id});

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
  List<BulkPriceList> bulkPriceList;
  bool isRequestPrice;
  int stockLeft;
  String unitType;
  List<String> productLiveTiming;
  String productDescription;
  List<ProductSize> productVariationSizes;
  List<ProductColor> productVariationColors;
  int productTotalRating;
  int productRatingCountRecord;
  double productRatingAverage;
  bool categoryIsActive;
  bool productIsActive;
  int orderedQuantity;
  String id;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
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
        bulkPriceList: List<BulkPriceList>.from(
            json["bulk_price_list"].map((x) => BulkPriceList.fromJson(x))),
        isRequestPrice: json["is_request_price"],
        stockLeft: json["stock_left"],
        unitType: json["unit_type"],
        productLiveTiming:
            List<String>.from(json["product_live_timing"].map((x) => x)),
        productDescription: json["product_description"],
        productVariationSizes: List<ProductSize>.from(
            json["product_variation_sizes"]
                .map((x) => ProductSize.fromJson(x))),
        productVariationColors: List<ProductColor>.from(
            json["product_variation_colors"]
                .map((x) => ProductColor.fromJson(x))),
        productTotalRating: json["product_total_rating"],
        productRatingCountRecord: json["product_rating_count_record"],
        productRatingAverage: json["product_rating_average"],
        categoryIsActive: json["category_is_active"],
        productIsActive: json["product_is_active"],
        orderedQuantity: json["ordered_quantity"],
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
        "bulk_price_list":
            List<dynamic>.from(bulkPriceList.map((x) => x.toJson())),
        "is_request_price": isRequestPrice,
        "stock_left": stockLeft,
        "unit_type": unitType,
        "product_live_timing":
            List<dynamic>.from(productLiveTiming.map((x) => x)),
        "product_description": productDescription,
        "product_variation_sizes":
            List<dynamic>.from(productVariationSizes.map((x) => x.toJson())),
        "product_variation_colors":
            List<dynamic>.from(productVariationColors.map((x) => x.toJson())),
        "product_total_rating": productTotalRating,
        "product_rating_count_record": productRatingCountRecord,
        "product_rating_average": productRatingAverage,
        "category_is_active": categoryIsActive,
        "product_is_active": productIsActive,
        "ordered_quantity": orderedQuantity,
        "_id": id,
      };
}

class TaxId {
  TaxId(
      {required this.isTaxEnable,
      required this.id,
      required this.taxId,
      required this.vendorUniqId,
      required this.taxName,
      required this.taxPercentage});

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
  VendorDetails(
      {required this.vendorUniqId,
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
      required this.deliveryCharges,
      required this.freeDeliveryAboveAmount,
      required this.isStorePickupEnable,
      required this.isWhatsappChatSupport,
      required this.colorTheme,
      required this.taxDetails});

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
  List awordImageUrl;
  String address;
  String aboutBusiness;
  List<BusinessHour> businessHours;
  int profileCompletedPercentage;
  List<String> profilePercentageCount;
  DateTime createdDateTime;
  bool isOnline;
  bool isDeliveryCharges;
  double deliveryCharges;
  double freeDeliveryAboveAmount;
  bool isStorePickupEnable;
  bool isWhatsappChatSupport;
  String colorTheme;
  List<TaxDetail> taxDetails;

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
        coverImageUrl:
            json["cover_image_url"] == null ? null : json["cover_image_url"],
        awordImageUrl:
            json["aword_image_url"] == null ? null : json["aword_image_url"],
        address: json["address"],
        aboutBusiness: json["about_business"],
        businessHours: List<BusinessHour>.from(
            json["business_hours"].map((x) => BusinessHour.fromJson(x))),
        profileCompletedPercentage: json["profile_completed_percentage"],
        profilePercentageCount:
            List<String>.from(json["profile_percentage_count"].map((x) => x)),
        createdDateTime: DateTime.parse(json["created_date_time"]),
        isOnline: json["is_online"],
        isDeliveryCharges: json["is_delivery_charges"],
        deliveryCharges: json["delivery_charges"],
        freeDeliveryAboveAmount: json["free_delivery_above_amount"],
        isStorePickupEnable: json["is_store_pickup_enable"],
        isWhatsappChatSupport: json["is_whatsapp_chat_support"],
        colorTheme: json["color_theme"],
        taxDetails: List<TaxDetail>.from(
            json["tax_details"].map((x) => TaxDetail.fromJson(x))),
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
        "cover_image_url": coverImageUrl == null ? {} : coverImageUrl,
        "aword_image_url": awordImageUrl == null
            ? {}
            : List<dynamic>.from(awordImageUrl.map((x) => x)),
        "address": address,
        "about_business": aboutBusiness,
        "business_hours":
            List<dynamic>.from(businessHours.map((x) => x.toJson())),
        "profile_completed_percentage": profileCompletedPercentage,
        "profile_percentage_count":
            List<dynamic>.from(profilePercentageCount.map((x) => x)),
        "created_date_time": createdDateTime.toIso8601String(),
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

// add Order Model

List<AddOrder> addOrderFromJson(String str) =>
    List<AddOrder>.from(json.decode(str).map((x) => AddOrder.fromJson(x)));

String addOrderToJson(List<AddOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddOrder {
  AddOrder({
    required this.productId,
    this.productSize,
    this.productColor,
    required this.productQuantity,
  });

  String productId;
  ProductSize? productSize;
  ProductColor? productColor;
  int productQuantity;

  factory AddOrder.fromJson(Map<String, dynamic> json) => AddOrder(
        productId: json["product_id"],
        productSize: json["product_size"] == null
            ? null
            : ProductSize.fromJson(json["product_size"]),
        productColor: json["product_color"] == null
            ? null
            : ProductColor.fromJson(json["product_color"]),
        productQuantity: json["product_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_size": productSize == null ? {} : productSize!.toJson(),
        "product_color": productColor == null ? {} : productColor!.toJson(),
        "product_quantity": productQuantity,
      };
}
