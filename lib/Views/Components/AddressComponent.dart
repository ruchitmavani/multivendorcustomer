import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Data/Models/AddressModel.dart';

class AddressComponent extends StatelessWidget {
  const AddressComponent({
    Key? key,
    required this.addressType,
    required this.address,
  }) : super(key: key);

  final String addressType;
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (addressType == "Home") Icon(Icons.home, color: Colors.grey),
        if (addressType == "Work")
          Icon(
            Icons.work,
            color: Colors.grey,
          ),
        if (addressType != "Work" && addressType != "Home")
          Icon(
            Icons.location_on,
            color: Colors.grey,
          ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " $addressType",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${address.subAddress}, ${address.area}, ${address.city}, ${address.pinCode}",
                style: TextStyle(fontSize: 12, color: Color(0xff383838)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
