import 'dart:convert';

OrderId orderIdFromJson(String str) => OrderId.fromJson(json.decode(str));

String orderIdToJson(OrderId data) => json.encode(data.toJson());

class OrderId {
  OrderId({
    required this.orderId,
  });

  String orderId;

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
  };
}
