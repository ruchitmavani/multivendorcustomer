// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/HelperFunctions.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/CategoryNameProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';
import 'package:multi_vendor_customer/Views/Components/DiscountTag.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductComponentGrid extends StatefulWidget {
  ProductData productData;

  ProductComponentGrid({required this.productData});

  @override
  _ProductComponentGridState createState() => _ProductComponentGridState();
}

class _ProductComponentGridState extends State<ProductComponentGrid> {
  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeColorProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        width: 190,
        height: 254,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0.5, 0.5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 14.0, right: 10.0, bottom: 8, top: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (widget.productData.productRatingAverage != 0)
                        ? ProductRating(widget.productData.productRatingAverage)
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0, top: 4),
                      child: DiscountTag(
                          mrp: widget.productData.productMrp,
                          selling: widget.productData.productSellingPrice),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    height: 110,
                    width: 110,
                    child: widget.productData.productImageUrl.length > 0
                        ? CachedNetworkImage(
                            imageUrl: StringConstants.api_url +
                                widget.productData.productImageUrl.first,
                            fit: BoxFit.contain,
                            width: 110,
                            height: 110,
                            maxWidthDiskCache: 110,
                            maxHeightDiskCache: 110,
                            memCacheHeight: 110,
                            memCacheWidth: 110,
                            repeat: ImageRepeat.repeat,
                          )
                        : Image.asset("images/placeholder.png"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "${widget.productData.productName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.productData.productSellingPrice !=
                                  widget.productData.productMrp)
                                if (!(widget.productData.isRequestPrice ||
                                    widget.productData.bulkPriceList!.length >
                                        0))
                                  Text(
                                    "\u{20B9} ${widget.productData.productMrp}",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 3,
                                        decorationColor:
                                        themeProvider
                                                .appPrimaryMaterialColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                        fontSize: 11),
                                  ),
                              if (!(widget.productData.isRequestPrice ||
                                  widget.productData.bulkPriceList!.length > 0))
                                Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "\u{20B9}",
                                        style: TextStyle(
                                            fontFamily: "",
                                            fontSize: 12,
                                            color: Colors.black87),
                                        children: [
                                          TextSpan(
                                            text:
                                                "${widget.productData.productSellingPrice}",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.black87,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              if (!(widget.productData.isRequestPrice ||
                                  widget.productData.bulkPriceList!.length > 0))
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: themeProvider
                                          .appPrimaryMaterialColor,
                                      fontSize: 4,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.productData.isRequestPrice)
                                Text(
                                  "Request Price",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color:themeProvider
                                          .appPrimaryMaterialColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.productData.isRequestPrice)
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: themeProvider
                                          .appPrimaryMaterialColor,
                                      fontSize: 4,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.productData.bulkPriceList!.length > 0)
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
                                      "${widget.productData.bulkPriceList!.first.pricePerUnit}",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.black87,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          cartButton(),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cartButton() {
    var provider = Provider.of<CategoryName>(context).categoryName;
    var vendorProvider=Provider.of<VendorModelWrapper>(context);
    if (vendorProvider.isShopOpen != "" &&
        vendorProvider.isShopOpen != "Offline") {
      if (!isProductAvailable(
          liveTimings: widget.productData.productLiveTiming)) {
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            "Unavailable\nat this time",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 10, color: Colors.red),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        );
      } else if (widget.productData.isRequestPrice) {
        return SizedBox(
          width: 35,
          height: 35,
          child: Card(
            shape: CircleBorder(),
            elevation: 0,
            color: Provider.of<ThemeColorProvider>(context)
                .appPrimaryMaterialColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    launch(
                        "https://wa.me/+91${sharedPrefs.vendorMobileNumber}?text=${whatsAppParser("Hi, I${sharedPrefs.customer_name.isNotEmpty ? "'m *${sharedPrefs.customer_name}* and" : ""} would like to know more about *${widget.productData.productName} (${provider.indexWhere((element) => element.categoryId == widget.productData.categoryId) == -1 ? "" : "${provider.elementAt(provider.indexWhere((element) => element.categoryId == widget.productData.categoryId)).categoryName}"})*.")}");
                  },
                  child: Icon(
                    Icons.link,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (widget.productData.bulkPriceList!.length > 0) {
        return SizedBox();
      } else if (widget.productData.isStock) {
        if (widget.productData.stockLeft <= 0 ||
            widget.productData.isOutOfStock) {
          return Text(
            "Out of stock",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 11, color: Colors.red),
          );
        } else if (widget.productData.productVariationSizes!.length != 0 ||
            widget.productData.productVariationColors!.length != 0) {
          return context
                      .watch<CartDataWrapper>()
                      .getQuantity(widget.productData.productId) >
                  1
              ? SizedBox()
              : AddRemoveButton(
                  productData: widget.productData,
                  isRounded: true,
                  colorIndex: 0,
                  sizeIndex: 0,
                );
        } else {
          return AddRemoveButton(
            productData: widget.productData,
            isRounded: true,
            colorIndex: 0,
            sizeIndex: 0,
          );
        }
      } else if (!widget.productData.isStock) {
        if (widget.productData.isOutOfStock) {
          return Text(
            "Out of stock",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 11, color: Colors.red),
          );
        } else if (widget.productData.productVariationSizes!.length != 0 ||
            widget.productData.productVariationColors!.length != 0) {
          return context
                      .watch<CartDataWrapper>()
                      .getQuantity(widget.productData.productId) >
                  1
              ? SizedBox()
              : AddRemoveButton(
                  productData: widget.productData,
                  isRounded: true,
                  colorIndex: 0,
                  sizeIndex: 0,
                );
        } else {
          return AddRemoveButton(
            productData: widget.productData,
            isRounded: true,
            colorIndex: 0,
            sizeIndex: 0,
          );
        }
      } else {
        return AddRemoveButton(
          productData: widget.productData,
          isRounded: true,
          colorIndex: 0,
          sizeIndex: 0,
        );
      }
    } else {
      return Text(
        "Offline",
        style:
            TextStyle(fontFamily: 'Poppins', fontSize: 10, color: Colors.red),
      );
    }
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
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0.5, 0.5),
            ),
          ],
        ),
        height: 110,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 110,
              width: MediaQuery.of(context).size.width * 0.2,
              child: widget.productData.productImageUrl.length > 0
                  ? CachedNetworkImage(
                      imageUrl: StringConstants.api_url +
                          widget.productData.productImageUrl.first,
                      maxHeightDiskCache: 110,
                      memCacheHeight: 110,
                      height: 110,
                      width: MediaQuery.of(context).size.width * 0.2,
                    )
                  : Image.asset("images/placeholder.png"),
            ),
            Space(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.productData.productName}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 13,
                              // color: Provider.of<CustomColor>(context)
                              //     .appPrimaryMaterialColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child:
                              widget.productData.productRatingAverage != 0
                                  ?
                              ProductRating(
                                  widget.productData.productRatingAverage)
                          : SizedBox()
                          //     "Pending",
                          //     style: TextStyle(
                          //         fontWeight: FontWeight.bold, fontSize: 11),
                          //   ),
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
                  Space(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!(widget.productData.isRequestPrice ||
                              widget.productData.bulkPriceList!.length > 0))
                            Text(
                              "\u{20B9} ${widget.productData.productMrp}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 3,
                                  decorationColor:
                                      Provider.of<ThemeColorProvider>(context)
                                          .appPrimaryMaterialColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700,
                                  fontSize: 11),
                            ),
                          if (!(widget.productData.isRequestPrice ||
                              widget.productData.bulkPriceList!.length > 0))
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
                                  "${widget.productData.productSellingPrice} ",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                DiscountTag(
                                    mrp: widget.productData.productMrp,
                                    selling:
                                        widget.productData.productSellingPrice)
                              ],
                            ),
                          if (widget.productData.isRequestPrice)
                            Text(
                              "Request Price",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color:
                                      Provider.of<ThemeColorProvider>(context)
                                          .appPrimaryMaterialColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          if (widget.productData.isRequestPrice)
                            Text(
                              "",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color:
                                      Provider.of<ThemeColorProvider>(context)
                                          .appPrimaryMaterialColor,
                                  fontSize: 4,
                                  fontWeight: FontWeight.w600),
                            ),
                          if (widget.productData.bulkPriceList!.length > 0)
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
                                  "${widget.productData.bulkPriceList!.first.pricePerUnit}",
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
                      cartButton(),
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

  Widget cartButton() {
    var provider = Provider.of<CategoryName>(context).categoryName;
    var vendorProvider=Provider.of<VendorModelWrapper>(context);
    if (vendorProvider.isShopOpen != "" &&
        vendorProvider.isShopOpen != "Offline") {
      if (!isProductAvailable(
          liveTimings: widget.productData.productLiveTiming)) {
        return Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            "Unavailable\nat this time",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 10, color: Colors.red),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        );
      } else if (widget.productData.isRequestPrice) {
        return SizedBox(
          width: 35,
          height: 35,
          child: Card(
            shape: CircleBorder(),
            elevation: 0,
            color: Provider.of<ThemeColorProvider>(context)
                .appPrimaryMaterialColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    launch(
                        "https://wa.me/+91${sharedPrefs.vendorMobileNumber}?text=${whatsAppParser("Hi, I${sharedPrefs.customer_name.isNotEmpty ? "'m *${sharedPrefs.customer_name}* and" : ""} would like to know more about *${widget.productData.productName} (${provider.indexWhere((element) => element.categoryId == widget.productData.categoryId) == -1 ? "" : "${provider.elementAt(provider.indexWhere((element) => element.categoryId == widget.productData.categoryId)).categoryName}"})*.")}");
                  },
                  child: Icon(
                    Icons.link,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (widget.productData.bulkPriceList!.length > 0) {
        return SizedBox();
      } else if (widget.productData.isStock) {
        if (widget.productData.stockLeft <= 0 ||
            widget.productData.isOutOfStock) {
          return Text(
            "Out of stock",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 11, color: Colors.red),
          );
        } else if (widget.productData.productVariationSizes!.length != 0 ||
            widget.productData.productVariationColors!.length != 0) {
          return context
                      .watch<CartDataWrapper>()
                      .getQuantity(widget.productData.productId) >
                  1
              ? SizedBox()
              : AddRemoveButton(
                  productData: widget.productData,
                  isRounded: true,
                  colorIndex: 0,
                  sizeIndex: 0,
                );
        } else {
          return AddRemoveButton(
            productData: widget.productData,
            isRounded: true,
            colorIndex: 0,
            sizeIndex: 0,
          );
        }
      } else if (!widget.productData.isStock) {
        if (widget.productData.isOutOfStock) {
          return Text(
            "Out of stock",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 11, color: Colors.red),
          );
        } else if (widget.productData.productVariationSizes!.length != 0 ||
            widget.productData.productVariationColors!.length != 0) {
          return context
                      .watch<CartDataWrapper>()
                      .getQuantity(widget.productData.productId) >
                  1
              ? SizedBox()
              : AddRemoveButton(
                  productData: widget.productData,
                  isRounded: true,
                  colorIndex: 0,
                  sizeIndex: 0,
                );
        } else {
          return AddRemoveButton(
            productData: widget.productData,
            isRounded: true,
            colorIndex: 0,
            sizeIndex: 0,
          );
        }
      } else {
        return AddRemoveButton(
          productData: widget.productData,
          isRounded: true,
          colorIndex: 0,
          sizeIndex: 0,
        );
      }
    } else {
      return Text(
        "Offline",
        style:
            TextStyle(fontFamily: 'Poppins', fontSize: 10, color: Colors.red),
      );
    }
  }
}
