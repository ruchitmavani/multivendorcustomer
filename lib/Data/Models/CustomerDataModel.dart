class CustomerDataModel {
  CustomerDataModel({
    required this.customerName,
    required this.customerEmailAddress,
    required this.customerMobileNumber,
    required this.customerAddress,
    required this.id,
    required this.customerUniqId,
    required this.createdDateTime,
  });

  String customerName;
  String customerEmailAddress;
  String customerMobileNumber;
  String customerAddress;
  String id;
  String customerUniqId;
  DateTime createdDateTime;

  factory CustomerDataModel.fromJson(Map<String, dynamic> json) => CustomerDataModel(
    customerName: json["customer_name"],
    customerEmailAddress: json["customer_email_address"],
    customerMobileNumber: json["customer_mobile_number"],
    customerAddress: json["customer_address"],
    id: json["_id"],
    customerUniqId: json["customer_uniq_id"],
    createdDateTime: DateTime.parse(json["created_date_time"]),
  );

}
