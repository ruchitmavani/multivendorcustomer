import 'package:equatable/equatable.dart';

class Address extends Equatable {
  String type;
  String subAddress;
  String city;
  String area;
  int pinCode;

  Address(
      {required this.type,
      required this.subAddress,
      required this.area,
      required this.city,
      required this.pinCode});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        type: json["type"],
        subAddress: json["subAddress"],
        area: json["area"],
        city: json["city"],
        pinCode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "subAddress": subAddress,
        "area": area,
        "city": city,
        "pincode": pinCode,
      };

  @override
  List<Object?> get props => [type, subAddress, area, city, pinCode];
}


List<Address> addressList = [];
