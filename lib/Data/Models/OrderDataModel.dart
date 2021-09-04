import 'dart:convert';

OrderDataModel orderDataModelFromJson(String str) => OrderDataModel.fromJson(json.decode(str));

String orderDataModelToJson(OrderDataModel data) => json.encode(data.toJson());

class OrderDataModel {
  OrderDataModel({
    required this.customerUniqId,
    required this.vendorUniqId,
    required this.orderItems,
    required this.orderStatus,
    required this.paymentType,
    required this.refNo,
    required this.deliveryApproxTime,
    required this.id,
    required this.orderId,
  });

  String customerUniqId;
  String vendorUniqId;
  List<OrderItem> orderItems;
  String orderStatus;
  String paymentType;
  String refNo;
  dynamic deliveryApproxTime;
  String id;
  String orderId;

  factory OrderDataModel.fromJson(Map<String, dynamic> json) => OrderDataModel(
    customerUniqId: json["customer_uniq_id"],
    vendorUniqId: json["vendor_uniq_id"],
    orderItems: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
    orderStatus: json["order_status"],
    paymentType: json["payment_type"],
    refNo: json["ref_no"],
    deliveryApproxTime: json["delivery_approx_time"],
    id: json["_id"],
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_uniq_id": customerUniqId,
    "vendor_uniq_id": vendorUniqId,
    "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
    "order_status": orderStatus,
    "payment_type": paymentType,
    "ref_no": refNo,
    "delivery_approx_time": deliveryApproxTime,
    "_id": id,
    "order_id": orderId,
  };
}

class OrderItem {
  OrderItem({
    required this.customerUniqId,
    required this.vendorUniqId,
    required this.productId,
    required this.productQuantity,
    required this.productSize,
    required this.productColor,
    required this.productWeight,
    required this.id,
    required this.cartId,
  });

  String customerUniqId;
  String vendorUniqId;
  String productId;
  int productQuantity;
  String productSize;
  String productColor;
  String productWeight;
  String id;
  String cartId;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    customerUniqId: json["customer_uniq_id"],
    vendorUniqId: json["vendor_uniq_id"],
    productId: json["product_id"],
    productQuantity: json["product_quantity"],
    productSize: json["product_size"],
    productColor: json["product_color"],
    productWeight: json["product_weight"],
    id: json["_id"],
    cartId: json["cart_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_uniq_id": customerUniqId,
    "vendor_uniq_id": vendorUniqId,
    "product_id": productId,
    "product_quantity": productQuantity,
    "product_size": productSize,
    "product_color": productColor,
    "product_weight": productWeight,
    "_id": id,
    "cart_id": cartId,
  };
}
