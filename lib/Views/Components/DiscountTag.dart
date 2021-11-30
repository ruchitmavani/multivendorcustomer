import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class DiscountTag extends StatelessWidget {
  double mrp;
  double selling;

  DiscountTag({Key? key, required this.mrp, required this.selling})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mrp!=selling?Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2,right:4,left: 4,bottom: 2),
        child: Text("${100-(selling/mrp*100).round()}% off",style: TextStyle(fontFamily: 'Poppins',fontSize: 10,color: Colors.white),),
      ),
    ):SizedBox();
  }
}
