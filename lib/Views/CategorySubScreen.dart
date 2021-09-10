import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/TopButton.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductContoller.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Views/ProductDetail.dart';

class CategorySubScreen extends StatefulWidget {
  String categoryId;
  String categoryName;

  CategorySubScreen({required this.categoryName, required this.categoryId});

  @override
  _CategorySubScreenState createState() => _CategorySubScreenState();
}

class _CategorySubScreenState extends State<CategorySubScreen> {
  bool isGrid = true;
  bool isLoading = false;
  List<ProductData> productDataList = [];

  _getProduct() async {
    print("Calling");
    setState(() {
      isLoading = true;
    });
    await ProductController.getProductData(
            vendorId: "657202115727_9429828152",
            categoryId: "${widget.categoryId}",
            limit: 10,
            page: 1)
        .then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          productDataList = value.data;
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
    _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("${widget.categoryName}"),
      ),
      body: Column(
        children: [
          Space(
            height: 4,
          ),
          TopButtons(onChanged: (value) {
            setState(() {
              isGrid = value;
            });
            print(value);
          }),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    itemCount: productDataList.length,
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      crossAxisCount: isGrid ? 2 : 1,
                      childAspectRatio: isGrid ? 1 : 3.5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 2,
                              blurRadius: 2,
                              //offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
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
                                              child:
                                                  Icon(Icons.close, size: 16),
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
                                        child: ProductDescription(
                                            productDataList.elementAt(index)),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: isGrid
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ProductRating(productDataList
                                          .elementAt(index)
                                          .productRatingAverage),
                                      ProductImage(
                                        banners: productDataList
                                                    .elementAt(index)
                                                    .productImageUrl
                                                    .length >
                                                0
                                            ? productDataList
                                                .elementAt(index)
                                                .productImageUrl
                                            : [
                                                "https://i.stack.imgur.com/y9DpT.jpg"
                                              ],
                                        gridView: isGrid,
                                      ),
                                      ProductDetail(
                                        isGridView: isGrid,
                                        productData:
                                            productDataList.elementAt(index),
                                      )
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProductImage(
                                          banners: productDataList
                                                      .elementAt(index)
                                                      .productImageUrl
                                                      .length >
                                                  0
                                              ? productDataList
                                                  .elementAt(index)
                                                  .productImageUrl
                                              : [
                                                  "https://i.stack.imgur.com/y9DpT.jpg"
                                                ],
                                          gridView: isGrid,
                                        ),
                                        Space(width: 8),
                                        Expanded(
                                          child: ProductDetail(
                                            isGridView: isGrid,
                                            productData: productDataList
                                                .elementAt(index),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: ProductRating(
                                                  productDataList
                                                      .elementAt(index)
                                                      .productRatingAverage),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6.0),
                                              child: AddRemoveButton(),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  bool isGridView = true;
  ProductData productData;

  ProductDetail({required this.isGridView, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${productData.productName}",
          style: boldTitleText,
        ),
        Text(
          "${productData.productDescription}",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11,
              color: Colors.grey.shade400),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Space(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 2,
                        color: appPrimaryMaterialColor.shade900,
                        width: 120,
                      ),
                      top: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "\u{20B9}",
                          style: TextStyle(
                              fontFamily: "",
                              fontSize: 11,
                              color: Colors.grey.shade700),
                        ),
                        Text(
                          "${productData.productMrp}",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade700,
                              fontSize: 11),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\u{20B9}",
                      style: TextStyle(
                          fontFamily: "", fontSize: 12, color: Colors.black87),
                    ),
                    Text(
                      "${productData.productSellingPrice}",
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
            Space(width: 4),
            isGridView ? AddRemoveButton() : SizedBox()
          ],
        )
      ],
    );
  }
}

class ProductRating extends StatelessWidget {
  double rating = 0;

  ProductRating(this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 15),
        Text(
          "$rating",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  bool gridView;
  List banners;

  ProductImage({required this.banners, required this.gridView});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 110,
        width: gridView ? null : MediaQuery.of(context).size.width * 0.2,
        child: Image.network("${StringConstants.API_URL}" + banners.first),
      ),
    );
  }
}
