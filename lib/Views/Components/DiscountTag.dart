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
    return Container(
      height: 20,
      width: 40,
      decoration: BoxDecoration(
        color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 4),
        child: Text("${selling / mrp * 100}% off",style: TextStyle(fontFamily: 'Poppins',fontSize: 10),),
      ),
    );
  }
}
