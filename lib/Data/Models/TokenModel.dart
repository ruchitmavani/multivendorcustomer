class TokenModel {
  TokenModel({
    required this.status,
    required this.message,
    required this.cftoken,
    required this.orderId,
  });

  String orderId;
  String status;
  String message;
  String cftoken;

  factory TokenModel.fromJson(Map<String, dynamic> json,String orderId) => TokenModel(
    orderId: orderId,
    status: json["status"],
    message: json["message"],
    cftoken: json["cftoken"],
  );

  Map<String, dynamic> toJson() => {
    "orderId":orderId,
    "status": status,
    "message": message,
    "cftoken": cftoken,
  };
}
