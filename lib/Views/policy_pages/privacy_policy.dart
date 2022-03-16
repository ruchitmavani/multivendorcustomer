import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/PolicyWidgets.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Privacy Policy",
            style: TextStyle(
                color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PolicyTitle(
                  txt: "SECTION 1 - WHAT DO WE DO WITH YOUR INFORMATION?",
                ),
                PolicyParagraph(
                  txt:
                      "When you purchase something from our store, as part of the buying and selling process, we collect the personal information you give us such as your name, address and email address.\n\nWhen you browse our store, we also automatically receive your computer’s internet protocol (IP) address in order to provide us with information that helps us learn about your browser and operating system.\n\nEmail marketing (if applicable): With your permission, we may send you emails about our store, new products and other updates.",
                ),
                PolicyTitle(
                  txt: "SECTION 2 - CONSENT",
                ),
                PolicyParagraph(
                  txt:
                      "How do you get my consent?\n\nWhen you provide us with personal information to complete a transaction, verify your credit card, place an order, arrange for a delivery or return a purchase, we imply that you consent to our collecting it and using it for that specific reason only.\n\nIf we ask for your personal information for a secondary reason, like marketing, we will either ask you directly for your expressed consent, or provide you with an opportunity to say no.\n\n\nHow do I withdraw my consent?\n\nIf after you opt-in, you change your mind, you may withdraw your consent for us to contact you, for the continued collection, use or disclosure of your information, at anytime, by contacting us at we3magicllp@gmail.com or mailing us at: 451, Mint St, Sowcarpet, Chennai-79",
                ),
                PolicyTitle(
                  txt: "SECTION 3 - DISCLOSURE",
                ),
                PolicyParagraph(
                  txt:
                      "We may disclose your personal information if we are required by law to do so or if you violate our Terms of Service.",
                ),
                PolicyTitle(
                  txt: "SECTION 4 - PAYMENT",
                ),
                PolicyParagraph(
                  txt:
                      "We use Razorpay for processing payments. We/Razorpay do not store your card data on their servers. The data is encrypted through the Payment Card Industry Data Security Standard (PCI-DSS) when processing payment. Your purchase transaction data is only used as long as is necessary to complete your purchase transaction. After that is complete, your purchase transaction information is not saved.\n\nOur payment gateway adheres to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, MasterCard, American Express and Discover.\n\nPCI-DSS requirements help ensure the secure handling of credit card information by our store and its service providers.\n\nFor more insight, you may also want to read terms and conditions of razorpay on https://razorpay.com",
                ),
                PolicyTitle(
                  txt: "SECTION 5 - THIRD-PARTY SERVICES",
                ),
                PolicyParagraph(
                  txt:
                      "In general, the third-party providers used by us will only collect, use and disclose your information to the extent necessary to allow them to perform the services they provide to us.\n\nHowever, certain third-party service providers, such as payment gateways and other payment transaction processors, have their own privacy policies in respect to the information we are required to provide to them for your purchase-related transactions.\n\nFor these providers, we recommend that you read their privacy policies so you can understand the manner in which your personal information will be handled by these providers.\n\nIn particular, remember that certain providers may be located in or have facilities that are located a different jurisdiction than either you or us. So if you elect to proceed with a transaction that involves the services of a third-party service provider, then your information may become subject to the laws of the jurisdiction(s) in which that service provider or its facilities are located.\n\nOnce you leave our store’s website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our website’s Terms of Service.\n\nLinks\n\nWhen you click on links on our store, they may direct you away from our site. We are not responsible for the privacy practices of other sites and encourage you to read their privacy statements.",
                ),
                PolicyTitle(
                  txt: "SECTION 6 - SECURITY",
                ),
                PolicyParagraph(
                  txt:
                      "To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered or destroyed.",
                ),
                PolicyTitle(
                  txt: "SECTION 7 - COOKIES",
                ),
                PolicyParagraph(
                  txt:
                      "We use cookies to maintain session of your user. It is not used to personally identify you on other websites.",
                ),
                PolicyTitle(
                  txt: "SECTION 8 - AGE OF CONSENT",
                ),
                PolicyParagraph(
                  txt:
                      "By using this site, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.",
                ),
                PolicyTitle(
                  txt: "SECTION 9 - CHANGES TO THIS PRIVACY POLICY",
                ),
                PolicyParagraph(
                    txt:
                        "We reserve the right to modify this privacy policy at any time, so please review it frequently. Changes and clarifications will take effect immediately upon their posting on the website. If we make material changes to this policy, we will notify you here that it has been updated, so that you are aware of what information we collect, how we use it, and under what circumstances, if any, we use and/or disclose it.\n\nIf our store is acquired or merged with another company, your information may be transferred to the new owners so that we may continue to sell products to you."),
                PolicyTitle(
                  txt: "QUESTIONS AND CONTACT INFORMATION",
                ),
                PolicyParagraph(
                  txt:
                      "If you would like to: access, correct, amend or delete any personal information we have about you, register a complaint, or simply want more information contact our Privacy Compliance Officer at we3magicllp@gmail.com or by mail at 451, Mint St, Sowcarpet, Chennai-79\n\n[Re: Privacy Compliance Officer]\n\n451, Mint St, Sowcarpet, Chennai-79 India\n\n___",
                )
              ],
            ),
          ),
        ));
  }
}
