import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/RoundedAddRemove.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Data/Controller/CustomerController.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/DoubleExtension.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/AddressComponent.dart';
import 'package:multi_vendor_customer/Views/Components/DiscountTag.dart';
import 'package:multi_vendor_customer/Views/Components/ProductDetailsInCart.dart';
import 'package:multi_vendor_customer/Views/Location.dart';
import 'package:multi_vendor_customer/Views/PaymentOptions.dart';
import 'package:multi_vendor_customer/exports.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Data/Models/AddressModel.dart';
import 'CategorySubScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  bool isLoggedIn = false;
  bool isLoadingCustomer = false;
  bool isLoadingCoupon = false;
  int addressIndex = 0;

  List<CartDataModel> cartData = [];
  CustomerDataModel customerData = CustomerDataModel(
      customerName: "",
      customerEmailAddress: "",
      customerMobileNumber: "",
      customerAddress: [],
      id: "",
      customerUniqId: "",
      customerDob: DateTime.now());
  TextEditingController couponText = TextEditingController();

  TextStyle label = FontsTheme.subTitleStyle(
      color: Colors.black.withOpacity(0.75),
      fontWeight: FontWeight.w600,
      size: 10);

  @override
  void initState() {
    super.initState();
    if (sharedPrefs.customer_id.isNotEmpty) {
      _loadCustomerData();
    }
    sharedPrefs.isLogin().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  _loadCustomerData() async {
    setState(() {
      isLoadingCustomer = true;
    });
    await CustomerController.getCustomerData("${sharedPrefs.customer_id}").then(
            (value) {
          if (value.success) {
            setState(() {
              customerData = value.data;
              addressList.clear();
              for (int i = 0; i < customerData.customerAddress.length; i++) {
                addressList.add(Address(
                    type: customerData.customerAddress
                        .elementAt(i)
                        .type,
                    subAddress:
                    customerData.customerAddress
                        .elementAt(i)
                        .subAddress,
                    area: customerData.customerAddress
                        .elementAt(i)
                        .area,
                    city: customerData.customerAddress
                        .elementAt(i)
                        .city,
                    pinCode: customerData.customerAddress
                        .elementAt(i)
                        .pinCode));
              }
              isLoadingCustomer = false;
            });
          }
        }, onError: (e) {
      setState(() {
        isLoadingCustomer = false;
      });
    });
  }

  Widget changeAddress() {
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        bottom: 8,
                        right: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 16.0, bottom: 6),
                            child: Text(
                              "Select Address Below",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Poppins",
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text("delivers to",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: context
                                        .watch<ThemeColorProvider>()
                                        .appPrimaryMaterialColor)),
                          ),
                          ListView.builder(
                            itemCount: customerData.customerAddress.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    addressIndex = index;
                                  });
                                  if (Navigator.canPop(context))
                                    Navigator.pop(context);
                                },
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .height,
                                  margin: EdgeInsets.only(
                                    bottom: 4,
                                    top: 4,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.grey.shade100),
                                  child: AddressComponent(
                                    addressType: customerData.customerAddress
                                        .elementAt(index)
                                        .type,
                                    address: customerData.customerAddress
                                        .elementAt(index),
                                  ),
                                ),
                              );
                            },
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LocationScreen(
                                        index: 0,
                                        area: "",
                                        city: "",
                                        isEditing: false,
                                        pincode: "",
                                        subAddress: "",
                                        type: "",
                                      ),
                                ),
                              ).then((value) => _loadCustomerData());
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "+ Add Address",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context
                                      .watch<ThemeColorProvider>()
                                      .appPrimaryMaterialColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      },
      child: Text(
        "Change",
        style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 11,
            color: Colors.brown,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget applyCoupon() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Padding(
                padding: MediaQuery
                    .of(context)
                    .viewInsets,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
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
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 0, left: 12),
                            child: Text("Apply Coupon",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyTextFormField(
                              autofocus: true,
                              controller: couponText,
                              lable: "Enter Coupon",
                              maxLines: 1,
                              hintText: "Enter Coupon Code",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, right: 8, left: 8, top: 8),
                            child: Provider
                                .of<CartDataWrapper>(context)
                                .isCouponApplied
                                ? Text(
                              "Apply Coupon Success ????!",
                              style: TextStyle(
                                  color: Provider
                                      .of<ThemeColorProvider>(
                                      context)
                                      .appPrimaryMaterialColor),
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      couponText.clear();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Clear"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Provider.of<CartDataWrapper>(
                                          context,
                                          listen: false)
                                          .verifyCoupon(couponText.text);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Apply"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
          child: Padding(
            padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  AppIcons.offer,
                  size: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Text("Apply coupon",
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Poppins",
                            color: Colors.black87,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Text(
                  "View",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 10,
                      color: Provider
                          .of<ThemeColorProvider>(context)
                          .appPrimaryMaterialColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.grey.shade100),
    );
  }

  Widget transparentBox() {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Text("",
                    style: TextStyle(
                        fontSize: 6,
                        fontFamily: "Poppins",
                        color: Colors.black87,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.grey.shade100);
  }

  @override
  Widget build(BuildContext context) {
    var cartDataProvider = Provider
        .of<CartDataWrapper>(context)
        .cartData;
    var cartProvider = Provider.of<CartDataWrapper>(context);
    var vendorProvider = Provider.of<VendorModelWrapper>(context);
    var themeProvider=Provider.of<ThemeColorProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sharedPrefs.customer_id.isNotEmpty)
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10, left: 12, right: 12),
                  child: isLoadingCustomer
                      ? Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey[300]!,
                      period: Duration(seconds: 2),
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 20,
                        height: 60,
                        decoration: ShapeDecoration(
                          color: Colors.grey[300]!,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Delivery address",
                          style: FontsTheme.descriptionText(
                              size: 11,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal)),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${customerData.customerAddress
                                  .elementAt(addressIndex)
                                  .type}",
                              style: FontsTheme.boldTextStyle(
                                  size: 13, fontWeight: FontWeight.w600),
                            ),
                            changeAddress(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                          "${customerData.customerAddress
                              .elementAt(addressIndex)
                              .subAddress}",
                          style: FontsTheme.descriptionText(
                              size: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Colors.grey.shade200,
              ),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: cartProvider
                    .isLoading
                    ? Center(
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.white,
                        highlightColor: Colors.grey[300]!,
                        period: Duration(seconds: 2),
                        child: Container(
                          margin: EdgeInsets.all(8),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 20,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: Colors.grey[300]!,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : cartDataProvider.length == 0
                    ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 80,
                    child: Image.asset(
                      "images/cartempty.png",
                    ))
                    : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: cartDataProvider.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1,
                    );
                  },
                  itemBuilder: (context, index) {
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
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                          Radius.circular(10.0),
                                          topLeft:
                                          Radius.circular(10.0)),
                                    ),
                                    child: ProductDescriptionInCart(
                                      productId: cartDataProvider
                                          .elementAt(index)
                                          .productId,
                                      color: cartDataProvider
                                          .elementAt(index)
                                          .productColor,
                                      size: cartDataProvider
                                          .elementAt(index)
                                          .productSize,
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            cartDataProvider
                                .elementAt(index)
                                .productImageUrl
                                .length ==
                                0
                                ? Image.asset(
                              'images/placeholdersquare.jpg',
                              height: 55,
                              width: 55,
                              fit: BoxFit.fill,
                            )
                                : CachedNetworkImage(
                              height: 55,
                              width: 55,
                              imageUrl:
                              "${StringConstants.api_url}${cartDataProvider
                                  .elementAt(index)
                                  .productImageUrl
                                  .first}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  SizedBox(
                                    width: 8,
                                    height: 8,
                                    child:
                                    CircularProgressIndicator(),
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                  Image.asset(
                                    'images/placeholdersquare.jpg',
                                    height: 55,
                                    width: 55,
                                    fit: BoxFit.fill,
                                  ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${cartDataProvider
                                                .elementAt(index)
                                                .productName}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                Colors.grey[700],
                                                fontWeight:
                                                FontWeight.w600),
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                        cartDataProvider
                                            .elementAt(index)
                                            .rating !=
                                            0
                                            ? ProductRating(
                                            cartDataProvider
                                                .elementAt(index)
                                                .rating)
                                            : SizedBox(),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: "\u{20B9}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                      "Montserrat",
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      color: Colors
                                                          .red
                                                          .shade700,
                                                      fontSize: 12,
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                      decorationThickness:
                                                      3,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        "${cartDataProvider
                                                            .elementAt(index)
                                                            .productMrp}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "\u{20B9}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        "Montserrat",
                                                        color: Colors
                                                            .black87,
                                                        fontSize: 13,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        "${cartDataProvider
                                                            .elementAt(index)
                                                            .productSellingPrice}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            RoundedAddRemove(
                                              productData:
                                              cartDataProvider
                                                  .elementAt(
                                                  index),
                                              isBulk: cartDataProvider
                                                  .elementAt(index)
                                                  .isBulk,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            if (cartDataProvider
                                                .elementAt(index)
                                                .productMrp >
                                                cartDataProvider
                                                    .elementAt(index)
                                                    .productSellingPrice)
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    right: 10),
                                                child: SizedBox(
                                                  width: 48,
                                                  child: DiscountTag(
                                                      mrp: cartDataProvider
                                                          .elementAt(
                                                          index)
                                                          .productMrp,
                                                      selling: cartDataProvider
                                                          .elementAt(
                                                          index)
                                                          .productSellingPrice),
                                                ),
                                              ),
                                            if (cartDataProvider
                                                .elementAt(index)
                                                .productColor !=
                                                null)
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    right: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Color :  ",
                                                      style: label,
                                                    ),
                                                    Container(
                                                      height: 17,
                                                      width: 17,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                          border: Border.all(
                                                              width:
                                                              0.3,
                                                              color: Colors
                                                                  .grey),
                                                          color: Color(
                                                              cartDataProvider
                                                                  .elementAt(
                                                                  index)
                                                                  .productColor!
                                                                  .colorCode)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            if (cartDataProvider
                                                .elementAt(index)
                                                .productSize !=
                                                null)
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    right: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Size :  ",
                                                      style: label,
                                                    ),
                                                    Container(
                                                      height: 20,
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          6,
                                                          vertical:
                                                          1),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5),
                                                          border: Border.all(
                                                              width:
                                                              1,
                                                              color: Colors
                                                                  .grey)),
                                                      child: Text(
                                                        "${cartDataProvider
                                                            .elementAt(index)
                                                            .productSize!
                                                            .size}",
                                                        style: FontsTheme
                                                            .subTitleStyle(
                                                            color: Colors
                                                                .grey
                                                                .shade400,
                                                            size: 10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (cartDataProvider.length > 0)
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoggedIn) applyCoupon() else
                      transparentBox(),
                    SizedBox(
                      height: 25,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          cartProvider
                              .isCouponApplied
                              ? "Total Savings(${couponText.text}),"
                              : "Total Savings",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: Text(
                          "\u{20B9} ${cartProvider
                              .initialSaving}",
                          style: FontsTheme.digitStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    if (sharedPrefs.tax.length != 0)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: sharedPrefs.tax.length,
                        itemBuilder: (context, i) {
                          return SizedBox(
                            height: 25,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                "${sharedPrefs.taxName.elementAt(
                                    i)}(${sharedPrefs.tax.elementAt(i)}%)",
                                style: FontsTheme.digitStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: Text(
                                "\u{20B9} ${((cartProvider
                                    .tax / cartProvider
                                    .taxPercentage) *
                                    double.parse(sharedPrefs.tax.elementAt(i)))
                                    .roundOff()}",
                                style: FontsTheme.digitStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    vendorProvider.isLoaded
                        ? (vendorProvider.vendorModel!.isDeliveryCharges &&
                        cartProvider
                            .getDeliveryCharges(
                            vendorProvider.vendorModel!
                                .freeDeliveryAboveAmount,
                            vendorProvider
                                .vendorModel!.deliveryCharges) >
                            0)
                        ? SizedBox(
                      height: 25,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          "Shipping Fee(Not applicable in TakeAway)",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        trailing: Text(
                          "\u{20B9} ${vendorProvider.vendorModel!
                              .deliveryCharges}",
                          style: FontsTheme.digitStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                        : SizedBox(
                      height: 25,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          "Free Delivery",
                          style: TextStyle(
                              fontSize: 14, color: Colors.green),
                        ),
                        trailing: Text(
                          "",
                          style: FontsTheme.digitStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                        : Center(child: CircularProgressIndicator()),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
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
                          trailing: Text(
                            cartProvider
                                .isLoading
                                ? "0"
                                : "\u{20B9} ${(cartProvider
                                .totalAmount
                                .roundOff() +
                                cartProvider
                                    .getDeliveryCharges(
                                    vendorProvider.vendorModel!
                                        .freeDeliveryAboveAmount,
                                    vendorProvider.vendorModel!
                                        .deliveryCharges) + cartProvider
                                .tax).roundOff()}",
                            style: FontsTheme.digitStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: cartDataProvider.length > 0
          ? Container(
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              child: Container(
                height: 48,
                color: Colors.white,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\u{20B9}",
                      style: TextStyle(
                          fontFamily: "",
                          fontSize: 17,
                          color: Colors.black87),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        cartProvider
                            .isLoading
                            ? "0"
                            : "${(cartProvider
                            .totalAmount + cartProvider
                            .getDeliveryCharges(
                            vendorProvider.vendorModel!.freeDeliveryAboveAmount,
                            vendorProvider.vendorModel!.deliveryCharges
                                .roundOff()) + cartProvider
                            .tax).roundOff()}",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  if (isLoadingCustomer == false) {
                    if (sharedPrefs.customer_id.isEmpty) {
                      GoRouter.of(context)
                          .go('/' + storeConcat(PageCollection.login));
                      return;
                    }
                    if (Provider
                        .of<CartDataWrapper>(context,
                        listen: false)
                        .totalItems >
                        0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PaymentOptions(
                              address: customerData.customerAddress
                                  .elementAt(addressIndex),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  height: 48,
                  color: themeProvider
                      .appPrimaryMaterialColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Center(
                      child: Text(
                        "PAY",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
          : null,
    );
  }
}
