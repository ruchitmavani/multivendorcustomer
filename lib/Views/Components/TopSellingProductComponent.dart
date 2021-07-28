import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';

class TopSellingProductComponent extends StatefulWidget {
  @override
  _TopSellingProductComponentState createState() =>
      _TopSellingProductComponentState();
}

class _TopSellingProductComponentState
    extends State<TopSellingProductComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top:15.0,left: 24.0,right: 24.0,bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  "https://www.bigbasket.com/media/uploads/p/xxl/263526-2_8-britannia-good-day-cashew-cookies.jpg"),
              Space(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Day Biscuit",
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 13),
                  ),
                  Text(
                    "Small Pack",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.grey)),
                  Text(
                      "₹ 10.00",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.grey)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
