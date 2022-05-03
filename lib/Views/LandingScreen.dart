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

      element.src = 'landing_page.html';
      element.style.border = 'none';
      element.style.height='100%';
      element.style.width='100%';

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
