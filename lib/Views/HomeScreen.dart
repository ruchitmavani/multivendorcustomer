import 'package:auto_size_text/auto_size_text.dart' show AutoSizeText;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';
import 'package:multi_vendor_customer/DrawerWidget.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/HelperFunctions.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/CategoryNameProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/ProductComponent.dart';
import 'package:multi_vendor_customer/Views/Components/RecentlyBought.dart';
import 'package:multi_vendor_customer/Views/Components/TopSellingProductComponent.dart';
import 'package:multi_vendor_customer/exports.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BannerDataModel> banners = [];
  bool isShopOpen = false;
  bool isLoadingTop = false;
  bool isLoadingCate = false;
  bool isLoadingRece = false;
  bool isLoadingBan = false;
  bool isShopLoading = true;
  bool isGrid = true;
  List<AllCategoryModel> productDataList = [];
  List<ProductData> trendingProducts = [];
  List<ProductData> recentlyBought = [];
  List<String> sortKeyList = ["NtoO", "OtoN", "spHtoL", "spLtoH"];
  String todayIndex = DateFormat('EEEE').format(DateTime.now());

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0)).then((value) {
      getInitialData();
    });
  }

  getInitialData() async {
    setState(() {
      isShopLoading = true;
    });

    isShopLoading =
        await Provider.of<VendorModelWrapper>(context, listen: false)
            .loadVendorData(sharedPrefs.storeLink);
    setState(() {});
    print(
        "vendor id in home provider ${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.vendorUniqId}");
    _getCategoryWiseProduct(sortKeyList.first);
    _getBannerData();
    _getTrendingData();
    _recentlyBought();
    Provider.of<CartDataWrapper>(context, listen: false).loadCartData();
    Provider.of<CategoryName>(context, listen: false).loadCategoryName();
    Provider.of<CustomColor>(context, listen: false).updateColor();
    print(Provider.of<VendorModelWrapper>(context, listen: false)
        .vendorModel!
        .toJson());
    if (Provider.of<VendorModelWrapper>(context, listen: false).vendorModel !=
        null) if (getShopTimingStatus(
            Provider.of<VendorModelWrapper>(context, listen: false)
                .vendorModel!) !=
        "Offline") {
      isShopOpen = true;
    }
  }

  _getCategoryWiseProduct(String sortKey) async {
    setState(() {
      isLoadingCate = true;
    });
    await CategoryController.getCategoryWiseProduct(
            "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.vendorUniqId}",
            sortKey.split(".").last)
        .then((value) {
      if (value.success) {
        print(value.data);
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
            customerId: "${sharedPrefs.customer_id}",
            vendorId:
                "${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.vendorUniqId}")
        .then((value) {
      if (value.success) {
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

  int weekIndex(List<BusinessHour> list) {
    return list.indexWhere(
        (element) => element.day.toLowerCase() == todayIndex.toLowerCase());
  }

  String getShopTimingStatus(VendorDataModel vendorProvider) {
    List<BusinessHour> list = vendorProvider.businessHours;
    if (vendorProvider.isOnline) {
      // if (list[weekIndex(list)].isOpen == false) {
      //   return "Closed";
      // } else {
      //   TimeOfDay startTime = TimeOfDay.fromDateTime(
      //       DateFormat.jm().parse(list[weekIndex(list)].openTime));
      //   TimeOfDay endTime = TimeOfDay.fromDateTime(
      //       DateFormat.jm().parse(list[weekIndex(list)].closeTime));
      //   TimeOfDay currentTime = TimeOfDay.now();
      //   if (currentTime.hour > startTime.hour &&
      //       currentTime.hour < endTime.hour) {
      //     return "${list[weekIndex(list)].openTime} - ${list[weekIndex(list)].closeTime}";
      //   } else if ((currentTime.hour == startTime.hour &&
      //           currentTime.minute > startTime.minute) ||
      //       (currentTime.hour == endTime.hour &&
      //           currentTime.minute < endTime.minute)) {
      //     return "${list[weekIndex(list)].openTime} - ${list[weekIndex(list)].closeTime}";
      //   } else {
      //     return "Closed";
      //   }
      // }

      return list.isEmpty?"-":"${list[weekIndex(list)].openTime} - ${list[weekIndex(list)].closeTime}";
    } else {
      return "Offline";
    }
  }

  @override
  Widget build(BuildContext context) {
    VendorDataModel? vendorProvider =
        Provider.of<VendorModelWrapper>(context, listen: false).vendorModel;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[200],
        drawer: DrawerWidget(),
        appBar: isShopOpen
            ? AppBar(
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
                        size: 25,
                        color: Provider.of<CustomColor>(context)
                            .appPrimaryMaterialColor),
                    onPressed: () {
                      GoRouter.of(context)
                          .push('/' + storeConcat(PageCollection.search));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: cartIconWidget(context),
                  ),
                ],
              )
            : AppBar(
                leading: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(AppIcons.drawer, color: Colors.black87, size: 15),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
        floatingActionButton: isShopOpen
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Card(
                        margin:
                            EdgeInsets.only(right: 20, left: 20, bottom: 30),
                        child: ListView.builder(
                          itemCount: productDataList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                context.go(helper(PageCollection.categories +
                                    '/${productDataList.elementAt(index).categoryId}'));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${productDataList.elementAt(index).categoryName}"),
                                    Row(
                                      children: [
                                        Text(
                                            "${productDataList.elementAt(index).productDetails.length}"),
                                        Icon(
                                          Icons.chevron_right,
                                          color:
                                              Provider.of<CustomColor>(context)
                                                  .appPrimaryMaterialColor,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.category_outlined,
                  color: Colors.white,
                ),
                backgroundColor:
                    Provider.of<CustomColor>(context).appPrimaryMaterialColor,
              )
            : FloatingActionButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Shop is Offline",
                      webPosition: "center",
                      webBgColor:
                          "linear-gradient(to right, #5A5A5A, #5A5A5A)");
                },
                child: Icon(
                  Icons.category_outlined,
                  color: Colors.white,
                ),
                backgroundColor:
                    Provider.of<CustomColor>(context).appPrimaryMaterialColor,
              ),
        body: isShopOpen
            ? vendorProvider != null
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
                                      InkWell(
                                        onTap: () {
                                          GoRouter.of(context).go('/' +
                                              storeConcat(
                                                  PageCollection.about_us));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                child: CachedNetworkImage(
                                                  height: 45,
                                                  width: 45,
                                                  imageUrl:
                                                      "${StringConstants.api_url}${vendorProvider.logo}",
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) {
                                                    return SizedBox(
                                                      width: 12,
                                                      height: 12,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  },
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.map),
                                                ),
                                              ),
                                              Space(width: 8.0),
                                              AutoSizeText(
                                                "${vendorProvider.businessName}",
                                                minFontSize: 6,
                                                style: FontsTheme.gilroyText(
                                                    size: 17,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            child: InkWell(
                                              onTap: () async {
                                                await launch(
                                                    'tel: ${vendorProvider.mobileNumber}');
                                              },
                                              child: Icon(Icons.call,
                                                  color: Provider.of<
                                                          CustomColor>(context)
                                                      .appPrimaryMaterialColor),
                                            ),
                                          ),
                                          vendorProvider.isWhatsappChatSupport
                                              ? Space(width: 11)
                                              : Container(),
                                          vendorProvider.isWhatsappChatSupport
                                              ? Container(
                                                  height: 18,
                                                  width: 0.9,
                                                  color: Colors.grey)
                                              : Container(),
                                          vendorProvider.isWhatsappChatSupport
                                              ? Space(width: 11)
                                              : Container(),
                                          vendorProvider.isWhatsappChatSupport
                                              ? FittedBox(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await launch(
                                                          "https://wa.me/+91${vendorProvider.mobileNumber}");
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Image.asset(
                                                        "images/whatsapp.png",
                                                        height: 22,
                                                        width: 22,
                                                        color: Provider.of<
                                                                    CustomColor>(
                                                                context)
                                                            .appPrimaryMaterialColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          Space(width: 25)
                                        ],
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Space(
                                    height: 12,
                                  ),
                                  if (banners.length > 0)
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    child: Image.network(
                                                      "${StringConstants.api_url}${bannerData.bannerUrl}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  if (banners.length > 0) Space(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 23),
                                    child: Row(
                                      mainAxisAlignment:
                                          (MediaQuery.of(context).size.width >
                                                  450)
                                              ? MainAxisAlignment.center
                                              : MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText.rich(
                                          TextSpan(
                                            text: "Shop Timing : ",
                                            style: FontsTheme.descriptionText(
                                                fontWeight: FontWeight.w500,
                                                size: 10),
                                            children: [
                                              vendorProvider.businessHours
                                                          .length ==
                                                      0
                                                  ? TextSpan(
                                                      text: "  Open",
                                                      style:
                                                          FontsTheme.gilroyText(
                                                        color: Colors.black54,
                                                        size: 11,
                                                      ),
                                                    )
                                                  : TextSpan(
                                                      text: getShopTimingStatus(
                                                          vendorProvider),
                                                      style:
                                                          FontsTheme.gilroyText(
                                                        color: Colors.black54,
                                                        size: 11,
                                                      ),
                                                    )
                                            ],
                                          ),
                                          minFontSize: 6,
                                        ),
                                        Space(width: 10),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              "Location:",
                                              style: FontsTheme.descriptionText(
                                                  fontWeight: FontWeight.w500,
                                                  size: 10),
                                              minFontSize: 8,
                                            ),
                                            Icon(Icons.directions,
                                                size: 18,
                                                color: Provider.of<CustomColor>(
                                                        context)
                                                    .appPrimaryMaterialColor),
                                            InkWell(
                                              onTap: () {
                                                launch(
                                                    "https://maps.google.com/?q=${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.latitude.toString()},${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.longitude.toString()}");
                                              },
                                              child: AutoSizeText(" Direction",
                                                  minFontSize: 8,
                                                  style: FontsTheme.gilroyText(
                                                    size: 12,
                                                    color: Provider.of<
                                                                CustomColor>(
                                                            context)
                                                        .appPrimaryMaterialColor,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
                                      padding: const EdgeInsets.all(10),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.white,
                                        highlightColor: Colors.grey[300]!,
                                        period: Duration(seconds: 2),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          height: 100,
                                          decoration: ShapeDecoration(
                                            color: Colors.grey[300]!,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : trendingProducts.length != 0
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 15, bottom: 5),
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
                                    top: 0, bottom: 15, right: 4, left: 9),
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
                        toolbarHeight: 40,
                        expandedHeight: 40,
                        flexibleSpace: TopButtons(onChanged: (value) {
                          setState(() {
                            isGrid = value;
                          });
                        }, onClick: (value) {
                          _getCategoryWiseProduct(value);
                        }),
                        automaticallyImplyLeading: false,
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isLoadingCate
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.white,
                                        highlightColor: Colors.grey[300]!,
                                        period: Duration(seconds: 2),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          height: 100,
                                          decoration: ShapeDecoration(
                                            color: Colors.grey[300]!,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : productDataList.length == 0
                                    ? SizedBox()
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        padding: EdgeInsets.only(
                                          left: 15,
                                          top: 15,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Categories",
                                                style: FontsTheme.boldTextStyle(
                                                    size: 15)),
                                            Container(
                                              height: 100,
                                              margin: EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    productDataList.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, item) =>
                                                    InkWell(
                                                  onTap: () {
                                                    context.go(helper(PageCollection
                                                            .categories +
                                                        '/${productDataList.elementAt(item).categoryId}'));
                                                  },
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 4.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          child:
                                                              CachedNetworkImage(
                                                            height: 100,
                                                            width: 100,
                                                            imageUrl:
                                                                "${StringConstants.api_url}${productDataList.elementAt(item).categoryImageUrl}",
                                                            fit: BoxFit.fill,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    SizedBox(
                                                              width: 8,
                                                              height: 8,
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Image.asset(
                                                              'images/placeholdersquare.jpg',
                                                              height: 100,
                                                              width: 100,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        height: 100,
                                                        width: 100,
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 8,
                                                                left: 10,
                                                                right: 10,
                                                                top: 8),
                                                        margin: EdgeInsets.only(
                                                            top: 4,
                                                            right: 5,
                                                            left: 0),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          gradient: LinearGradient(
                                                              colors: [
                                                                Colors
                                                                    .transparent,
                                                                Colors.black87
                                                              ],
                                                              stops: [
                                                                0.4,
                                                                0.8
                                                              ],
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              tileMode: TileMode
                                                                  .clamp),
                                                        ),
                                                        child: Text(
                                                          "${productDataList.elementAt(item).categoryName}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                          ),
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                            Container(
                              color: Colors.white,
                              child: isLoadingRece
                                  ? Center(
                                      child: SizedBox(width: 12, height: 12),
                                    )
                                  : recentlyBought.length == 0
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 8,
                                              bottom: 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TitleViewAll(
                                                title: "Recently bought",
                                                onPressed: () {},
                                                isViewAll: false,
                                              ),
                                              SizedBox(
                                                height: 222,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          recentlyBought.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return RecentlyBought(
                                                          productData:
                                                              recentlyBought
                                                                  .elementAt(
                                                                      index),
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                            ),
                            isLoadingCate
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.white,
                                        highlightColor: Colors.grey[300]!,
                                        period: Duration(seconds: 2),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          height: 200,
                                          decoration: ShapeDecoration(
                                            color: Colors.grey[300]!,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : categoryWiseProducts(),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text("No Vendor Found"),
                  )
            : Center(
                child: Column(
                  children: [
                    if (vendorProvider != null)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        GoRouter.of(context).go('/' +
                                            storeConcat(
                                                PageCollection.about_us));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              child: CachedNetworkImage(
                                                height: 45,
                                                width: 45,
                                                imageUrl:
                                                    "${StringConstants.api_url}${vendorProvider.logo}",
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) {
                                                  return SizedBox(
                                                    width: 12,
                                                    height: 12,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.map),
                                              ),
                                            ),
                                            Space(width: 8.0),
                                            AutoSizeText(
                                              "${vendorProvider.businessName}",
                                              minFontSize: 6,
                                              style: FontsTheme.gilroyText(
                                                  size: 17,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          child: InkWell(
                                            onTap: () async {
                                              await launch(
                                                  'tel: ${vendorProvider.mobileNumber}');
                                            },
                                            child: Icon(Icons.call,
                                                color: Provider.of<CustomColor>(
                                                        context)
                                                    .appPrimaryMaterialColor),
                                          ),
                                        ),
                                        vendorProvider.isWhatsappChatSupport
                                            ? Space(width: 11)
                                            : Container(),
                                        vendorProvider.isWhatsappChatSupport
                                            ? Container(
                                                height: 18,
                                                width: 0.9,
                                                color: Colors.grey)
                                            : Container(),
                                        vendorProvider.isWhatsappChatSupport
                                            ? Space(width: 11)
                                            : Container(),
                                        vendorProvider.isWhatsappChatSupport
                                            ? FittedBox(
                                                child: InkWell(
                                                  onTap: () async {
                                                    await launch(
                                                        "https://wa.me/+91${vendorProvider.mobileNumber}");
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4.0),
                                                    child: Image.asset(
                                                      "images/whatsapp.png",
                                                      height: 22,
                                                      width: 22,
                                                      color: Provider.of<
                                                                  CustomColor>(
                                                              context)
                                                          .appPrimaryMaterialColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Space(width: 25)
                                      ],
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                                Space(
                                  height: 12,
                                ),
                                if (banners.length > 0)
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                                  "${StringConstants.api_url}${bannerData.bannerUrl}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                                  ),
                                if (banners.length > 0) Space(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 23),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText.rich(
                                        TextSpan(
                                          text: "Shop Timing :",
                                          style: FontsTheme.descriptionText(
                                              fontWeight: FontWeight.w500),
                                          children: [
                                            vendorProvider
                                                        .businessHours.length ==
                                                    0
                                                ? TextSpan(
                                                    text: "  Open",
                                                    style:
                                                        FontsTheme.valueStyle(
                                                            color:
                                                                Colors.black54,
                                                            size: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  )
                                                : TextSpan(
                                                    text: getShopTimingStatus(
                                                        vendorProvider),
                                                    style:
                                                        FontsTheme.valueStyle(
                                                            color:
                                                                Colors.black54,
                                                            size: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  )
                                          ],
                                        ),
                                      ),
                                      Space(width: 20),
                                      Row(
                                        children: [
                                          AutoSizeText.rich(
                                            TextSpan(
                                              text: "Location:",
                                              style: FontsTheme.descriptionText(
                                                  fontWeight: FontWeight.w500,
                                                  size: 10),
                                            ),
                                          ),
                                          Icon(Icons.directions,
                                              size: 18,
                                              color: Provider.of<CustomColor>(
                                                      context)
                                                  .appPrimaryMaterialColor),
                                          FittedBox(
                                            child: InkWell(
                                              onTap: () {
                                                launch(
                                                    "https://maps.google.com/?q=${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.latitude.toString()},${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.longitude.toString()}");
                                              },
                                              child: Text(
                                                " Direction",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Provider.of<
                                                                CustomColor>(
                                                            context)
                                                        .appPrimaryMaterialColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Space(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (vendorProvider != null)
                      (getShopTimingStatus(vendorProvider).toLowerCase() ==
                              "offline"
                          // context.watch<VendorModelWrapper>().isLoaded &&
                          //         !isShopLoading
                          )
                          ? Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Shop is Offline"),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget categoryWiseProducts() {
    return productDataList.length == 0
        ? Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.43,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "images/error.svg",
                  color:
                      Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                  width: 30,
                  height: 30,
                ),
                Text("No Products Available"),
              ],
            ),
          )
        : Container(
            // margin: EdgeInsets.only(bottom: 80),
            padding: EdgeInsets.only(left: 5, top: 3, bottom: 80),
            color: Colors.white,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productDataList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleViewAll(
                        title:
                            "${productDataList.elementAt(index).categoryName}",
                        onPressed: () {
                          context.go(helper(PageCollection.categories +
                              '/${productDataList.elementAt(index).categoryId}'));
                        },
                        isViewAll: true,
                      ),
                      SizedBox(
                        height: isGrid ? 254 : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: ListView.builder(
                            shrinkWrap: isGrid ? false : true,
                            physics: isGrid
                                ? AlwaysScrollableScrollPhysics()
                                : NeverScrollableScrollPhysics(),
                            scrollDirection:
                                isGrid ? Axis.horizontal : Axis.vertical,
                            itemCount: productDataList
                                .elementAt(index)
                                .productDetails
                                .length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  context.go(helper(PageCollection.product +
                                      '/${productDataList.elementAt(index).productDetails.elementAt(i).productId}'));
                                },
                                child: isGrid
                                    ? ProductComponentGrid(
                                        productData: productDataList
                                            .elementAt(index)
                                            .productDetails
                                            .elementAt(i),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: ProductComponentList(
                                          productData: productDataList
                                              .elementAt(index)
                                              .productDetails
                                              .elementAt(i),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
