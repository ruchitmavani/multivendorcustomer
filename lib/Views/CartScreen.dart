import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/RoundedAddRemove.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Data/Controller/CartController.dart';
import 'package:multi_vendor_customer/Data/Controller/CouponController.dart';
import 'package:multi_vendor_customer/Data/Controller/CustomerController.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/exports.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  bool isLoadingCustomer = false;
  bool isLoadingCoupon = false;
  int addressIndex = 0;
  List<CartDataModel> productData = [];
  CustomerDataModel customerData = CustomerDataModel(
      customerName: "",
      customerEmailAddress: "",
      customerMobileNumber: "",
      customerAddress: [],
      id: "",
      customerUniqId: "",
      customerDob: DateTime.now());
  TextEditingController couponText = TextEditingController();

  _loadCartData() async {
    print("Calling");
    setState(() {
      isLoading = true;
    });
    // await CartController.getCartData(customerId: "${sharedPrefs.customer_id}",vendorId: Provider.of<VendorModelWrapper>(context,listen: false).vendorModel!.vendorUniqId).then((value) {
    //   if (value.success) {
    //     print(value.success);
    //     setState(() {
    //       productData = value.data!;
    //       isLoading = false;
    //     });
    //   }else{
    //     setState(() {
    //       isLoading=false;
    //     });
    //   }
    // }, onError: (e) {
    //   print(e);
    //   setState(() {
    //     isLoading = false;
    //   });
    // });

    if (sharedPrefs.customer_id.isEmpty) {
      return;
    }
    print(
        "vendor ${Provider.of<VendorModelWrapper>(context, listen: false).vendorModel!.vendorUniqId}");
    await CartController.getCartData(
            customerId: "${sharedPrefs.customer_id}",
            vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .vendorUniqId)
        .then((value) {
      if (value.success) {
        print("cart ====== ${value.success}");
        print(value.data);
        productData = value.data!;
        setState(() {
          isLoading = false;
        });
      } else {}
    }, onError: (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    });
  }

  _loadCustomerData() async {
    print("Calling");
    setState(() {
      isLoadingCustomer = true;
    });
    await CustomerController.getCustomerData("${sharedPrefs.customer_id}").then(
        (value) {
      if (value.success) {
        print(value.success);
        setState(() {
          customerData = value.data;
          isLoadingCustomer = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoadingCustomer = false;
      });
    });
  }

  _verifyCoupon() async {
    print("Calling");
    setState(() {
      isLoadingCoupon = true;
    });
    await CouponController.validateCoupon(
            vendorId: "657202115727_9429828152",
            customerId: "${sharedPrefs.customer_id}",
            couponName: "${couponText.text}")
        .then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          isLoadingCoupon = false;
        });
        // Navigator.of(context).pushNamed(PageCollection.cart);
      } else {
        Fluttertoast.showToast(msg: "${value.message}");
      }
    }, onError: (e) {
      setState(() {
        isLoadingCoupon = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCartData();
    _loadCustomerData();
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
                          child: Icon(Icons.close, size: 16),
                          backgroundColor: Colors.white),
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
                    child: SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Select Address Below",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'popins',
                                  fontWeight: FontWeight.w700),
                            ),
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
                                  color: Colors.grey.shade200,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${customerData.customerAddress.elementAt(index).type}",
                                          style: FontsTheme.boldTextStyle(
                                              size: 13)),
                                      Text(
                                          "${customerData.customerAddress.elementAt(index).subAddress}",
                                          style: FontsTheme.descriptionText(
                                              size: 13, color: Colors.black87)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
                          child: Icon(Icons.close, size: 16),
                          backgroundColor: Colors.white),
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
                    child: SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 0),
                            child: Text(
                              "Enter Offer Coupon",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'popins',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyTextFormField(
                              controller: couponText,
                              maxLines: 1,
                              hintText: "Enter Coupon",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _verifyCoupon();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Apply"),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    couponText.clear();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Cancel"),
                                  ),
                                ),
                              ],
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
      child: Container(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(AppIcons.offer),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: Text("Apply coupon",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: Colors.black87,
                            fontWeight: FontWeight.w600)),
                  )),
                  Text(
                    "View",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 11,
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )),
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cart",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Delivery address",
                          style: FontsTheme.descriptionText(
                              size: 13, color: Colors.black54)),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: isLoadingCustomer
                            ? CircularProgressIndicator()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${customerData.customerAddress.elementAt(addressIndex).type}",
                                    style: FontsTheme.boldTextStyle(size: 13),
                                  ),
                                  changeAddress(),
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: isLoadingCustomer
                            ? CircularProgressIndicator()
                            : Text(
                                "${customerData.customerAddress.elementAt(addressIndex).subAddress}",
                                style: FontsTheme.descriptionText(
                                    size: 13, color: Colors.black87),
                              ),
                      ),
                    ],
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.vertical,
                      itemCount: productData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                StringConstants.API_URL +
                                    "${productData.elementAt(index).productDetails.first.productImageUrl.first}",
                                width: 55,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${productData.elementAt(index).productDetails.first.productName}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600)),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "\u{20B9}",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Colors.red.shade700,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationThickness: 3,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "${productData.elementAt(index).productDetails.first.productMrp}",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "\u{20B9}",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.black87,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "${productData.elementAt(index).productDetails.first.productSellingPrice}",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              RoundedAddRemove(productData
                                                  .elementAt(index)
                                                  .productQuantity),
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
              applyCoupon(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: SizedBox(
                        height: 25,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text("Discount Applied"),
                          trailing: Text("- \u{20B9}256.00"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SizedBox(
                        height: 25,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text("Tax"),
                          trailing: Text("\u{20B9}256.00"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SizedBox(
                        height: 25,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text("Shipping Fee"),
                          trailing: Text("\u{20B9}256.00"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SizedBox(
                        height: 35,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            "Total",
                            style: FontsTheme.boldTextStyle(
                              size: 14,
                            ),
                          ),
                          trailing: Text(
                            "\u{20B9}316.00",
                            style: FontsTheme.boldTextStyle(
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\u{20B9}",
                      style: TextStyle(
                          fontFamily: "", fontSize: 17, color: Colors.black87),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        "250.00",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 48,
                // width: MediaQuery.of(context).size.width,
                width: 150,
                color: appPrimaryMaterialColor,
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
          ],
        ),
      ),
    );
  }
}
