// ignore_for_file: must_be_immutable, avoid_web_libraries_in_flutter

import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/UiFake.dart'
    if (dart.library.html) 'dart:ui' as ui;

class WebPayment extends StatelessWidget {
  final String? name;
  final String? image;
  final String orderId;
  final int? price;
  Function addOrder;

  WebPayment({
    this.name,
    this.price,
    this.image,
    required this.addOrder,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();

      window.onMessage.forEach((value) {
        log('Event Received in callback: ${value.data}');
        if (value.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        } else if (value.data == 'SUCCESS') {
          Fluttertoast.showToast(
              msg: 'Payment Success ${(price! * 0.01)}',
              webPosition: "center",
              webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
          addOrder("PAY_ONLINE");
        }
      });

      element.src =
          'payment.html?name=${sharedPrefs.businessCategory}&price=$price&image=$image&email=${sharedPrefs.customer_email}&customerPhone=${sharedPrefs.customer_mobileNo}&shopname=${sharedPrefs.businessName}&color=${int.parse(sharedPrefs.colorTheme).toRadixString(16).substring(2)}&orderid=$orderId';
      element.style.border = 'none';

      return element;
    });
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            child: HtmlElementView(viewType: 'rzp-html'),
          );
        },
      ),
    );
  }
}
