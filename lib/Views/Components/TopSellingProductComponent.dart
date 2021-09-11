import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';

class TopSellingProductComponent extends StatefulWidget {
  ProductData productData;
  TopSellingProductComponent({required this.productData});
  @override
  _TopSellingProductComponentState createState() =>
      _TopSellingProductComponentState();
}

class _TopSellingProductComponentState
    extends State<TopSellingProductComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right:4),
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
                  "${StringConstants.API_URL}${widget.productData.productImageUrl.first}",width: 60,),
            ),
            Space(width: 4,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.productData.productName}",
                  style: FontsTheme.boldTextStyle(),
                ),
                ProductRating(
                  widget.productData.productRatingAverage
                ),
                // SizedBox(
                //   width: 70,
                //   child: Text("${widget.productData.productDescription}",
                //       overflow: TextOverflow.ellipsis,
                //       maxLines: 1,
                //       style: FontsTheme.descriptionText(
                //           fontWeight: FontWeight.w400, size: 13)),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text("₹ ${widget.productData.productSellingPrice}",
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
