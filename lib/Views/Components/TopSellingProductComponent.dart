// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';

import '../ProductDetail.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 2),
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
                "${StringConstants.API_URL}${widget.productData.productImageUrl.first}",
                width: 60,
                alignment: Alignment.center,

              ),
            ),
            Space(
              width: 4,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.productData.productName}",
                  style: FontsTheme.boldTextStyle(),
                ),
                ProductRating(widget.productData.productRatingAverage),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text("₹ ${widget.productData.productSellingPrice}",
                      style: FontsTheme.digitStyle(
                          fontWeight: FontWeight.w400, size: 13)),
                ),

              ],
            ),
            Space(width: 8),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        appPrimaryMaterialColor)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15.0, bottom: 15.0),
                              child: SizedBox(
                                child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.close, size: 16),
                                    backgroundColor: Colors.white),
                                width: 24,
                                height: 24,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0)),
                              ),
                              child: ProductDescription(widget.productData),
                            ),
                          ],
                        );
                      });
                },
                child: Icon(
                  AppIcons.rightarrow,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
