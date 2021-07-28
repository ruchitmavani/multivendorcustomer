import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';

class ProductComponent extends StatefulWidget {

  @override
  _ProductComponentState createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Space(
              height: 10,
            ),
            Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSconyIURv53DHyBsl9qbKIsVBnMPohsi-0pBQgms3AQKtNHkj1-Ab-gvPBZRdSpHcTrcw&usqp=CAU",width: 100),
            Space(
              height: 8,
            ),
            Column(
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
                    "₹ 450.00",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10,color:appPrimaryMaterialColor,decoration: TextDecoration.lineThrough)),
                Text(
                    "₹ 250.00",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black87)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
