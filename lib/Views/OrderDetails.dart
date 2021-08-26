import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Views/Components/OrderDetailComponent.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  void ratingBottomSheet(BuildContext context) {
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
                      Text("Copper flask CF-125",
                          style: FontsTheme.descriptionText(size: 15)),
                      Row(
                        children: [
                          Text("\u{20B9}",
                              style: FontsTheme.digitStyle(
                                  size: 15, colors: Colors.black54)),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 2.0,
                            ),
                            child: Text("249",
                                style: FontsTheme.digitStyle(
                                    size: 14, colors: Colors.black54)),
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: Column(
          children: [
            Container(
              height: 10,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 13.0, right: 5, top: 11, bottom: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("images/logo.png", width: 60, height: 60),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("The flash shop",
                              style: FontsTheme.valueStyle(
                                  fontWeight: FontWeight.w600, size: 14)),
                          Text("Sowcarpet",
                              style: FontsTheme.valueStyle(
                                  fontWeight: FontWeight.w600, size: 11)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        color: appPrimaryMaterialColor,
                        size: 20,
                      ),
                      Space(width: 8),
                      Container(height: 18, width: 0.9, color: Colors.grey),
                      Space(width: 8),
                      SvgPicture.asset(
                        "images/whatsapp.svg",
                        width: 20,
                      ),
                      Space(width: 10)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              color: Colors.grey.shade200,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        scrollDirection: Axis.vertical,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return OrderDetailComponent();
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey[300],
                          thickness: 0.6,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              height: 25,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text("Discount Applied",
                                    style: FontsTheme.valueStyle(size: 14)),
                                trailing: Text("- \u{20B9}" + "256.00",
                                    style: FontsTheme.valueStyle(size: 14,fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              height: 25,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title:
                                    Text("Tax", style: FontsTheme.valueStyle(size: 14)),
                                trailing: Text("\u{20B9}" + "256.00",
                                    style: FontsTheme.valueStyle(size: 14,fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              height: 25,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text("Shipping Fee",
                                    style: FontsTheme.valueStyle(size: 14)),
                                trailing: Text("\u{20B9}" + "256.00",
                                    style: FontsTheme.valueStyle(size: 14,fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13.0),
                            child: SizedBox(
                              height: 35,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text("Total",
                                    style: FontsTheme.valueStyle(size: 16,fontWeight: FontWeight.w700)),
                                trailing: Text("\u{20B9}" + " " + "256.00",
                                    style: FontsTheme.valueStyle(size: 16,fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 25.0, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 44,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Download invoice",
                      style: TextStyle(fontSize: 13),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                      ),
                    )
                  ],
                ),
                onPressed: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
