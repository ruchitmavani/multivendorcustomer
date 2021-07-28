import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/TextInputWidget.dart';
import 'package:multi_vendor_customer/CommonWidgets/TitleViewAll.dart';
import 'package:multi_vendor_customer/CommonWidgets/TopButton.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/DrawerWidget.dart';
import 'package:multi_vendor_customer/Views/Components/ProductComponent.dart';
import 'package:multi_vendor_customer/Views/Components/TopSellingProductComponent.dart';
import 'package:multi_vendor_customer/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List banners = [
    "https://thumbs.dreamstime.com/b/shopping-cart-supermarket-empty-shelves-40320116.jpg"
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      drawer:DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(AppIcons.drawer, color: Colors.black87, size: 15),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          Badge(
            elevation: 0,
            position: BadgePosition.topEnd(top: 5),
            badgeContent:
                Text('3', style: TextStyle(fontSize: 10, color: Colors.white)),
            child: Icon(AppIcons.shopping_cart,
                size: 20, color: appPrimaryMaterialColor),
          ),
          SizedBox(width: 25)
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/logo.png", width: 60, height: 60),
                      Space(width: 8.0),
                      Text("iCopper",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))
                    ],
                  ),
                  Space(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: appPrimaryMaterialColor),
                      Space(width: 8),
                      Container(height: 18, width: 0.9, color: Colors.grey),
                      Space(width: 8),
                      SvgPicture.asset("images/whatsapp.svg"),
                      Space(width: 10)
                    ],
                  ),
                  Space(height: 10),
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 170.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        autoPlay: true),
                    items: banners.map((bannerData) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Image.network(
                                    "$bannerData",
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Space(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Shop Timing:",
                              style: subTitleStyle,
                              children: [
                            TextSpan(text: "  10am - 10am", style: titleStyle)
                          ])),
                      Space(width: 20),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Location:", style: subTitleStyle)),
                          Text(" Direction",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: appPrimaryMaterialColor,
                                  fontWeight: FontWeight.w600)),
                          Icon(Icons.directions,
                              size: 18, color: appPrimaryMaterialColor)
                        ],
                      ),
                    ],
                  ),
                  TextInputWidget(
                      hintText: "Search",
                      icon: Icon(CupertinoIcons.search, size: 20)),
                  Space(height: 20)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20),
              child: Row(
                children: [
                  Text("Top Selling Products", style: boldTitleText),
                ],
              ),
            ),
            SizedBox(
              height:105,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TopSellingProductComponent();
                  }),
            ),
            Space(
              height: 20,
            ),
            Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TopButtons(),
                    TitleViewAll(title: "Recently bought"),
                    SizedBox(
                      height: 245,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, bottom: 8.0),
                              child: SizedBox(
                                width: 180,
                                child: Container(
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Space(height: 8),
                                        Center(
                                            child: SizedBox(
                                                height: 120,
                                                width: 100,
                                                child: Image.network(
                                                    "https://i.pinimg.com/originals/5d/ff/fc/5dfffc72a434a57037433570ec391dc1.png"))),
                                        Space(height: 8),
                                        Text(
                                          "Product name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              color: Colors.grey.shade400),
                                        ),
                                        Space(height: 6),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Positioned(
                                                      child: Container(
                                                        height: 2,
                                                        color:
                                                            appPrimaryMaterialColor
                                                                .shade900,
                                                        width: 120,
                                                      ),
                                                      top: 8,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "\u{20B9}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "",
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700),
                                                            ),
                                                            Text(
                                                              "250.00",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                  fontSize: 11),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\u{20B9}",
                                                      style: TextStyle(
                                                          fontFamily: "",
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      "250.00",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.black87,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Space(width: 8),
                                            // AddRemoveButton()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    TitleViewAll(title: "Clothing"),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, bottom: 8.0),
                              child: SizedBox(
                                width: 180,
                                child: Container(
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Space(height: 8),
                                        Center(
                                            child: SizedBox(
                                                height: 120,
                                                width: 100,
                                                child: Image.network(
                                                    "https://i.pinimg.com/originals/5d/ff/fc/5dfffc72a434a57037433570ec391dc1.png"))),
                                        Space(height: 8),
                                        Text(
                                          "Product name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              color: Colors.grey.shade400),
                                        ),
                                        Space(height: 6),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Positioned(
                                                      child: Container(
                                                        height: 2,
                                                        color:
                                                            appPrimaryMaterialColor
                                                                .shade900,
                                                        width: 120,
                                                      ),
                                                      top: 8,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "\u{20B9}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "",
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700),
                                                            ),
                                                            Text(
                                                              "250.00",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                  fontSize: 11),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\u{20B9}",
                                                      style: TextStyle(
                                                          fontFamily: "",
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      "250.00",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.black87,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Space(width: 8),
                                            AddRemoveButton()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    TitleViewAll(title: "Headphone"),
                    SizedBox(
                      height: 245,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, bottom: 8.0),
                              child: SizedBox(
                                width: 180,
                                child: Container(
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Space(height: 8),
                                        Center(
                                            child: SizedBox(
                                                height: 120,
                                                width: 100,
                                                child: Image.network(
                                                    "https://i.pinimg.com/originals/5d/ff/fc/5dfffc72a434a57037433570ec391dc1.png"))),
                                        Space(height: 8),
                                        Text(
                                          "Product name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                              color: Colors.grey.shade400),
                                        ),
                                        Space(height: 6),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Positioned(
                                                      child: Container(
                                                        height: 2,
                                                        color:
                                                            appPrimaryMaterialColor
                                                                .shade900,
                                                        width: 120,
                                                      ),
                                                      top: 8,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "\u{20B9}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "",
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700),
                                                            ),
                                                            Text(
                                                              "250.00",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade700,
                                                                  fontSize: 11),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\u{20B9}",
                                                      style: TextStyle(
                                                          fontFamily: "",
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      "250.00",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.black87,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Space(width: 8),
                                            AddRemoveButton()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
