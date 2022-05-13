import 'dart:developer';
import 'dart:html';
import 'dart:math' as math;
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:multi_vendor_customer/Views/OrderSuccess.dart';
import 'package:provider/provider.dart';
import 'dart:convert' show base64, json, utf8;

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
  String? vendorPaymentId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<VendorModelWrapper>().vendorModel!.isOnlinePayment) {
        _generateOrderId();
        _getPaymentID();
      }
    });
  }

  _generateOrderId() async {
    var cartProvider = Provider.of<CartDataWrapper>(context, listen: false);
    var vendorProviderDumb =
        Provider.of<VendorModelWrapper>(context, listen: false);
    setState(() {
      isLoadingOrderId = true;
    });
    await PaymentController.generateOrderId(
            cartProvider.totalAmount.roundOff() +
                cartProvider.getDeliveryCharges(
                    vendorProviderDumb.vendorModel!.freeDeliveryAboveAmount,
                    vendorProviderDumb.vendorModel!.deliveryCharges) +
                cartProvider.tax.roundOff())
        .then((value) {
      if (value != null) {
        setState(() {
          isLoadingOrderId = false;
          orderId = value.orderId;
          token = value.cftoken;
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

  _getPaymentID() async {
    setState(() {
      isLoadingOrderId = true;
    });
    await PaymentController.getBankDetails().then((value) {
      if (value.data != null) {
        setState(() {
          isLoadingOrderId = false;
          vendorPaymentId = value.data!.vendorPaymentId;
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
    var cartProvider = Provider.of<CartDataWrapper>(context, listen: false);
    var vendorProviderDumb =
        Provider.of<VendorModelWrapper>(context, listen: false);

    setState(() {
      isLoadingOrderId = true;
    });
    await OrderController.addOrder(
            type: "$type",
            address: widget.address,
            refNo: orderId ?? "",
            couponAmount: cartProvider.isCouponApplied == true
                ? cartProvider.discount
                : 0,
            orders: cartProvider.cartData,
            couponId: "",
            deliveryCharge: type == 'TAKEAWAY' ||
                    ((cartProvider.totalAmount >
                            vendorProviderDumb
                                .vendorModel!.freeDeliveryAboveAmount) &&
                        vendorProviderDumb
                                .vendorModel!.freeDeliveryAboveAmount >
                            0)
                ? 0.0
                : vendorProviderDumb.vendorModel!.isDeliveryCharges
                    ? vendorProviderDumb.vendorModel!.deliveryCharges
                    : 0,
            orderAmount: type == 'TAKEAWAY'
                ? cartProvider.totalAmount.roundOff() +
                    cartProvider.tax.roundOff()
                : cartProvider.totalAmount.roundOff() +
                    cartProvider.getDeliveryCharges(
                        vendorProviderDumb.vendorModel!.freeDeliveryAboveAmount,
                        vendorProviderDumb.vendorModel!.deliveryCharges) +
                    cartProvider.tax.roundOff(),
            paidAmount: type == 'PAY_ONLINE'
                ? cartProvider.totalAmount.roundOff() +
                    cartProvider.getDeliveryCharges(
                        vendorProviderDumb.vendorModel!.freeDeliveryAboveAmount,
                        vendorProviderDumb.vendorModel!.deliveryCharges) +
                    cartProvider.tax.roundOff()
                : 0,
            refundAmount: 0,
            taxAmount: cartProvider.tax,
            taxPercentage: List.generate(sharedPrefs.taxName.length, (index) {
              return SimpleTaxModel(
                taxName: sharedPrefs.taxName[index],
                taxPercentage: int.parse(sharedPrefs.tax[index]),
                amount: (int.parse(sharedPrefs.tax[index]) *
                        (cartProvider.totalAmount)) /
                    100,
              );
            }),
            totalAmount: cartProvider.totalAmount)
        .then((value) {
      if (value.success) {
        setState(() {
          isLoadingOrderId = false;
          Fluttertoast.showToast(
              msg: "Order Success",
              webPosition: "center",
              webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
          cartProvider.cartData.clear();
          cartProvider.loadCartData();

          // _verifyPayment();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => OrderSuccess()));
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
        Fluttertoast.showToast(
            msg: "${value.data!.orderId}",
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
    var themeProvider = Provider.of<ThemeColorProvider>(context);
    var vendorProvider = context.watch<VendorModelWrapper>();
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
          width: MediaQuery.of(context).size.width,
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
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: const Text(
                        'Cash on Delivery',
                        style: TextStyle(fontSize: 12),
                      ),
                      leading: Transform.scale(
                        scale: 0.92,
                        child: Radio<paymentMethods>(
                          activeColor: themeProvider.appPrimaryMaterialColor,
                          value: paymentMethods.COD,
                          groupValue: _selection,
                          onChanged: (paymentMethods? value) {
                            setState(
                              () {
                                _selection = value!;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                if (orderId != null &&
                    vendorProvider.vendorModel!.isOnlinePayment &&
                    vendorPaymentId != null)
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                if (orderId != null &&
                    vendorProvider.vendorModel!.isOnlinePayment &&
                    vendorPaymentId != null)
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selection = paymentMethods.PAY_ONLINE;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              vendorProvider.vendorModel!.isStorePickupEnable
                                  ? 0
                                  : 5.0),
                      child: ListTile(
                        dense: true,
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: const Text(
                          'Pay Online',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Transform.scale(
                          scale: 0.92,
                          child: Radio<paymentMethods>(
                            value: paymentMethods.PAY_ONLINE,
                            activeColor: themeProvider.appPrimaryMaterialColor,
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
                if (vendorProvider.vendorModel!.isStorePickupEnable)
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                if (vendorProvider.vendorModel!.isStorePickupEnable)
                  InkWell(
                    onTap: () {
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
                          'Take Away',
                          style: TextStyle(fontSize: 12),
                        ),
                        leading: Transform.scale(
                          scale: 0.92,
                          child: Radio<paymentMethods>(
                            value: paymentMethods.TAKEAWAY,
                            activeColor: themeProvider.appPrimaryMaterialColor,
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
                        if (_selection == paymentMethods.TAKEAWAY) {
                          _addOrder("TAKEAWAY");
                        }
                        if (_selection == paymentMethods.COD) {
                          _addOrder("COD");
                        }
                        if (_selection == paymentMethods.PAY_ONLINE) {
                          String stage = "PROD";
                          // String stage = "TEST";
                          String customerName = sharedPrefs.customer_name;
                          String orderNote = "Order Note";
                          String orderCurrency = "INR";
                          //prod app id
                          String appId = "20382800473cf07d7fe70e2e08828302";
                          //test app id
                          // String appId = "155112560e54c0c53e63a913e2211551";
                          String customerPhone = sharedPrefs.customer_mobileNo;
                          String customerEmail = sharedPrefs.customer_email;
                          String notifyUrl =
                              "https://test.gocashfree.com/notify";

                          var cartProviderDumb = Provider.of<CartDataWrapper>(
                              context,
                              listen: false);

                          var vendorProviderDumb =
                              Provider.of<VendorModelWrapper>(context,
                                  listen: false);
                          print((cartProviderDumb.totalAmount.roundOff() +
                              cartProviderDumb.getDeliveryCharges(
                                  vendorProviderDumb
                                      .vendorModel!.freeDeliveryAboveAmount,
                                  vendorProviderDumb
                                      .vendorModel!.deliveryCharges) +
                              cartProviderDumb.tax.roundOff()));
                          Map<String, dynamic> input = {
                            // "orderId": "veerRochit",
                            "orderId": orderId!,
                            "orderAmount":
                                (cartProviderDumb.totalAmount.roundOff() +
                                        cartProviderDumb.getDeliveryCharges(
                                            vendorProviderDumb.vendorModel!
                                                .freeDeliveryAboveAmount,
                                            vendorProviderDumb
                                                .vendorModel!.deliveryCharges) +
                                        cartProviderDumb.tax.roundOff())
                                    .roundOff()
                                    .toString(),
                            "customerName": customerName,
                            "orderNote": orderNote,
                            "orderCurrency": orderCurrency,
                            "appId": appId,
                            "customerPhone": customerPhone,
                            "customerEmail": customerEmail,
                            "stage": stage,
                            "tokenData": token,
                            // "tokenData": "yJ9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.RLQfiYWY3EjY1gTZwUzNyYjI6ICdsF2cfJCL3kTNwMDN0UjNxojIwhXZiwiIS5USiojI5NmblJnc1NkclRmcvJCLyADMxojI05Wdv1WQyVGZy9mIsICdph2YvJlclVmdiojIklkclRmcvJye.fCK8IDPcbfpxpb8tvftn0GanpceZH46dDhfHy1PMpAMcunQx72C1clHLaYsN0k9rZI",
                            "notifyUrl": notifyUrl,
                            "paymentSplits":
                                "${base64.encode(utf8.encode(json.encode([
                                  {
                                    "vendorId": "$vendorPaymentId",
                                    "percentage": 99
                                  }
                                ])))}"
                          };
                          print("${base64.encode(utf8.encode(json.encode([
                                {"vendorId": '93qqk2whye', "percentage": 99}
                              ])))}");
                          input.addAll(UIMeta().toMap());

                          await CashfreePGSDK.doPayment(input).then((value) {
                            value?.forEach((key, value) {
                              if (kDebugMode) {
                                print("$key : $value");
                              }
                            });
                            if (value?["txStatus"] == "SUCCESS") {
                              _addOrder("PAY_ONLINE");
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Failed payment',
                                webPosition: "center",
                                webBgColor:
                                    "linear-gradient(to right, #5A5A5A, #5A5A5A)",
                              );
                            }
                          });

                          //razorpay payment gate way open
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
                        color: themeProvider.appPrimaryMaterialColor,
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
