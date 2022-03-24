import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class UpdatedLabel extends StatelessWidget {
  const UpdatedLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 16,
      width: 53,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Provider.of<ThemeColorProvider>(context).appPrimaryMaterialColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
        child: Text(
          "UPDATED",
          style: TextStyle(color: Colors.white, fontSize: 10,fontFamily: 'Poppins',fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}


class RejectedLabel extends StatelessWidget {
  const RejectedLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 16,
      width: 53,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Provider.of<ThemeColorProvider>(context).appPrimaryMaterialColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 2),
        child: Text(
          "REJECTED",
          style: TextStyle(color: Colors.white, fontSize: 10,fontFamily: 'Poppins',fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}