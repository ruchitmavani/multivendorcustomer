import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/UiFake.dart'
    if (dart.library.html) 'dart:ui' as ui;

class Webpayment extends StatelessWidget {
  final String? name;
  final String? image;
  final String orderId;
  final int? price;
  Function addOrder;

  Webpayment({this.name, this.price, this.image,required this.addOrder,required this.orderId,});

  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();

      window.onMessage.forEach((value) {
        print('Event Received in callback: ${value.data}');
        if (value.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        } else if (value.data == 'SUCCESS') {
          Fluttertoast.showToast(msg: 'Payment Success ${(price! * 0.01)}');
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

//
// class CheckOut extends StatefulWidget {
//   String total;
//   String name;
//   String image;
//
//   CheckOut({required this.total, required this.name, required this.image});
//
//   @override
//   _CheckOutState createState() => _CheckOutState();
// }
//
// class _CheckOutState extends State<CheckOut> {
//   @override
//   Widget build(BuildContext context) {
//     ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
//       IFrameElement element = IFrameElement();
//       window.onMessage.forEach((element) {
//         print('Event Received in callback: ${element.data}');
//         if (element.data == 'MODAL_CLOSED') {
//           Navigator.pop(context);
//         } else if (element.data == 'SUCCESS') {
//           print('PAYMENT SUCCESSFULL!!!!!!!');
//         }
//       });
//
//       element.src = 'assets/payment.html?name="text"&price="300"&image=""';
//       element.style.border = 'none';
//
//       return element;
//     });
//
//     return Scaffold(
//       body: Container(
//         child: HtmlElementView(
//           viewType: 'rzp-html',
//         ),
//       ),
//     );
//   }
// }
