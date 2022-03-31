// ignore_for_file: must_be_immutable
import 'dart:html';

import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButtonBulk.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/HelperFunctions.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/CategoryNameProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'Components/DiscountTag.dart';

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
  List<BulkPriceList> bulkPrice = [];
  int currentIndex = 0;
  int currentSizeIndex = 0;
  int displayImage = 0;
  double finalPrice = 0;
  int finalColor = 0;
  bool isLoading = false;
  bool isVideo = false;
  bool isExist = true;
  int finalQuantity = 0;

  int? selectedQtyIndex;

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
          if (productData.productVariationColors!.length != 0) {
            colorList = productData.productVariationColors!;
          }
          if (productData.productVariationSizes!.length != 0) {
            sizeList = productData.productVariationSizes!;
          }
          if (productData.bulkPriceList!.length != 0) {
            bulkPrice = productData.bulkPriceList!;
          }
          finalPrice = productData.productSellingPrice;
          if (productData.productVariationColors!.length != 0) {
            finalColor = productData.productVariationColors!.first.colorCode;
          }
        });
      } else {
        setState(() {
          isLoading = false;
          isExist = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
        isExist = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  setPrice(double price, int qty, int index) {
    setState(() {
      finalPrice = price;
      selectedQtyIndex = index;
      finalQuantity = qty;
    });
  }

  TextStyle label = FontsTheme.subTitleStyle(
      color: Colors.black.withOpacity(0.75),
      fontWeight: FontWeight.w600,
      size: 12);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryName>(context).categoryName;

    return DirectSelectContainer(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.search,
                  size: 25,
                  color: Provider.of<ThemeColorProvider>(context)
                      .appPrimaryMaterialColor),
              onPressed: () {
                GoRouter.of(context)
                    .push('/' + storeConcat(PageCollection.search));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: cartIconWidget(context),
            ),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : isExist
                ? SizedBox(
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
                                productData.productImageUrl.length == 0 &&
                                        productData.productVideoUrl.isEmpty &&
                                        productData.productYoutubeUrl.isEmpty
                                    ? SizedBox(
                                        height: 230,
                                        child: Image.asset(
                                            "images/placeholder.png"),
                                      )
                                    : SizedBox(
                                        height: 230,
                                        child: displayImage ==
                                                productData
                                                    .productImageUrl.length
                                            ? productData.isYoutubeUrl
                                                ? YoutubePlayerIFrame(
                                                    controller:
                                                        YoutubePlayerController(
                                                      initialVideoId:
                                                          "${productData.productYoutubeUrl}",
                                                      params:
                                                          YoutubePlayerParams(
                                                        showControls: false,
                                                        mute: true,
                                                        showFullscreenButton:
                                                            false,
                                                      ),
                                                    ),
                                                    aspectRatio: 16 / 9,
                                                  )
                                                : VideoPlayer(
                                                    VideoPlayerController.network(
                                                        "${StringConstants.api_url + productData.productVideoUrl}")
                                                      ..initialize()
                                                      ..play()
                                                      ..setVolume(0))
                                            : Image.network(
                                                "${StringConstants.api_url + productData.productImageUrl.elementAt(displayImage)}")),
                                Space(height: 20),
                                Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: productData
                                                .productVideoUrl.isEmpty &&
                                            productData
                                                .productYoutubeUrl.isEmpty
                                        ? productData.productImageUrl.length
                                        : productData.productImageUrl.length +
                                            1,
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
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  displayImage = index;
                                                  if ((productData
                                                              .productVideoUrl
                                                              .isNotEmpty ||
                                                          productData
                                                              .productYoutubeUrl
                                                              .isNotEmpty) &&
                                                      index ==
                                                          productData
                                                              .productImageUrl
                                                              .length) {
                                                    isVideo = true;
                                                  } else {
                                                    isVideo = false;
                                                  }
                                                });
                                              },
                                              child: (productData
                                                              .productVideoUrl
                                                              .isNotEmpty ||
                                                          productData
                                                              .productYoutubeUrl
                                                              .isNotEmpty) &&
                                                      index ==
                                                          productData
                                                              .productImageUrl
                                                              .length
                                                  ? Icon(
                                                      Icons.play_circle_outline,
                                                      color: Colors.grey,
                                                      size: 32,
                                                    )
                                                  : Image.network(
                                                      "${StringConstants.api_url + productData.productImageUrl.elementAt(index)}"),
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
                                            left: 30.0, right: 30, bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("${productData.productName}",
                                                style: FontsTheme.boldTextStyle(
                                                    size: 16)),
                                            if (productData.productMrp >
                                                productData.productSellingPrice)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                ),
                                                child: SizedBox(
                                                    width: 48,
                                                    child: DiscountTag(
                                                        mrp: productData
                                                            .productMrp,
                                                        selling: productData
                                                            .productSellingPrice)),
                                              ),
                                            Space(height: 8),
                                            ProductRating(productData
                                                .productRatingAverage),
                                            Space(height: 8),
                                            Text(
                                                "${productData.productDescription}",
                                                style:
                                                    FontsTheme.descriptionText(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                textAlign: TextAlign.justify),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            if (productData.isStock)
                                              if (productData.stockLeft <= 20)
                                                Text(
                                                  productData.stockLeft == 0
                                                      ? "Out of stock"
                                                      : "${productData.stockLeft}  left in Stock",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: productData
                                                                  .stockLeft <
                                                              10
                                                          ? Colors.red
                                                          : Provider.of<
                                                                      ThemeColorProvider>(
                                                                  context)
                                                              .appPrimaryMaterialColor),
                                                ),
                                            Divider(
                                              height: 15,
                                            ),
                                            productData.productLiveTiming
                                                        .length >
                                                    0
                                                ? productData.productLiveTiming
                                                        .contains("All Time")
                                                    ? SizedBox()
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Space(
                                                            height: 1,
                                                          ),
                                                          Text(
                                                            "Available Time",
                                                            style: label,
                                                          ),
                                                          Space(height: 4),
                                                          for (int i = 0;
                                                              i <
                                                                  productData
                                                                      .productLiveTiming
                                                                      .length;
                                                              i++) ...[
                                                            Text(
                                                              "${productData.productLiveTiming[i]}",
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                // fontWeight:
                                                                //     FontWeight.w600,
                                                                color: Colors
                                                                    .grey[800],
                                                              ),
                                                            ),
                                                          ],
                                                          Space(height: 15),
                                                        ],
                                                      )
                                                : SizedBox(),
                                            // Color Option
                                            if (colorList.length > 0)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Color option",
                                                    style: label,
                                                  ),
                                                  Space(height: 8),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: colorList
                                                          .map<Widget>((e) {
                                                        int index = colorList
                                                            .indexOf(e);
                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              currentIndex =
                                                                  index;
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
                                                            child: Container(
                                                              decoration: currentIndex ==
                                                                      index
                                                                  ? BoxDecoration(
                                                                      border: Border.all(
                                                                          width:
                                                                              2,
                                                                          color: Provider.of<ThemeColorProvider>(context)
                                                                              .appPrimaryMaterialColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50.0))
                                                                  : null,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(50.0),
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              Color(e.colorCode),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 0.3),
                                                                          borderRadius:
                                                                              BorderRadius.circular(50.0),
                                                                        ),
                                                                        height: 25,
                                                                        width: 25)),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (sizeList.length > 0)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Space(height: 15),
                                                  Text(
                                                    "Size Option",
                                                    style: label,
                                                  ),
                                                  Space(height: 8),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children:
                                                          sizeList.map<Widget>(
                                                        (e) {
                                                          int index = sizeList
                                                              .indexOf(e);
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                currentSizeIndex =
                                                                    index;
                                                                finalPrice = sizeList
                                                                    .elementAt(
                                                                        index)
                                                                    .sellingPrice;
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          8.0),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: currentSizeIndex ==
                                                                                index
                                                                            ? Provider.of<ThemeColorProvider>(context)
                                                                                .appPrimaryMaterialColor
                                                                            : Colors
                                                                                .grey.shade400),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0)),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0),
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      margin: EdgeInsets
                                                                          .symmetric(
                                                                        horizontal:
                                                                            4,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        "${e.size}  \u{20B9}${e.sellingPrice}",
                                                                        style: FontsTheme.subTitleStyle(
                                                                            color: currentSizeIndex == index
                                                                                ? Provider.of<ThemeColorProvider>(context).appPrimaryMaterialColor
                                                                                : Colors.grey.shade400,
                                                                            size: 12),
                                                                      ),
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                  Space(height: 4),
                                                ],
                                              ),

                                            // if (productData.bulkPriceList!.length !=
                                            //     0)
                                            //   Space(height: 15),
                                            if (productData
                                                    .bulkPriceList!.length !=
                                                0)
                                              Text(
                                                "Bulk Prices",
                                                style: label,
                                              ),
                                            Space(height: 2),
                                            if (productData
                                                    .bulkPriceList!.length !=
                                                0)
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: bulkPrice.length,
                                                itemBuilder: (context, i) {
                                                  List<int> _numbers = [];
                                                  for (int index =
                                                          bulkPrice[i].fromQty;
                                                      index <=
                                                          bulkPrice[i].toQty;
                                                      index++) {
                                                    _numbers.add(index);
                                                  }
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(6),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text("From: ",
                                                                    style: FontsTheme.subTitleStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade400,
                                                                        size:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                                Text(
                                                                    "${bulkPrice[i].fromQty}",
                                                                    style: FontsTheme.subTitleStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        size:
                                                                            12))
                                                              ],
                                                            ),
                                                            Space(
                                                              width: 6,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text("To: ",
                                                                    style: FontsTheme.subTitleStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade400,
                                                                        size:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                                Text(
                                                                    "${bulkPrice[i].toQty}",
                                                                    style: FontsTheme.subTitleStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        size:
                                                                            12))
                                                              ],
                                                            ),
                                                            Space(
                                                              width: 6,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text("Price: ",
                                                                    style: FontsTheme.subTitleStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade400,
                                                                        size:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
                                                                Text(
                                                                  "₹",
                                                                  style: FontsTheme.digitStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600),
                                                                ),
                                                                Text(
                                                                    "${bulkPrice[i].pricePerUnit}",
                                                                    style: FontsTheme.digitStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        fontSize:
                                                                            12)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      QuantitySelect(
                                                        price: bulkPrice[i]
                                                            .pricePerUnit,
                                                        numbers: _numbers,
                                                        setPrice: setPrice,
                                                        index: i,
                                                        isSelected: i !=
                                                            selectedQtyIndex,
                                                        productId:
                                                            widget.productId,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            if (productData
                                                    .bulkPriceList!.length !=
                                                0)
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 2,
                                                        horizontal: 4),
                                                    child: SizedBox(
                                                      height: 25,
                                                      child: ListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        dense: true,
                                                        title: Text(
                                                          "Price",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        trailing: Text(
                                                            finalQuantity != 0
                                                                ? "\u{20B9} ${finalPrice / finalQuantity}"
                                                                : "0"),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 2,
                                                        horizontal: 4),
                                                    child: SizedBox(
                                                      height: 25,
                                                      child: ListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        dense: true,
                                                        title: Text(
                                                          "Qty",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        trailing: Text(
                                                            "$finalQuantity"),
                                                      ),
                                                    ),
                                                  ),
                                                  Space(
                                                    height: 10,
                                                  ),
                                                ],
                                              )
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
                  )
                : Center(child: Text("Product does not exist")),
        bottomSheet: isLoading
            ? Center(child: CircularProgressIndicator())
            : isExist
                ? Container(
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
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "₹",
                                style: FontsTheme.digitStyle(fontSize: 15),
                                children: [
                                  TextSpan(
                                    text: productData.bulkPriceList!.length ==
                                                0 &&
                                            Provider.of<CartDataWrapper>(
                                                        context)
                                                    .getIndividualQuantity(
                                                        productId: productData
                                                            .productId) >
                                                0
                                        ? " ${Provider.of<CartDataWrapper>(context).getIndividualQuantity(productId: productData.productId) * finalPrice}"
                                        : " $finalPrice",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                  ),
                                ]),
                          ),
                          if (Provider.of<VendorModelWrapper>(context)
                                      .isShopOpen !=
                                  "" &&
                              Provider.of<VendorModelWrapper>(context)
                                      .isShopOpen !=
                                  "Offline")
                            if (isProductAvailable(
                                liveTimings: productData.productLiveTiming))
                              if (productData.isRequestPrice)
                                ElevatedButton(
                                  onPressed: () {
                                    launch(
                                        "https://wa.me/+91${sharedPrefs.vendorMobileNumber}?text=${whatsAppParser("Hi, I${sharedPrefs.customer_name.isNotEmpty ? "'m *${sharedPrefs.customer_name}* and" : ""} would like to know more about *${productData.productName} (${provider.indexWhere((element) => element.categoryId == productData.categoryId) == -1 ? "" : "${provider.elementAt(provider.indexWhere((element) => element.categoryId == productData.categoryId)).categoryName}"})*.")}");
                                  },
                                  child: Text("Request Price",
                                      style: FontsTheme.boldTextStyle(
                                          color: Colors.white)),
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Provider.of<ThemeColorProvider>(context)
                                            .appPrimaryMaterialColor),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                )
                              else if ((productData.isStock &&
                                      productData.stockLeft <= 0) ||
                                  productData.isOutOfStock)
                                Text(
                                  "Out of stock",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      color: Colors.red),
                                )
                              else if (productData.bulkPriceList!.length != 0)
                                AddRemoveButtonBulk(
                                  productData: productData,
                                  isRounded: false,
                                  price: finalPrice / finalQuantity,
                                  qty: finalQuantity,
                                )
                              else
                                AddRemoveButton(
                                  productData: productData,
                                  isRounded: false,
                                  colorIndex: currentIndex,
                                  sizeIndex: currentSizeIndex,
                                )
                            else
                              Text(
                                "Unavailable at this time",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    color: Colors.red),
                                textAlign: TextAlign.justify,
                              )
                          else
                            Text(
                              "Shop is Offline",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Colors.red),
                            )
                        ],
                      ),
                    ),
                  )
                : null,
      ),
    );
  }
}

getDropDownMenuItem(int value) {
  return Container(
    decoration: BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "$value",
        textAlign: TextAlign.center,
      ),
    ),
  );
}

class QuantitySelect extends StatefulWidget {
  List<int> numbers;
  double price;
  Function setPrice;
  String productId;
  int index;
  bool isSelected;

  QuantitySelect(
      {required this.numbers,
      required this.price,
      required this.setPrice,
      required this.index,
      required this.isSelected,
      required this.productId});

  @override
  _QuantitySelectState createState() => _QuantitySelectState();
}

class _QuantitySelectState extends State<QuantitySelect> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
                    child: SizedBox(
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                    ),
                    child: ListView.builder(
                      itemCount: widget.numbers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                _quantity = widget.numbers.elementAt(index);
                              });
                              Navigator.pop(context);
                              widget.setPrice(_quantity * widget.price,
                                  _quantity, widget.index);
                              Provider.of<CartDataWrapper>(context,
                                      listen: false)
                                  .deleteFromCart(productId: widget.productId);
                            },
                            child: getDropDownMenuItem(widget.numbers[index]));
                      },
                    ),
                  ),
                ],
              );
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 4, left: 6, top: 4, bottom: 4),
          child: widget.isSelected
              ? Row(
                  children: [
                    Text(
                      "Select Qty:",
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      "$_quantity",
                      style: FontsTheme.digitStyle(
                          fontSize: 12, color: Colors.grey.shade600),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
