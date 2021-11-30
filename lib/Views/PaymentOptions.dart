import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';
import 'package:multi_vendor_customer/Data/Controller/PaymentController.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Utils/DoubleExtension.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/CheckOut.dart';
import 'package:multi_vendor_customer/Views/OrderSuccess.dart';
import 'package:provider/provider.dart';

class PaymentOptions extends StatefulWidget {
  final CustomerAddress address;

  PaymentOptions({
    required this.address,
  });

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

enum paymentMethods { COD, PAY_ONLINE, TAKEAWAY }

class _PaymentOptionsState extends State<PaymentOptions> {
  paymentMethods _selection = paymentMethods.COD;
  bool isLoadingCate = false;
  late String orderId;

  @override
  void initState() {
    super.initState();
    _generateOrderId();
  }

  _generateOrderId() async {
    setState(() {
      isLoadingCate = true;
    });
    await PaymentController.generateOrderId(
        Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount
            .toInt() +
            Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .deliveryCharges
                .toInt() + Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
            .toInt())
        .then((value) {
      if (value.success) {
        print(value.data);
        setState(() {
          isLoadingCate = false;
          orderId = value.data!.orderId.id;
          window.localStorage["orderId"] = orderId;
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
      print(e);
    });
  }

  _addOrder(String type) async {
    setState(() {
      isLoadingCate = true;
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
        deliveryCharge: type == 'TAKEAWAY' || ((Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount > Provider
            .of<VendorModelWrapper>(context, listen: false)
            .vendorModel!
            .freeDeliveryAboveAmount) && Provider
            .of<VendorModelWrapper>(context, listen: false)
            .vendorModel!
            .freeDeliveryAboveAmount > 0) ? 0.0 : Provider
            .of<VendorModelWrapper>(context, listen: false)
            .vendorModel!
            .deliveryCharges,
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
            Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .deliveryCharges
                .roundOff() + Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
            .roundOff(),
        paidAmount: type == 'PAY_ONLINE'
            ? Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount
            .roundOff()
            + Provider
                .of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .deliveryCharges
                .roundOff() + Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
            .roundOff()
            : 0,
        refundAmount: 0,
        taxAmount: Provider
            .of<CartDataWrapper>(context, listen: false)
            .tax
        ,
        taxPercentage: Provider
            .of<CartDataWrapper>(context, listen: false)
            .taxPercentage,
        totalAmount: Provider
            .of<CartDataWrapper>(context, listen: false)
            .totalAmount
    )
        .then((value) {
      if (value.success) {
        setState(() {
          isLoadingCate = false;
          Fluttertoast.showToast(msg: "Order Success");
          Provider
              .of<CartDataWrapper>(context, listen: false)
              .cartData
              .clear();
          Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
              vendorId: "${sharedPrefs.vendor_uniq_id}");

          print("payment id  ${window.localStorage["payment_id"]}");
          print("order id  ${window.localStorage["order_Id"]}");
          print("signature ${window.localStorage["signature"]}");
          _verifyPayment();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => OrderSuccess()));
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (_) => OrderSuccess()));
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
      print(e);
    });
  }

  _verifyPayment() async {
    await PaymentController.paymentVerify().then((value) {
      if (value.success) {
        print(value.data);

        isLoadingCate = false;
        Fluttertoast.showToast(msg: "${value.data!.orderId}");
        orderId = value.data!.orderId;
        window.localStorage["orderId"] = orderId;
      } else {}
    }, onError: (e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Payment Method",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  title: const Text(
                    'Cash on Delivery', style: TextStyle(fontSize: 12),),
                  leading: Radio<paymentMethods>(
                    activeColor: Provider
                        .of<CustomColor>(context)
                        .appPrimaryMaterialColor,
                    value: paymentMethods.COD,
                    groupValue: _selection,
                    onChanged: (paymentMethods? value) {
                      setState(() {
                        _selection = value!;
                        print(value);
                      },);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                ListTile(
                  title: const Text(
                    'Pay Online', style: TextStyle(fontSize: 12),),
                  leading: Radio<paymentMethods>(
                    value: paymentMethods.PAY_ONLINE,
                    activeColor: Provider
                        .of<CustomColor>(context)
                        .appPrimaryMaterialColor,
                    groupValue: _selection,
                    onChanged: (paymentMethods? value) {
                      setState(() {
                        _selection = value!;
                        print(value);
                      });
                    },
                  ),
                ),
                if(Provider
                    .of<VendorModelWrapper>(context)
                    .vendorModel!
                    .isStorePickupEnable)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(),
                  ),
                if(Provider
                    .of<VendorModelWrapper>(context)
                    .vendorModel!
                    .isStorePickupEnable)
                  ListTile(
                    title: const Text(
                      'Take Away', style: TextStyle(fontSize: 12),),
                    leading: Radio<paymentMethods>(
                      value: paymentMethods.TAKEAWAY,
                      activeColor: Provider
                          .of<CustomColor>(context)
                          .appPrimaryMaterialColor,
                      groupValue: _selection,
                      onChanged: (paymentMethods? value) {
                        setState(() {
                          _selection = value!;
                          print(value);
                        });
                      },
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
              child: isLoadingCate
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : InkWell(
                onTap: () {
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return WebPayment(
                          price: Provider
                              .of<CartDataWrapper>(context,
                              listen: false)
                              .totalAmount
                              .toInt() *
                              100,
                          name: sharedPrefs.customer_name,
                          image:
                          "${StringConstants.api_url}${sharedPrefs.logo}",
                          addOrder: _addOrder,
                          orderId: orderId,
                        );
                      },
                    ),
                    );
                  }
                },
                child: Container(
                  height: 48,
                  color: Provider
                      .of<CustomColor>(context)
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
