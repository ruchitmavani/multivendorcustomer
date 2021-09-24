import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:provider/provider.dart';

class PaymentOptions extends StatefulWidget {
  CustomerAddress Address;

  PaymentOptions({
    required this.Address,
  });

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

enum paymentMethods { COD, PAY_ONLINE, TAKEAWAY }

class _PaymentOptionsState extends State<PaymentOptions> {
  paymentMethods _selection = paymentMethods.COD;
  bool isLoadingCate = false;

  _addOrder() async {
    setState(() {
      isLoadingCate = true;
    });
    await OrderController.addOrder(
            type: "${_selection.toString().split(".").last}",
            address: widget.Address,
            couponAmount: Provider.of<CartDataWrapper>(context, listen: false)
                        .isCouponApplied ==
                    true
                ? Provider.of<CartDataWrapper>(context, listen: false)
                    .discount
                    .toInt()
                : 0,
            couponId: "",
            deliveryCharge: 0,
            finalPaid: Provider.of<CartDataWrapper>(context, listen: false)
                .totalAmount
                .toInt(),
            paidAmount: Provider.of<CartDataWrapper>(context, listen: false)
                .totalAmount
                .toInt(),
            refundAmount: 0,
            taxAmount: Provider.of<CartDataWrapper>(context, listen: false)
                .tax
                .toInt(),
            totalAmount: Provider.of<CartDataWrapper>(context, listen: false)
                .totalAmount
                .toInt())
        .then((value) {
      if (value.success) {
        print(value.data);
        setState(() {
          isLoadingCate = false;
          Fluttertoast.showToast(msg: "Order Success");
          Navigator.pushReplacementNamed(context, PageCollection.home);
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
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  title: const Text('Cash on Delivery'),
                  leading: Radio<paymentMethods>(
                    activeColor: appPrimaryMaterialColor,
                    value: paymentMethods.COD,
                    groupValue: _selection,
                    onChanged: (paymentMethods? value) {
                      setState(() {
                        _selection = value!;
                        print(value);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                ListTile(
                  title: const Text('Pay Online'),
                  leading: Radio<paymentMethods>(
                    value: paymentMethods.PAY_ONLINE,
                    activeColor: appPrimaryMaterialColor,
                    groupValue: _selection,
                    onChanged: (paymentMethods? value) {
                      setState(() {
                        _selection = value!;
                        print(value);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                ListTile(
                  title: const Text('Take Away'),
                  leading: Radio<paymentMethods>(
                    value: paymentMethods.TAKEAWAY,
                    activeColor: appPrimaryMaterialColor,
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
                        if (_selection.toString().split(".").last == "COD" ||
                            _selection.toString().split(".").last ==
                                "TAKEAWAY") {
                          _addOrder();
                        }
                      },
                      child: Container(
                        height: 48,
                        color: appPrimaryMaterialColor,
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
