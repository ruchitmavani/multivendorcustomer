import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';

class OrderDetailComponent extends StatefulWidget {
  final ProductDetails productDetail;
  final int quantity;

  OrderDetailComponent({required this.productDetail,required this.quantity});

  @override
  _OrderDetailComponentState createState() => _OrderDetailComponentState();
}

class _OrderDetailComponentState extends State<OrderDetailComponent> {
  void ratingBottomSheet(BuildContext context, int price) {
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
                      Text("${widget.productDetail.productName}",
                          style: FontsTheme.descriptionText(size: 15)),
                      Row(
                        children: [
                          Text("\u{20B9}",
                              style: FontsTheme.digitStyle(
                                  size: 14,
                                  colors: Colors.black54,
                                  fontWeight: FontWeight.w500)),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                            ),
                            child: Text("$price",
                                style: FontsTheme.digitStyle(
                                    size: 14,
                                    colors: Colors.black54,
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
                    initialRating: 3,
                    itemSize: 33,
                    direction: Axis.horizontal,
                    tapOnlyMode: true,
                    ignoreGestures: false,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: appPrimaryMaterialColor,
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
                    onRatingUpdate: (rating) {},
                  ),
                ),
                Space(height: 40),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: SizedBox(
                    height: 44,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 13),
                      ),
                      onPressed: () {
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
          Image.network(
            "${StringConstants.API_URL}${widget.productDetail.productImageUrl.first}",
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
                      Text("${widget.productDetail.productName}",
                          style: FontsTheme.valueStyle(
                              size: 13, fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {
                          ratingBottomSheet(context, 25);
                          FocusScope.of(context).unfocus();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: appPrimaryMaterialColor,
                              size: 11,
                            ),
                            Space(
                              width: 2,
                            ),
                            Text(
                              "Rate",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: appPrimaryMaterialColor,
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
                      Text("Qty : ${widget.quantity
                      }",
                          style: FontsTheme.descriptionText(
                              fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text("\u{20B9}",
                              style: FontsTheme.digitStyle(
                                  size: 14, fontWeight: FontWeight.w500)),
                          Text(" ${widget.productDetail.productSellingPrice}",
                              style: FontsTheme.digitStyle(
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
