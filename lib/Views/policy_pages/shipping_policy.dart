import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/PolicyWidgets.dart';

class ShippingPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Shipping Policy",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PolicyParagraph(
                  txt:
                      'Wesell ("we" and "us") is the operator of (https://wesell.co.in) ("Website"). By placing an order through this Website you will be agreeing to the terms below. These are provided to ensure both parties are aware of and agree upon this arrangement to mutually protect and set expectations on our service.',
                ),
                PolicyTitle(
                  txt: '1. General',
                ),
                PolicyParagraph(
                  txt:
                      'Subject to stock availability. We try to maintain accurate stock counts on our website but from time-to-time there may be a stock discrepancy and we will not be able to fulfill all your items at time of purchase. In this instance, we will fulfill the available products to you, and contact you about whether you would prefer to await restocking of the backordered item or if you would prefer for us to process a refund.',
                ),
                PolicyTitle(
                  txt: '2. Shipping Costs',
                ),
                PolicyParagraph(
                  txt:
                      'Shipping costs are calculated during checkout based on weight, dimensions and destination of the items in the order. Payment for shipping will be collected with the purchase.This price will be the final price for shipping cost to the customer.',
                ),
                PolicyTitle(
                  txt: '3. Returns',
                ),
                PolicyTitle(
                  txt: '3.1 Return Due To Change Of Mind',
                ),
                PolicyParagraph(
                  txt:
                      'Wesell will happily accept returns due to change of mind as long as a request to return is received by us within 0 days of receipt of item and are returned to us in original packaging, unused and in resellable condition. Return shipping will be paid at the customers expense and will be required to arrange their own shipping. Once returns are received and accepted, refunds will be processed to store credit for a future purchase. We will notify you once this has been completed through email. (Wesell) will refund the value of the goods returned but will NOT refund the value of any shipping paid.',
                ),
                PolicyTitle(txt: '3.2 Warranty Returns'),
                PolicyParagraph(txt: 'Wesell will happily honor any valid warranty claims, provided a claim is submitted within 90 days of receipt of items. Customers will be required to pre-pay the return shipping, however we will reimburse you upon successful warranty claim. Upon return receipt of items for warranty claim, you can expect Wesell to process your warranty claim within 7 days. Once warranty claim is confirmed, you will receive the choice of:\n(a) refund to your payment method\n(b) a refund in store credit\n(c) a replacement item sent to you (if stock is available)',),
                PolicyTitle(txt: '4. Delivery Terms',),
                PolicyTitle(txt: '4.1 Transit Time Domestically',),
                PolicyParagraph(txt: 'In general, domestic shipments are in transit for 2 - 7 days',),
                PolicyTitle(txt: '4.2 Transit time Internationally'),
                PolicyParagraph(txt: 'Generally, orders shipped internationally are in transit for 4 - 22 days. This varies greatly depending on the courier you have selected. We are able to offer a more specific estimate when you are choosing your courier at checkout.'),
                PolicyTitle(txt: '4.3 Dispatch Time'),
                PolicyParagraph(txt: 'Orders are usually dispatched within 2 business days of payment of order Our warehouse operates on Monday - Friday during standard business hours, except on national holidays at which time the warehouse will be closed. In these instances, we take steps to ensure shipment delays will be kept to a minimum.'),
                PolicyTitle(txt: '4.4 Change Of Delivery Address'),
                PolicyParagraph(txt: 'For change of delivery address requests, we are able to change the address at any time before the order has been dispatched.'),
                PolicyTitle(txt: '4.5 P.O. Box Shipping'),
                PolicyParagraph(txt: 'Wesell will ship to P.O. box addresses using postal services only. We are unable to offer couriers services to these locations.'),
                PolicyTitle(txt: '4.6 Military Address Shipping'),
                PolicyParagraph(txt: 'We are able to ship to military addresses using USPS. We are unable to offer this service using courier services.'),
                PolicyTitle(txt: '4.7 Items Out Of Stock'),
                PolicyParagraph(txt: 'If an item is out of stock, we will cancel and refund the out-of-stock items and dispatch the rest of the order.'),
                PolicyTitle(txt: '4.8 Delivery Time Exceeded'),
                PolicyParagraph(txt: 'If delivery time has exceeded the forecasted time, please contact us so that we can conduct an investigation',),
                PolicyTitle(txt: '5. Tracking Notifications'),
                PolicyParagraph(txt: 'Upon dispatch, customers will receive a tracking link from which they will be able to follow the progress of their shipment based on the latest updates made available by the shipping provider.'),
                PolicyTitle(txt: '6. Parcels Damaged In Transit'),
                PolicyParagraph(txt: 'If you find a parcel is damaged in-transit, if possible, please reject the parcel from the courier and get in touch with our customer service. If the parcel has been delivered without you being present, please contact customer service with next steps.'),
                PolicyTitle(txt: '7. Duties & Taxes'),
                PolicyTitle(txt: '7.1 Sales Tax'),
                PolicyParagraph(txt: 'Sales tax has already been applied to the price of the goods as displayed on the website'),
                PolicyTitle(txt: '7.2 Import Duties & Taxes'),
                PolicyParagraph(txt: 'Import duties and taxes for international shipments may be liable to be paid upon arrival in destination country. This varies by country, and Wesell encourage you to be aware of these potential costs before placing an order with us.   If you refuse to to pay duties and taxes upon arrival at your destination country, the goods will be returned to Wesell at the customers expense, and the customer will receive a refund for the value of goods paid, minus the cost of the return shipping. The cost of the initial shipping will not be refunded.'),
                PolicyTitle(txt: '8. Cancellations'),
                PolicyParagraph(txt: 'If you change your mind before you have received your order, we are able to accept cancellations at any time before the order has been dispatched. If an order has already been dispatched, please refer to our refund policy.'),
                PolicyTitle(txt: '9. Insurance'),
                PolicyParagraph(txt: 'Parcels are insured for loss and damage up to the value as stated by the courier.'),
                PolicyTitle(txt: '9.1 Process for parcel damaged in-transit'),
                PolicyParagraph(txt: 'We will process a refund or replacement as soon as the courier has completed their investigation into the claim.'),
                PolicyTitle(txt: '9.2 Process for parcel lost in-transit'),
                PolicyParagraph(txt: 'We will process a refund or replacement as soon as the courier has conducted an investigation and deemed the parcel lost.'),
                PolicyTitle(txt: '10. Customer service'),
                PolicyParagraph(txt: 'For all customer service enquiries, please phone us at 9962310666'),
              ],
            ),
          ),
        ));
  }
}
