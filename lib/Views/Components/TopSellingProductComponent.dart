// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';
import 'package:provider/provider.dart';

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
    return InkWell(
      onTap: () {
        context.go(helper(
            PageCollection.product + '/${widget.productData.productId}'));
      },
      child: SizedBox(
        width: 260,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
                child: widget.productData.productImageUrl.length != 0
                    ? Container(
                        height: 62,
                        width: 62,
                        child: Image.network(
                          "${StringConstants.api_url}${widget.productData.productImageUrl.first}",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Image.asset(
                        "images/placeholder.png",
                        height: 60,
                      ),
              ),
              Space(
                width: 4,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.productData.productName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: FontsTheme.subTitleStyle(),
                      ),
                      Text(
                        "₹ ${widget.productData.productSellingPrice}",
                        style: FontsTheme.digitStyle(fontSize: 12),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: (widget.productData.productRatingAverage != 0)
                            ? ProductRating(
                                widget.productData.productRatingAverage)
                            : SizedBox(
                                height: 16,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Space(width: 5),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 35,
                  child: InkWell(
                    onTap: () {
                      context.go(helper(PageCollection.product +
                          '/${widget.productData.productId}'));
                    },
                    child: Card(
                      color: Provider.of<CustomColor>(context)
                          .appPrimaryMaterialColor,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 6),
                        child: Icon(
                          AppIcons.rightarrow,
                          color: Colors.white,
                          size: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
