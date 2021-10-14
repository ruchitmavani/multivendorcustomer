import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class TitleViewAll extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final bool isViewAll;
  TitleViewAll({this.title, this.onPressed,required this.isViewAll});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${title ?? ""}", style: FontsTheme.boldTextStyle(size: 15)),
          if (isViewAll) TextButton(
              onPressed: onPressed,
              child: Text(
                "View all >",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Provider.of<CustomColor>(context).appPrimaryMaterialColor),
              ))],
      ),
    );
  }
}
