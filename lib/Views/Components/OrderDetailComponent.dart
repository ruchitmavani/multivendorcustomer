import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/updatedLabel.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/RatingController.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:provider/provider.dart';

class OrderDetailComponent extends StatefulWidget {
  final ProductDetails productDetail;
  final String orderId;
  final OrderItem orderItem;

  OrderDetailComponent(
      {required this.productDetail,
      required this.orderId,
      required this.orderItem});

  @override
  _OrderDetailComponentState createState() => _OrderDetailComponentState();
}

class _OrderDetailComponentState extends State<OrderDetailComponent> {
  double rating = 0;
  bool isLoading = false;
  int qty = 0;
  double price = 0;
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    double productPrice = 0;
    int qty = 0;

    if (widget.orderItem.updatedQuantity != null) {
      qty = widget.orderItem.updatedQuantity!;
    } else
      qty = widget.orderItem.productQuantity;

    if (widget.orderItem.isReject == true) {
    } else if (widget.orderItem.productSize != null) {
      productPrice = widget.orderItem.productSize!.sellingPrice;
    } else if (widget.productDetail.bulkPriceList.length != 0) {
      productPrice = getPrice(qty, widget.productDetail.bulkPriceList);
    } else {
      productPrice =
          double.parse("${widget.productDetail.productSellingPrice}");
    }

    log("->>>> $productPrice");

    setState(() {
      if (widget.orderItem.isReject == true) {
      } else if (widget.orderItem.updatedQuantity != null) {
        totalPrice = qty * productPrice;
      } else {
        totalPrice = qty * productPrice;
      }
      price = productPrice;
      this.qty = qty;
    });
    _loadRating();
  }

  _loadRating() async {
    await RatingController.viewRating(
            productId: "${widget.productDetail.productId}")
        .then((value) {
      if (value.success) {
        setState(() {
          rating = value.data!.productRatingCount as double;
        });
      } else {}
    }, onError: (e) {});
  }

  _updateRating() async {
    setState(() {
      isLoading = true;
    });
    await RatingController.rateProduct(
            customerName: "${sharedPrefs.customer_name}",
            orderId: "${widget.orderId}",
            rating: rating.toInt(),
            productId: "${widget.productDetail.productId}")
        .then((value) {
      if (value.success) {
        print(value.success);
        rating = value.data!.productRatingCount as double;
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: value.message,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
        if (Navigator.canPop(context)) Navigator.pop(context);
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

  void ratingBottomSheet(BuildContext context, double price) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)),
        ),
        context: context,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.only(left: 19.0, right: 19, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Rate your Order for",
                    style: FontsTheme.boldTextStyle(size: 17)),
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.productDetail.productName}",
                        style: FontsTheme.descriptionText(size: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text("\u{20B9}",
                              style: FontsTheme.digitStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500)),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                            ),
                            child: Text("$price",
                                style: FontsTheme.digitStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RatingBar(
                    initialRating: rating,
                    itemSize: 33,
                    direction: Axis.horizontal,
                    tapOnlyMode: true,
                    ignoreGestures: false,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: Provider.of<CustomColor>(context)
                            .appPrimaryMaterialColor,
                      ),
                      half: Icon(
                        Icons.star,
                        color: Colors.grey.shade300,
                      ),
                      empty: Icon(
                        Icons.star,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    onRatingUpdate: (value) {
                      rating = value;
                    },
                  ),
                ),
                Space(height: 40),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: SizedBox(
                    height: 44,
                    width: MediaQuery.of(context).size.width,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: 13),
                            ),
                            onPressed: () {
                              _updateRating();
                              FocusScope.of(context).unfocus();
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 13, bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.productDetail.productImageUrl.length == 0
              ? Image.asset(
                  "images/placeholder.png",
                  width: 55,
                )
              : Image.network(
                  "${StringConstants.api_url}${widget.productDetail.productImageUrl.first}",
                  width: 55,
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "${widget.productDetail.productName}",
                          maxLines: null,
                          style: FontsTheme.valueStyle(
                              size: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ratingBottomSheet(context, price);
                          FocusScope.of(context).unfocus();
                        },
                        child: rating != 0
                            ? Row(
                                children: [
                                  Text(
                                    "$rating",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Provider.of<CustomColor>(context)
                                            .appPrimaryMaterialColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Space(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Provider.of<CustomColor>(context)
                                        .appPrimaryMaterialColor,
                                    size: 11,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Provider.of<CustomColor>(context)
                                        .appPrimaryMaterialColor,
                                    size: 11,
                                  ),
                                  Space(
                                    width: 2,
                                  ),
                                  Text(
                                    rating != 0 ? "$rating" : "Rate",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Provider.of<CustomColor>(context)
                                            .appPrimaryMaterialColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                  Space(
                    height: 17,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.orderItem.updatedQuantity != null
                          ? Row(
                              children: [
                                Text("Qty : ",
                                    style: FontsTheme.descriptionText(
                                        fontWeight: FontWeight.w500)),
                                Text("${widget.orderItem.productQuantity}",
                                    style: FontsTheme.descriptionText(
                                            fontWeight: FontWeight.w500)
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor:
                                                Provider.of<CustomColor>(
                                                        context)
                                                    .appPrimaryMaterialColor,
                                            decorationThickness: 3)),
                                Text(" ${widget.orderItem.updatedQuantity}  ",
                                    style: FontsTheme.descriptionText(
                                        fontWeight: FontWeight.w500)),
                                UpdatedLabel(),
                              ],
                            )
                          : Text("Qty : $qty",
                              style: FontsTheme.descriptionText(
                                  fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text("\u{20B9}",
                              style: FontsTheme.valueStyle(
                                  size: 14, fontWeight: FontWeight.w500)),
                          Text("$totalPrice",
                              style: FontsTheme.valueStyle(
                                  size: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
