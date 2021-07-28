import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';


class TitleViewAll extends StatelessWidget {
    final String? title;
    TitleViewAll({this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${title??""}",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Poppins"),),
          TextButton(onPressed: (){}, child: Text("View all >",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: appPrimaryMaterialColor.shade600),))
        ],
      ),
    );
  }
}
