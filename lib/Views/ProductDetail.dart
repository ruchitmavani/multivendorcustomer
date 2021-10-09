// ignore_for_file: must_be_immutable

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDescription extends StatefulWidget {
  String productId;

  ProductDescription({required this.productId});

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  late ProductData productData;
  List<ProductColor> colorList = [];
  List<ProductSize> sizeList = [];
  int currentIndex = 0;
  int currentSizeIndex = 0;
  int displayImage = 0;
  int finalPrice = 0;
  int finalColor = 0;
  bool isLoading = false;

  _loadData() async {
    setState(() {
      isLoading = true;
    });
    await ProductController.findProduct(productId: "${widget.productId}").then(
        (value) {
      if (value.success) {
        setState(() {
          isLoading = false;
          productData = value.data!;
          print(window.location.href);
          if (productData.productVariationColors!.length != 0) {
            colorList = productData.productVariationColors!;
          }
          if (productData.productVariationSizes!.length != 0) {
            sizeList = productData.productVariationSizes!;
          }
          finalPrice = productData.productSellingPrice;
          if (productData.productVariationColors!.length != 0) {
            finalColor =
                int.parse(productData.productVariationColors!.first.colorCode);
          }
          ;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(isLoading ? "" : "${productData.productName}"),
      ),
      body: isLoading
          ? Center(
            child: CircularProgressIndicator(
            ),
          )
          : SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: ListView(
                        children: [
                          Space(
                            height: 20,
                          ),
                          productData.productImageUrl.length==0?SizedBox():SizedBox(
                              height: 230,
                              child: Image.network(
                                  "${StringConstants.API_URL + productData.productImageUrl.elementAt(displayImage)}")),
                          Space(height: 20),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: productData.productImageUrl.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.only(right: 6),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    width: 50,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            displayImage = index;
                                          });
                                        },
                                        child: Image.network(
                                            "${StringConstants.API_URL + productData.productImageUrl.elementAt(index)}"),
                                      ),
                                    ));
                              },
                            ),
                          ),
                          Space(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${productData.productName}",
                                          style: FontsTheme.boldTextStyle(
                                              size: 16)),
                                      Space(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.amber, size: 18),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                                "${productData.productRatingAverage}",
                                                style: FontsTheme.valueStyle(
                                                    size: 11,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )
                                        ],
                                      ),
                                      Space(height: 8),
                                      Text("${productData.productDescription}",
                                          style: FontsTheme.descriptionText(),
                                          textAlign: TextAlign.justify),

                                      // Color Option

                                      Space(height: 20),
                                      if (productData
                                              .productVariationColors!.length !=
                                          0)
                                        Text(
                                          "Color option",
                                          style: FontsTheme.subTitleStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                              size: 13),
                                        ),
                                      Space(height: 8),
                                      Row(
                                        children: colorList.map<Widget>((e) {
                                          int index = colorList.indexOf(e);
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                currentIndex = index;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                decoration: currentIndex ==
                                                        index
                                                    ? BoxDecoration(
                                                        border: Border.all(
                                                            width: 2,
                                                            color: Provider.of<
                                                                        CustomColor>(
                                                                    context)
                                                                .appPrimaryMaterialColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0))
                                                    : null,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      child: Container(
                                                          color: Color(
                                                              int.parse(
                                                                  e.colorCode)),
                                                          height: 25,
                                                          width: 25)),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      // Size Option
                                      Space(height: 18),
                                      if (productData
                                              .productVariationSizes!.length !=
                                          0)
                                        Text("Size Option",
                                            style: FontsTheme.subTitleStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                size: 13)),
                                      Space(height: 8),
                                      Row(
                                        children: sizeList.map<Widget>((e) {
                                          int index = sizeList.indexOf(e);
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                currentSizeIndex = index;
                                                finalPrice = sizeList
                                                    .elementAt(index)
                                                    .sellingPrice;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: currentSizeIndex ==
                                                                index
                                                            ? Provider.of<
                                                                        CustomColor>(
                                                                    context)
                                                                .appPrimaryMaterialColor
                                                            : Colors
                                                                .grey.shade400),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 4,
                                                        ),
                                                        child: Text(
                                                            "${e.size}  \u{20B9}${e.sellingPrice}",
                                                            style: FontsTheme.subTitleStyle(
                                                                color: currentSizeIndex ==
                                                                        index
                                                                    ? Provider.of<CustomColor>(
                                                                            context)
                                                                        .appPrimaryMaterialColor
                                                                    : Colors
                                                                        .grey
                                                                        .shade400,
                                                                size: 12)),
                                                        height: 20,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      Space(height: 6)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(2, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "₹",
                          style: FontsTheme.digitStyle(size: 16),
                          children: [
                            TextSpan(
                              text: " $finalPrice",
                              style: FontsTheme.digitStyle(size: 15),
                            ),
                          ]),
                    ),
                    productData.isRequestPrice
                        ? ElevatedButton(
                            onPressed: () {
                              launch(
                                  "https://wa.me/${sharedPrefs.vendorMobileNumber}");
                            },
                            child: Text("Request Price",
                                style: FontsTheme.boldTextStyle(
                                    color: Colors.white)),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Provider.of<CustomColor>(context)
                                      .appPrimaryMaterialColor),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                          )
                        : productData == null
                            ? Container()
                            : AddRemoveButton(
                                productData: productData,
                                isRounded: false,
                                colorIndex: currentIndex,
                                sizeIndex: currentSizeIndex,
                              )
                  ],
                ),
              ),
            ),
    );
  }
}
