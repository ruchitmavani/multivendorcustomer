import 'dart:html';

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Views/Components/UiFake.dart'
    if (dart.library.html) 'dart:ui' as ui;

class LandingScreen extends StatelessWidget {
  LandingScreen();

  @override
  Widget build(BuildContext context) {
    ui.platformViewRegistry.registerViewFactory("landing-html", (int viewId) {
      IFrameElement element = IFrameElement();

      // window.onMessage.forEach((value) {
      //   print('Event Received in callback: ${value.data}');
      //   if (value.data == 'MODAL_CLOSED') {
      //     Navigator.pop(context);
      //   } else if (value.data == 'SUCCESS') {
      //     Fluttertoast.showToast(
      //         msg: 'Payment Success ${(price! * 0.01)}',
      //         webPosition: "center",
      //         webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
      //     addOrder("PAY_ONLINE");
      //   }
      // });

      element.src = 'landing_page.html';
      element.style.border = 'none';

      return element;
    });
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            child: HtmlElementView(viewType: 'landing-html'),
          );
        },
      ),
    );
  }
}
