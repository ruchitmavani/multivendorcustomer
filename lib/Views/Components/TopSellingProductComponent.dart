import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';

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
      padding: const EdgeInsets.only(left: 8.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  "https://www.bigbasket.com/media/uploads/p/xxl/263526-2_8-britannia-good-day-cashew-cookies.jpg"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Day Biscuit",
                  style: FontsTheme.boldTextStyle(),
                ),
                Text("Small Pack",
                    style: FontsTheme.descriptionText(
                        fontWeight: FontWeight.w400, size: 13)),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text("₹ 10.00",
                      style: FontsTheme.digitStyle(
                          fontWeight: FontWeight.w400, size: 13)),
                ),
                Space(width: 30),
              ],
            ),
            Space(width: 8),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                  width: 40,
                  height: 25,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              appPrimaryMaterialColor)),
                      onPressed: () {},
                      child: Icon(
                        AppIcons.rightarrow,
                        color: Colors.white,
                        size: 12,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
