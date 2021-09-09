class Address {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          subAddress == other.subAddress &&
          type == other.type &&
          area == other.area &&
          city == other.city &&
          pinCode == other.pinCode;

  @override
  int get hashCode => subAddress.hashCode;
}

List<Address> addressList = [

];
