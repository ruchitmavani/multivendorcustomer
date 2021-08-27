import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/TitleViewAll.dart';
import 'package:multi_vendor_customer/CommonWidgets/TopButton.dart';
import 'package:multi_vendor_customer/Constants/RouteConfigure.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductContoller.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/DrawerWidget.dart';
import 'package:multi_vendor_customer/Views/CartScreen.dart';
import 'package:multi_vendor_customer/Views/CategorySubScreen.dart';
import 'package:multi_vendor_customer/Views/Components/ProductComponent.dart';
import 'package:multi_vendor_customer/Views/Components/RecentlyBought.dart';
import 'package:multi_vendor_customer/Views/Components/TopSellingProductComponent.dart';
import 'package:multi_vendor_customer/exports.dart';

import 'AboutUs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List banners = [
    "https://thumbs.dreamstime.com/b/shopping-cart-supermarket-empty-shelves-40320116.jpg"
  ];

  bool isLoading = false;
  List<ProductData> productDataList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _getProduct() async {
    print("Calling");
    setState(() {
      isLoading = true;
    });
    await ProductController.getProductData(
            "433202123326_9429828152", "5552021105518_433202123326_9429828152")
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
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(AppIcons.drawer, color: Colors.black87, size: 15),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Badge(
              elevation: 0,
              position: BadgePosition.topEnd(top: 5, end: 0),
              badgeContent: Text('3',
                  style: TextStyle(fontSize: 10, color: Colors.white)),
              child: IconButton(
                icon: Icon(AppIcons.shopping_cart,
                    size: 20, color: appPrimaryMaterialColor),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => CartScreen()));
                  Navigator.of(context).pushNamed(PageCollection.cart);
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => AboutUs()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/logo.png",
                                  width: 60, height: 60),
                              Space(width: 8.0),
                              Text("iCopper",
                                  style: FontsTheme.boldTextStyle(size: 17))
                            ],
                          ),
                        ),
                      ),
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
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Space(
                    height: 12,
                  ),
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
                              text: "Shop Timing :",
                              style: FontsTheme.descriptionText(
                                  fontWeight: FontWeight.w600),
                              children: [
                            TextSpan(
                                text: "  10am - 10am",
                                style: FontsTheme.valueStyle(
                                    color: Colors.black54,
                                    size: 11,
                                    fontWeight: FontWeight.w700))
                          ])),
                      Space(width: 20),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                            text: "Location:",
                            style: FontsTheme.descriptionText(
                                fontWeight: FontWeight.w600),
                          )),
                          Icon(Icons.directions,
                              size: 18, color: appPrimaryMaterialColor),
                          Text(" Direction",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: appPrimaryMaterialColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                  Space(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: SizedBox(
                      height: 50,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 4.0,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.search,
                                    size: 18, color: Colors.grey.shade700),
                                Space(width: 4),
                                Text("Search",
                                    style: FontsTheme.descriptionText(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w500,
                                        size: 12)),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Space(height: 24)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 20),
              child: Row(
                children: [
                  Text("Top Selling Products",
                      style: FontsTheme.boldTextStyle(size: 15)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 105,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TopSellingProductComponent();
                    }),
              ),
            ),
            Space(
              height: 20,
            ),
            Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TopButtons(),
                    TitleViewAll(
                      title: "Recently bought",
                    ),
                    SizedBox(
                      height: 245,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return RecentlyBought();
                          }),
                    ),
                    TitleViewAll(
                        title: "Clothing",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategorySubScreen()),
                          );
                        }),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                          itemCount: productDataList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ProductComponent(
                                productData: productDataList.elementAt(index));
                          }),
                    ),
                    TitleViewAll(title: "Headphone"),
                    SizedBox(
                      height: 245,
                      child: ListView.builder(
                          itemCount: productDataList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ProductComponent(
                              productData: productDataList.elementAt(index),
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
