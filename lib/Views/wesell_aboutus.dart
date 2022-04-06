import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/PolicyWidgets.dart';

class WeSellAboutUs extends StatelessWidget {
  const WeSellAboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About us",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PolicyTitle(txt: "What kind of business can use WeSell?"),
              PolicyParagraph(
                  txt:
                      'Any kind of business who is selling any products or services can use WeSell to accept orders from their customers online.'),
              PolicyTitle(txt: 'How It Works?'),
              PolicyTitle(txt: 'Set up your store name'),
              PolicyParagraph(
                  txt:
                      'Add your business name and required details, and you are a step closer to opening a store online!'),
              PolicyTitle(txt: 'Add your products'),
              PolicyParagraph(
                  txt:
                      'Provide a list of products and/or services the business offers in order to create what’s in store.'),
              PolicyTitle(txt: 'Start Selling'),
              PolicyParagraph(
                  txt:
                      'You are all set to start selling online via website or app. Share your store details with existing pool of customers!'),
              PolicyTitle(txt: 'After-Sales Services'),
              PolicyParagraph(
                  txt:
                      'Manage existing and new clients by generating birthday coupons, offers and a lot more through insights.'),
              PolicyTitle(txt: 'Why Us?'),
              PolicyTitle(txt: "Manage all in one app"),
              PolicyParagraph(
                  txt:
                      'Make the most of a paramount dashboard featuring resourceful information, manage your inventory and orders easily, and share your online store with everyone in just a tap!'),
              PolicyTitle(txt: 'Promote your business online'),
              PolicyParagraph(
                  txt:
                      'Generate coupons for birthdays, festivals and offer discounts on special occasions to boost your sales. Share personalised business cards, posters and banners with the help of our top-class marketing tools.'),
              PolicyTitle(
                  txt:
                      'Start, run and grow your business online and Sell everywhere'),
              PolicyParagraph(
                  txt:
                      'WeSell is an all-inclusive platform promoting all kinds of businesses having products and services. Reach out to anybody and anywhere online via your website and social media integration.'),
            ],
          ),
        ),
      ),
    );
  }
}
