// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';
import 'package:provider/provider.dart';

class ProductComponentGrid extends StatefulWidget {
  ProductData productData;

  ProductComponentGrid({required this.productData});

  @override
  _ProductComponentGridState createState() => _ProductComponentGridState();
}

class _ProductComponentGridState extends State<ProductComponentGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        width: 200,
        height: 254,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 8.0, bottom: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductRating(widget.productData.productRatingAverage),
                Center(
                    child: SizedBox(
                  height: 119,
                  width: 100,
                  child: widget.productData.productImageUrl.length > 0
                      ? Image.network(StringConstants.api_url +
                          widget.productData.productImageUrl.first)
                      : Image.asset("images/placeholder.png"),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "${widget.productData.productName}",
                    style: FontsTheme.subTitleStyle(),
                  ),
                ),
                Text(
                  "${widget.productData.productDescription}",
                  style: FontsTheme.descriptionText(
                      size: 11, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\u{20B9} ${widget.productData.productMrp}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 3,
                                decorationColor:
                                    Provider.of<CustomColor>(context)
                                        .appPrimaryMaterialColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 11),
                          ),
                          Row(
                            children: [
                              Text(
                                "\u{20B9}",
                                style: TextStyle(
                                    fontFamily: "",
                                    fontSize: 12,
                                    color: Colors.black87),
                              ),
                              Text(
                                "${widget.productData.productSellingPrice}",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black87,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                      if (!widget.productData.isRequestPrice)
                        widget.productData.bulkPriceList!.length == 0
                            ? widget.productData.stockLeft <= 0
                                ? Text(
                                    "Out of Stock",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        color: Colors.red),
                                  )
                                : AddRemoveButton(
                                    productData: widget.productData,
                                    isRounded: true,
                                    colorIndex: 0,
                                    sizeIndex: 0,
                                  )
                            : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductComponentList extends StatefulWidget {
  ProductData productData;

  ProductComponentList({required this.productData});

  @override
  _ProductComponentListState createState() => _ProductComponentListState();
}

class _ProductComponentListState extends State<ProductComponentList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        height: 110,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 110,
              width: MediaQuery.of(context).size.width * 0.2,
              child: widget.productData.productImageUrl.length > 0
                  ? Image.network(StringConstants.api_url +
                      widget.productData.productImageUrl.first)
                  : Image.asset("images/placeholder.png"),
            ),
            Space(width: 8),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.productData.productName}",
                        style: TextStyle(
                            fontSize: 13,
                            color: Provider.of<CustomColor>(context)
                                .appPrimaryMaterialColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: ProductRating(
                            widget.productData.productRatingAverage),
                      )
                    ],
                  ),
                  Text(
                    "${widget.productData.productDescription}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: Colors.grey.shade400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Space(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\u{20B9} ${widget.productData.productMrp}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 3,
                                decorationColor:
                                    Provider.of<CustomColor>(context)
                                        .appPrimaryMaterialColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 11),
                          ),
                          Text(
                            "\u{20B9} ${widget.productData.productSellingPrice}",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black87,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      if (!widget.productData.isRequestPrice)
                        widget.productData.bulkPriceList!.length == 0
                            ? widget.productData.stockLeft <= 0
                                ? Text(
                                    "Out of Stock",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        color: Colors.red),
                                  )
                                : AddRemoveButton(
                                    productData: widget.productData,
                                    isRounded: true,
                                    colorIndex: 0,
                                    sizeIndex: 0,
                                  )
                            : Container(),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
