import 'dart:developer';
import 'dart:html';
import 'dart:math' as math;

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';
import 'package:multi_vendor_customer/Data/Controller/PaymentController.dart';
import 'package:multi_vendor_customer/Data/Models/AddressModel.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Utils/DoubleExtension.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/CheckOut.dart';
import 'package:multi_vendor_customer/Views/OrderSuccess.dart';
import 'package:provider/provider.dart';

class PaymentOptions extends StatefulWidget {
  final Address address;

  PaymentOptions({
    required this.address,
  });

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

enum paymentMethods { COD, PAY_ONLINE, TAKEAWAY }

class _PaymentOptionsState extends State<PaymentOptions> {
  paymentMethods _selection = paymentMethods.COD;
  bool isLoadingOrderId = false;
  String? orderId;
  String token = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _generateOrderId();
    });
  }

  _generateCashFreeOrderId() async {
    setState(() {
      isLoadingOrderId = true;
    });
  }

  _generateOrderId() async {
    setState(() {
      isLoadingOrderId = true;
    });
    await PaymentController.generateOrderId(
        Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount
            .toInt() +
            Provider.of<CartDataWrapper>(context, listen: false)
                .getDeliveryCharges(Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .freeDeliveryAboveAmount, Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .deliveryCharges
            )
            + Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
            .toInt())
        .then((value) {
      if (value.isNotEmpty) {
        setState(() {
          isLoadingOrderId = false;
          orderId = value["orderID"]!;
          token = value["token"];
          window.localStorage["orderId"] = orderId!;
        });
      } else {
        setState(() {
          isLoadingOrderId = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoadingOrderId = false;
      });
      log(e.toString());
    });
  }

  _addOrder(String type) async {
    setState(() {
      isLoadingOrderId = true;
    });
    await OrderController.addOrder(
        type: "$type",
        address: widget.address,
        couponAmount:
        Provider
            .of<CartDataWrapper>(context, listen: false)
            .isCouponApplied == true
            ? Provider
            .of<CartDataWrapper>(context, listen: false)
            .discount
            : 0,
        orders:
        Provider
            .of<CartDataWrapper>(context, listen: false)
            .cartData,
        couponId: "",
        deliveryCharge: type == 'TAKEAWAY' ||
            ((Provider
                .of<CartDataWrapper>(context, listen: false)
                .totalAmount > Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .freeDeliveryAboveAmount)
                && Provider
                    .of<VendorModelWrapper>(context, listen: false)
                    .vendorModel!
                    .freeDeliveryAboveAmount > 0) ? 0.0 :
        Provider
            .of<VendorModelWrapper>(context, listen: false)
            .vendorModel!
            .isDeliveryCharges ? Provider
            .of<VendorModelWrapper>(context, listen: false)
            .vendorModel!
            .deliveryCharges : 0,
        orderAmount: type == 'TAKEAWAY'
            ? Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount
            .roundOff() + Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
            .roundOff()
            : Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount
            .roundOff()
            +
            Provider.of<CartDataWrapper>(context, listen: false)
                .getDeliveryCharges(Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .freeDeliveryAboveAmount, Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .deliveryCharges
            ) + Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
            .roundOff(),
        paidAmount: type == 'PAY_ONLINE'
            ? Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount
            .roundOff()
            + Provider.of<CartDataWrapper>(context, listen: false)
                .getDeliveryCharges(Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .freeDeliveryAboveAmount, Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .deliveryCharges
            ) + Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
            .roundOff()
            : 0,
        refundAmount: 0,
        taxAmount: Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
        ,
        taxPercentage: List.generate(sharedPrefs.taxName.length, (index) {
          return SimpleTaxModel(
            taxName: sharedPrefs.taxName[index],
            taxPercentage: int.parse(sharedPrefs.tax[index]),
            amount: (int.parse(sharedPrefs.tax[index]) * (Provider
                .of<CartDataWrapper>(context, listen: false)
                .totalAmount)) / 100,
          );
        }),
        totalAmount: Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount
    )
        .then((value) {
      if (value.success) {
        setState(() {
          isLoadingOrderId = false;
          Fluttertoast.showToast(msg: "Order Success",
              webPosition: "center",
              webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
          Provider
              .of<CartDataWrapper>(context, listen: false)
              .cartData
              .clear();
          Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
          );

          // _verifyPayment();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => OrderSuccess()));
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (_) => OrderSuccess()));
        });
      } else {
        setState(() {
          isLoadingOrderId = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoadingOrderId = false;
      });
      log(e.toString());
    });
  }

  _verifyPayment() async {
    await PaymentController.paymentVerify().then((value) {
      if (value.success) {
        isLoadingOrderId = false;
        Fluttertoast.showToast(msg: "${value.data!.orderId}",
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
        orderId = value.data!.orderId;
        window.localStorage["orderId"] = orderId!;
      } else {}
    }, onError: (e) {
      log(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Choose Payment Method",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selection = paymentMethods.COD;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: (orderId == null) ? 0 : 5.0),
                    child: ListTile(
                      dense: true,
                      visualDensity:
                      VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Cash on Delivery', style: TextStyle(fontSize: 12),),
                      leading: Transform.scale(
                        scale: 0.92,

                        child: Radio<paymentMethods>(
                          activeColor: Provider
                              .of<ThemeColorProvider>(context)
                              .appPrimaryMaterialColor,
                          value: paymentMethods.COD,
                          groupValue: _selection,
                          onChanged: (paymentMethods? value) {
                            setState(() {
                              _selection = value!;
                            },);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                if(orderId != null)
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                if(orderId != null)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selection = paymentMethods.PAY_ONLINE;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Provider
                          .of<VendorModelWrapper>(context)
                          .vendorModel!
                          .isStorePickupEnable ? 0 : 5.0),
                      child: ListTile(
                        dense: true,
                        visualDensity:
                        VisualDensity(horizontal: 0, vertical: -4),
                        title: const Text(
                          'Pay Online', style: TextStyle(fontSize: 12),),
                        leading: Transform.scale(
                          scale: 0.92,
                          child: Radio<paymentMethods>(
                            value: paymentMethods.PAY_ONLINE,
                            activeColor: Provider
                                .of<ThemeColorProvider>(context)
                                .appPrimaryMaterialColor,
                            groupValue: _selection,
                            onChanged: (paymentMethods? value) {
                              setState(() {
                                _selection = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                if(Provider
                    .of<VendorModelWrapper>(context)
                    .vendorModel!
                    .isStorePickupEnable)
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                if(Provider
                    .of<VendorModelWrapper>(context)
                    .vendorModel!
                    .isStorePickupEnable)
                  InkWell(onTap: () {
                    setState(() {
                      _selection = paymentMethods.TAKEAWAY;
                    });
                  },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: ListTile(
                        dense: true,
                        visualDensity:
                        VisualDensity(horizontal: 0, vertical: -4),
                        title: const Text(
                          'Take Away', style: TextStyle(fontSize: 12),),
                        leading: Transform.scale(
                          scale: 0.92,
                          child: Radio<paymentMethods>(
                            value: paymentMethods.TAKEAWAY,
                            activeColor: Provider
                                .of<ThemeColorProvider>(context)
                                .appPrimaryMaterialColor,
                            groupValue: _selection,
                            onChanged: (paymentMethods? value) {
                              setState(() {
                                _selection = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
              child: isLoadingOrderId
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : InkWell(
                onTap: () async {
                  if (_selection
                      .toString()
                      .split(".")
                      .last ==
                      "TAKEAWAY") {
                    _addOrder("TAKEAWAY");
                  }
                  if (_selection
                      .toString()
                      .split(".")
                      .last == "COD") {
                    _addOrder("COD");
                  }
                  if (_selection
                      .toString()
                      .split(".")
                      .last ==
                      "PAY_ONLINE") {
                    //todo navigate to payment gateway
                    String stage = "TEST";
                    String orderAmount = Provider
                        .of<CartDataWrapper>(context,
                        listen: false)
                        .totalAmount
                        .toInt()
                        .toString();
                    String customerName = sharedPrefs.customer_name;
                    String orderNote = "Order Note";
                    String orderCurrency = "INR";
                    String appId = "155112560e54c0c53e63a913e2211551";
                    String customerPhone = sharedPrefs.customer_mobileNo;
                    String customerEmail = sharedPrefs.customer_email;
                    String notifyUrl = "https://test.gocashfree.com/notify";


                    Map<String, dynamic> input = {
                      "orderId": orderId!,
                      "orderAmount": (Provider
                          .of<CartDataWrapper>(context, listen: false)
                          .totalAmount
                          .toInt() +
                          Provider.of<CartDataWrapper>(context, listen: false)
                              .getDeliveryCharges(Provider
                              .of<VendorModelWrapper>(context, listen: false)
                              .vendorModel!
                              .freeDeliveryAboveAmount, Provider
                              .of<VendorModelWrapper>(context, listen: false)
                              .vendorModel!
                              .deliveryCharges
                          )
                          + Provider
                              .of<CartDataWrapper>(context, listen: false)
                              .tax
                              .toInt()).toString(),
                      "customerName": customerName,
                      "orderNote": orderNote,
                      "orderCurrency": orderCurrency,
                      "appId": appId,
                      "customerPhone": customerPhone,
                      "customerEmail": customerEmail,
                      "stage": stage,
                      "tokenData": token,
                      "notifyUrl": notifyUrl
                    };

                    input.addAll(UIMeta().toMap());


                    input.forEach((key, value) {
                      print(value);
                    });


                     CashfreePGSDK.doPayment(input).then((value) {
                      print("dfhshgj");
                      value?.forEach((key, value) {
                        if (kDebugMode) {
                          print("$key : $value");
                        }
                      });
                      if(value?["txStatus"]=="SUCCESS"){
                      _addOrder("PAY_ONLINE");}else{
                        Fluttertoast.showToast(msg: 'Failed payment');
                      }
                    });

                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return WebPayment(
                    //       price: Provider
                    //           .of<CartDataWrapper>(context,
                    //           listen: false)
                    //           .totalAmount
                    //           .toInt() *
                    //           100,
                    //       name: sharedPrefs.customer_name,
                    //       image:
                    //       "${StringConstants.api_url}${sharedPrefs.logo}",
                    //       addOrder: _addOrder,
                    //       orderId: orderId!,
                    //     );
                    //   },
                    // ),
                    // );
                  }
                },
                child: Container(
                  height: 48,
                  color: Provider
                      .of<ThemeColorProvider>(context)
                      .appPrimaryMaterialColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Center(
                      child: Text(
                        "Order",
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
      ),
    );
  }
}


class UIMeta {
  String color1 = "#FF233F";
  String color2 = "#033400";
  String hideOrderId = "false";

  static String getRandomNo() {
    var rng = math.Random();
    return 'order ${rng.nextInt(1000000)}';
  }

  Map<String, dynamic> toMap() {
    return {"color1": color1, "color2": color2};
  }

  @override
  String toString() {
    return " \ncolor1 $color1 \ncolor1  $color2  \nhideOrderId $hideOrderId";
  }
}

class Order {
  Order();

  String stage = "TEST";
  String orderId = "newOrder1";
  String orderAmount = "100";
  String tokenData =
      "qU9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.FG0nIwcTNlhTOhJGOhZjM2IiOiQHbhN3XiwyNzcTM0czM1YTM6ICc4VmIsIiUOlkI6ISej5WZyJXdDJXZkJ3biwCMwEjOiQnb19WbBJXZkJ3biwiIxIXZkJ3T3VmbiojIklkclRmcvJye.PvX8Vz4sgTcWei6iw3KuI_i5kwjyfLYyfjhwvZR24Mj1IABwnqU8UJd2CGhGLHMFfG";
  String customerName = "Chirag";
  String orderNote = "Order Note";
  String orderCurrency = "INR";
  String appId = "155112560e54c0c53e63a913e2211551";
  String customerPhone = "8488027477";
  String customerEmail = "ruchit@gmail.com";

  // String cf = "2394153";
  String notifyUrl = "https://test.gocashfree.com/notify";


  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      // "cftoken": cf,
      "notifyUrl": notifyUrl
    };
  }

  @override
  String toString() {
    return " \norderId" +
        orderId +
        " \norderAmount " +
        orderAmount +
        " \ncustomerName " +
        customerName +
        " \norderNote " +
        orderNote +
        " \norderCurrency " +
        orderCurrency +
        " \nappId " +
        appId +
        " \ncustomerPhone " +
        customerPhone +
        " \ncustomerEmail " +
        customerEmail +
        " \nstage " +
        stage +
        " \nnotifyUrl " +
        notifyUrl +
        " \ntokenData " +
        tokenData;
  }
}