import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/PolicyWidgets.dart';

class RefundPolicy extends StatelessWidget {
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
                  txt: "Returns",
                ),
                PolicyParagraph(
                  txt:
                  "Our policy lasts 30 days. If 30 days have gone by since your purchase, unfortunately we can’t offer you a refund or exchange.\n\nTo be eligible for a return, your item must be unused and in the same condition that you received it. It must also be in the original packaging.\n\nSeveral types of goods are exempt from being returned. Perishable goods such as food, flowers, newspapers or magazines cannot be returned. We also do not accept products that are intimate or sanitary goods, hazardous materials, or flammable liquids or gases.\n\nAdditional non-returnable items:\n\nGift cards\nDownloadable software products\nSome health and personal care items\n\nTo complete your return, we require a receipt or proof of purchase.\n\nPlease do not send your purchase back to the manufacturer.\n\nThere are certain situations where only partial refunds are granted: (if applicable)Book with obvious signs of use CD, DVD, VHS tape, software, video game, cassette tape, or vinyl record that has been opened. Any item not in its original condition, is damaged or missing parts for reasons not due to our error. Any item that is returned more than 30 days after delivery",
                ),
                PolicyTitle(
                  txt: "Refunds (if applicable)",
                ),
                PolicyParagraph(
                  txt:
                  "Once your return is received and inspected, we will send you an email to notify you that we have received your returned item. We will also notify you of the approval or rejection of your refund.\n\nIf you are approved, then your refund will be processed, and a credit will automatically be applied to your credit card or original method of payment, within a certain amount of days.",
                ),
                PolicyTitle(
                  txt: "Late or missing refunds (if applicable)",
                ),
                PolicyParagraph(
                  txt:
                  "If you haven’t received a refund yet, first check your bank account again.Then contact your credit card company, it may take some time before your refund is officially posted.\n\nNext contact your bank. There is often some processing time before a refund is posted.If you’ve done all of this and you still have not received your refund yet, please contact us at we3magicllp@gmail.com.",
                ),
                PolicyTitle(
                  txt: "Sale items (if applicable)",
                ),
                PolicyParagraph(
                  txt:
                  "Only regular priced items may be refunded, unfortunately sale items cannot be refunded.",
                ),
                PolicyTitle(
                  txt: "Exchanges (if applicable)",
                ),
                PolicyParagraph(
                  txt:
                  "We only replace items if they are defective or damaged.  If you need to exchange it for the same item, send us an email at we3magicllp@gmail.com and send your item to: 451, Mint St, Sowcarpet, Chennai-79 India.",
                ),
                PolicyTitle(
                  txt: "Gifts",
                ),
                PolicyParagraph(
                  txt:
                  "If the item was marked as a gift when purchased and shipped directly to you, you’ll receive a gift credit for the value of your return. Once the returned item is received, a gift certificate will be mailed to you.\n\nIf the item wasn’t marked as a gift when purchased, or the gift giver had the order shipped to themselves to give to you later, we will send a refund to the gift giver and he will find out about your return.",
                ),
                PolicyTitle(
                  txt: "Shipping",
                ),
                PolicyParagraph(
                  txt:
                  "To return your product, you should mail your product to: 451, Mint St, Sowcarpet, Chennai-79 India.\n\nYou will be responsible for paying for your own shipping costs for returning your item. Shipping costs are non-refundable. If you receive a refund, the cost of return shipping will be deducted from your refund.\n\nDepending on where you live, the time it may take for your exchanged product to reach you, may vary.\n\If you are shipping an item over \$75, you should consider using a trackable shipping service or purchasing shipping insurance. We don’t guarantee that we will receive your returned item.",
                )
              ],
            ),
          ),
        ));
  }
}