import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';

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
            padding: const EdgeInsets.only(left:18.0,right: 18,top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Rate your Order for",
                  style: FontsTheme.boldTextStyle(
                    size: 18
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top:22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Copper flask CF-125",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "\u{20B9}",
                            style: TextStyle(
                                fontFamily: "",
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w600,
                                color: Colors.black45),
                          ),
                          Text(
                              "249",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
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
                Space(height: 20),
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        width: 1.2,
                        color: appPrimaryMaterialColor,
                      ),
                    ),
                    width: 45,
                    height: 45,
                    child: Center(
                      child: Text(
                        "LOGO",
                        style: TextStyle(
                            fontSize: 13,
                            color: appPrimaryMaterialColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The flash shop",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Sowcarpet",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
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
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 13, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "https://thumbs.dreamstime.com/b/transparent-photoshop-psd-png-seamless-grid-pattern-background-transparent-photoshop-psd-png-seamless-grid-pattern-background-grey-175598426.jpg",
                                  width: 55,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Copper flash CF-125",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                ratingBottomSheet(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color:
                                                        appPrimaryMaterialColor,
                                                    size: 11,
                                                  ),
                                                  Space(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    "Rate",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            appPrimaryMaterialColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Qty : 1",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "\u{20B9}",
                                                  style: TextStyle(
                                                      fontFamily: "",
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black87),
                                                ),
                                                Text(
                                                  "249",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black87),
                                                ),
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
                                title: Text(
                                  "Discount Applied",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                trailing: Text("\u{20B9}" + " " + "256.00",
                                    style: FontsTheme.boldTextStyle(
                                      size: 12,
                                      color: Colors.black87,
                                    )),
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
                                title: Text(
                                  "Tax",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                trailing: Text("\u{20B9}" + " " + "256.00",
                                    style: FontsTheme.boldTextStyle(
                                      size: 12,
                                      color: Colors.black87,
                                    )),
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
                                title: Text(
                                  "Shipping Fee",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                trailing: Text("\u{20B9}" + " " + "256.00",
                                    style: FontsTheme.boldTextStyle(
                                      size: 12,
                                      color: Colors.black87,
                                    )),
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
                                title: Text(
                                  "Total",
                                  style: FontsTheme.boldTextStyle(
                                    size: 15,
                                  ),
                                ),
                                trailing: Text("\u{20B9}" + " " + "256.00",
                                    style: FontsTheme.boldTextStyle(
                                      size: 14,
                                      color: Colors.black87,
                                    )),
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
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
