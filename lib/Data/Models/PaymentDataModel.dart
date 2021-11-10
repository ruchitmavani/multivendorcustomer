// To parse this JSON data, do
//
//     final orderId = orderIdFromJson(jsonString);

import 'dart:convert';

OrderId orderIdFromJson(String str) => OrderId.fromJson(json.decode(str));

String orderIdToJson(OrderId data) => json.encode(data.toJson());

class OrderId {
  OrderId({
    required this.orderId,
  });

  OrderIdClass orderId;

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
    orderId: OrderIdClass.fromJson(json["order_id"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId.toJson(),
  };
}

class OrderIdClass {
  OrderIdClass({
    required this.id,
    required this.entity,
    required this.amount,
    required this.amountPaid,
    required this.amountDue,
    required this.currency,
    required this.receipt,
    required this.offerId,
    required this.status,
    required this.attempts,
    required this.notes,
    required this.createdAt,
  });

  String id;
  String entity;
  int amount;
  int amountPaid;
  int amountDue;
  String currency;
  String receipt;
  dynamic offerId;
  String status;
  int attempts;
  List<dynamic> notes;
  int createdAt;

  factory OrderIdClass.fromJson(Map<String, dynamic> json) => OrderIdClass(
    id: json["id"],
    entity: json["entity"],
    amount: json["amount"],
    amountPaid: json["amount_paid"],
    amountDue: json["amount_due"],
    currency: json["currency"],
    receipt: json["receipt"],
    offerId: json["offer_id"],
    status: json["status"],
    attempts: json["attempts"],
    notes: List<dynamic>.from(json["notes"].map((x) => x)),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "entity": entity,
    "amount": amount,
    "amount_paid": amountPaid,
    "amount_due": amountDue,
    "currency": currency,
    "receipt": receipt,
    "offer_id": offerId,
    "status": status,
    "attempts": attempts,
    "notes": List<dynamic>.from(notes.map((x) => x)),
    "created_at": createdAt,
  };
}
