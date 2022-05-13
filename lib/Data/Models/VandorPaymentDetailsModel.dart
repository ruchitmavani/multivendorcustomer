
class PaymentDetailsModel {
  PaymentDetailsModel({
    required this.vendorPaymentId,
    required this.name,
    required this.email,
    required this.id,
    required this.vendorUniqId,
    this.bank,
    required this.phone,
    required this.createdDateTime,
    this.upi,
  });

  String vendorPaymentId;
  String name;
  String email;
  String id;
  String vendorUniqId;
  Bank? bank;
  String phone;
  DateTime createdDateTime;
  Upi? upi;

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) => PaymentDetailsModel(
    vendorPaymentId: json["vendor_payment_id"],
    name: json["name"],
    email: json["email"],
    id: json["_id"],
    vendorUniqId: json["vendor_uniq_id"],
    bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
    phone: json["phone"],
    createdDateTime: DateTime.parse(json["created_date_time"]),
    upi: json["upi"] == null ? null : Upi.fromJson(json["upi"]),
  );

  Map<String, dynamic> toJson() => {
    "vendor_payment_id": vendorPaymentId,
    "name": name,
    "email": email,
    "_id": id,
    "vendor_uniq_id": vendorUniqId,
    "bank": bank == null ? null : bank?.toJson(),
    "phone": phone,
    "created_date_time": createdDateTime.toIso8601String(),
    "upi": upi == null ? null : upi?.toJson(),
  };
}

class Bank {
  Bank({
    required this.accountNumber,
    required this.accountHolder,
    required this.ifsc,
  });

  String accountNumber;
  String accountHolder;
  String ifsc;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    accountNumber: json["accountNumber"],
    accountHolder: json["accountHolder"],
    ifsc: json["ifsc"],
  );

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "accountHolder": accountHolder,
    "ifsc": ifsc,
  };
}

class Upi {
  Upi({
    required this.vpa,
    required this.accountHolder,
  });

  String vpa;
  String accountHolder;

  factory Upi.fromJson(Map<String, dynamic> json) => Upi(
    vpa: json["vpa"],
    accountHolder: json["accountHolder"],
  );

  Map<String, dynamic> toJson() => {
    "vpa": vpa,
    "accountHolder": accountHolder,
  };
}
