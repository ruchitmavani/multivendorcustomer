import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';

class TitleViewAll extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  TitleViewAll({this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${title ?? ""}", style: FontsTheme.boldTextStyle(size: 15)),
          TextButton(
              onPressed: onPressed,
              child: Text(
                "View all >",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: appPrimaryMaterialColor),
              ))
        ],
      ),
    );
  }
}
