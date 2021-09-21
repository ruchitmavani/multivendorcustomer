import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/TitleViewAll.dart';
import 'package:multi_vendor_customer/CommonWidgets/TopButton.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Data/Controller/BannerController.dart';
import 'package:multi_vendor_customer/Data/Controller/CategoryWiseProductController.dart';
import 'package:multi_vendor_customer/Data/Controller/ProductController.dart';
import 'package:multi_vendor_customer/Data/Models/AllCategoryModel.dart';
import 'package:multi_vendor_customer/Data/Models/BannerDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/DrawerWidget.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/ProductComponent.dart';
import 'package:multi_vendor_customer/Views/Components/RecentlyBought.dart';
import 'package:multi_vendor_customer/Views/Components/TopSellingProductComponent.dart';
import 'package:multi_vendor_customer/Views/ProductDetail.dart';
import 'package:multi_vendor_customer/exports.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BannerDataModel> banners = [];

  bool isLoadingTop = false;
  bool isLoadingCate = false;
  bool isLoadingRece = false;
  bool isLoadingBan = false;
  bool isGrid = true;
  List<AllCategoryModel> productDataList = [];
  List<ProductData> trendingProducts = [];
  List<ProductData> recentlyBought = [];
  DateTime now = DateTime.now();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  getInitialData() async {
    await Provider.of<VendorModelWrapper>(context, listen: false)
        .loadVendorData();
    Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
        vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
            .vendorModel!
            .vendorUniqId);
    _getCategoryWiseProduct();
    _getBannerData();
    _getTrendingData();
    _recentlyBought();
  }

  _getCategoryWiseProduct() async {
    setState(() {
      isLoadingCate = true;
    });
    await CategoryController.getCategoryWiseProduct(
            "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.vendorUniqId}")
        .then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          productDataList = value.data;
          isLoadingCate = false;
        });
      } else {
        setState(() {
          isLoadingCate = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoadingCate = false;
      });
    });
  }

  _getBannerData() async {
    setState(() {
      isLoadingBan = true;
    });
    await BannerController.getBannerData(
            "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.vendorUniqId}")
        .then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          banners = value.data!;
          isLoadingBan = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoadingBan = false;
      });
    });
  }

  _getTrendingData() async {
    setState(() {
      isLoadingTop = true;
    });
    await ProductController.getTrendingProduct(
            vendorId:
                "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.vendorUniqId}")
        .then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          isLoadingTop = false;
          trendingProducts = value.data;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoadingTop = false;
      });
    });
  }

  _recentlyBought() async {
    if (sharedPrefs.customer_id.isEmpty) {
      return;
    }
    setState(() {
      isLoadingRece = true;
    });
    await ProductController.recentlyBought(
            customerId: "${sharedPrefs.customer_id}")
        .then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          isLoadingRece = false;
          recentlyBought = value.data!;
        });
      } else {
        setState(() {
          isLoadingRece = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoadingRece = false;
      });
    });
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
          IconButton(
            icon: Icon(CupertinoIcons.search,
                size: 20, color: appPrimaryMaterialColor),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(PageCollection.search)
                  .then((value) {
                initState();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Badge(
              elevation: 0,
              position: BadgePosition.topEnd(top: 5, end: 0),
              badgeContent: Text(
                  '${Provider.of<CartDataWrapper>(context).totalItems}',
                  style: TextStyle(fontSize: 10, color: Colors.white)),
              child: IconButton(
                icon: Icon(AppIcons.shopping_cart,
                    size: 20, color: appPrimaryMaterialColor),
                onPressed: () {
                  sharedPrefs.customer_id.isNotEmpty
                      ? Navigator.of(context)
                          .pushNamed(PageCollection.cart)
                          .then((value) {
                          initState();
                        })
                      : Navigator.of(context)
                          .pushNamed(PageCollection.login)
                          .then((value) {
                          initState();
                        });
                },
              ),
            ),
          ),
        ],
      ),
      body: Provider.of<VendorModelWrapper>(context).isLoaded
          ? CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(PageCollection.about_us);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                            "${StringConstants.API_URL}${Provider.of<VendorModelWrapper>(context).vendorModel!.logo}",
                                            width: 60,
                                            height: 60),
                                        Space(width: 8.0),
                                        Text(
                                            "${Provider.of<VendorModelWrapper>(context).vendorModel!.businessName}",
                                            style: FontsTheme.boldTextStyle(
                                                size: 17))
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await launch(
                                            'tel: ${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.mobileNumber}');
                                      },
                                      child: Icon(Icons.call,
                                          color: appPrimaryMaterialColor),
                                    ),
                                    Provider.of<VendorModelWrapper>(context,
                                                listen: false)
                                            .vendorModel!
                                            .isWhatsappChatSupport
                                        ? Space(width: 8)
                                        : Container(),
                                    Provider.of<VendorModelWrapper>(context,
                                                listen: false)
                                            .vendorModel!
                                            .isWhatsappChatSupport
                                        ? Container(
                                            height: 18,
                                            width: 0.9,
                                            color: Colors.grey)
                                        : Container(),
                                    Provider.of<VendorModelWrapper>(context,
                                                listen: false)
                                            .vendorModel!
                                            .isWhatsappChatSupport
                                        ? Space(width: 8)
                                        : Container(),
                                    Provider.of<VendorModelWrapper>(context,
                                                listen: false)
                                            .vendorModel!
                                            .isWhatsappChatSupport
                                        ? InkWell(
                                            onTap: () async {
                                              await launch(
                                                  "https://wa.me/${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.mobileNumber}");
                                            },
                                            child: SvgPicture.asset(
                                                "images/whatsapp.svg"))
                                        : Container(),
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
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            child: Image.network(
                                              "${StringConstants.API_URL}${bannerData.bannerUrl}",
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
                                          text: Provider.of<VendorModelWrapper>(
                                                      context)
                                                  .vendorModel!
                                                  .businessHours
                                                  .elementAt(now.weekday)
                                                  .isOpen
                                              ? "  ${Provider.of<VendorModelWrapper>(context).vendorModel!.businessHours.elementAt(now.weekday).openTime} - ${Provider.of<VendorModelWrapper>(context).vendorModel!.businessHours.elementAt(now.weekday).openTime}"
                                              : "  Closed",
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
                                        size: 18,
                                        color: appPrimaryMaterialColor),
                                    InkWell(
                                      onTap: () {
                                        launch(
                                            "https://maps.google.com/?q=${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.latitude.toString()},${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.longitude.toString()}");
                                      },
                                      child: Text(" Direction",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: appPrimaryMaterialColor,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Space(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      isLoadingTop
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 12,
                                    width: 12,
                                    child: CircularProgressIndicator()),
                              ),
                            )
                          : trendingProducts.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 10),
                                  child: Row(
                                    children: [
                                      Text("Top Selling Products",
                                          style: FontsTheme.boldTextStyle(
                                              size: 15)),
                                    ],
                                  ),
                                )
                              : Container(),
                      if (trendingProducts.length != 0)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 12, right: 4, left: 4),
                          child: SizedBox(
                            height: 90,
                            child: ListView.builder(
                                itemCount: trendingProducts.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return TopSellingProductComponent(
                                    productData:
                                        trendingProducts.elementAt(index),
                                  );
                                }),
                          ),
                        ),
                    ],
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: true,
                  flexibleSpace: TopButtons(
                    onChanged: (value) {
                      setState(() {
                        isGrid = value;
                      });
                    },
                  ),
                  automaticallyImplyLeading: false,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: isLoadingRece
                            ? Center(
                                child: SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator()),
                              )
                            : recentlyBought.length == 0
                                ? Container()
                                : Column(
                                    children: [
                                      TitleViewAll(
                                        title: "Recently bought",
                                        onPressed: () {},
                                      ),
                                      SizedBox(
                                        height: 245,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: recentlyBought.length,
                                            itemBuilder: (context, index) {
                                              return RecentlyBought(
                                                productData: recentlyBought
                                                    .elementAt(index),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                      ),
                      isLoadingCate
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : categoryWiseProducts(),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Store is Loading"),
                ],
              ),
            ),
    );
  }

  Widget categoryWiseProducts() {
    return productDataList.length == 0
        ? Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No Products Available"),
            ],
          )
        : Container(
            color: Colors.white,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: productDataList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleViewAll(
                        title:
                            "${productDataList.elementAt(index).categoryName}",
                        onPressed: () {
                          String path = Uri(
                              path: PageCollection.categories,
                              queryParameters: {
                                "categoryName":
                                    "${productDataList.elementAt(index).categoryName}",
                                "categoryId":
                                    "${productDataList.elementAt(index).categoryId}"
                              }).toString();
                          Navigator.pushNamed(context, path).then((value) {});
                        }),
                    SizedBox(
                      height: 245,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection:
                                isGrid ? Axis.horizontal : Axis.vertical,
                            itemCount: productDataList
                                .elementAt(index)
                                .productDetails
                                .length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0, bottom: 15.0),
                                              child: SizedBox(
                                                child: FloatingActionButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Icon(Icons.close,
                                                        size: 16),
                                                    backgroundColor:
                                                        Colors.white),
                                                width: 24,
                                                height: 24,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10.0),
                                                    topLeft:
                                                        Radius.circular(10.0)),
                                              ),
                                              child: ProductDescription(
                                                  productDataList
                                                      .elementAt(index)
                                                      .productDetails
                                                      .elementAt(i)),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: isGrid
                                    ? ProductComponentGrid(
                                        productData: productDataList
                                            .elementAt(index)
                                            .productDetails
                                            .elementAt(i))
                                    : ProductComponentList(
                                        productData: productDataList
                                            .elementAt(index)
                                            .productDetails
                                            .elementAt(i)),
                              );
                            }),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
