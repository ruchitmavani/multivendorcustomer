import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/OrderDetailComponent.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatefulWidget {
  final OrderDataModel orderData;

  OrderDetails({required this.orderData});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  LineStyle lineStyle=LineStyle(color: Colors.grey.shade300,thickness: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: Column(
          children: [
            Container(
              height: 10,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 13.0, right: 5, top: 11, bottom: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network("${StringConstants.API_URL}${sharedPrefs.logo}",
                      width: 60, height: 60),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.orderData.vendorDetails.businessName}",
                              style: FontsTheme.valueStyle(
                                  fontWeight: FontWeight.w600, size: 14)),
                          Text(
                              "${widget.orderData.vendorDetails.businessCategory}",
                              style: FontsTheme.valueStyle(
                                  fontWeight: FontWeight.w600, size: 11)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await launch(
                              'tel: ${widget.orderData.vendorDetails.mobileNumber}');
                        },
                        child: Icon(Icons.call, color: Provider.of<CustomColor>(context).appPrimaryMaterialColor),
                      ),
                      widget.orderData.vendorDetails.isWhatsappChatSupport
                          ? Space(width: 8)
                          : Container(),
                      widget.orderData.vendorDetails.isWhatsappChatSupport
                          ? Container(
                              height: 18, width: 0.9, color: Colors.grey)
                          : Container(),
                      widget.orderData.vendorDetails.isWhatsappChatSupport
                          ? Space(width: 8)
                          : Container(),
                      widget.orderData.vendorDetails.isWhatsappChatSupport
                          ? InkWell(
                              onTap: () async {
                                await launch(
                                    "https://wa.me/${widget.orderData.vendorDetails.mobileNumber}");
                              },
                              child: SvgPicture.asset("images/whatsapp.svg"))
                          : Container(),
                      Space(width: 10)
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              color: Colors.grey.shade200,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        scrollDirection: Axis.vertical,
                        itemCount: widget.orderData.orderItems.length,
                        itemBuilder: (context, index) {
                          return OrderDetailComponent(
                            orderId: widget.orderData.orderId,
                            productDetail: widget.orderData.orderItems
                                .elementAt(index)
                                .productDetails,
                            quantity: widget.orderData.orderItems
                                .elementAt(index)
                                .productQuantity,
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey[300],
                          thickness: 0.6,
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 55,maxWidth: MediaQuery.of(context).size.width),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(color: Colors.grey.shade300,height: 3,margin: EdgeInsets.symmetric(horizontal: 40),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (widget.orderData.orderStatus=="pending") TimelineTile(
                                alignment: TimelineAlign.center,
                                axis: TimelineAxis.horizontal,
                                isFirst: true,
                                beforeLineStyle: lineStyle,
                                afterLineStyle: lineStyle,
                                indicatorStyle: IndicatorStyle(
                                    color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                                    iconStyle: IconStyle(iconData: Icons.watch,color: Colors.white,fontSize: 16),
                                    height: 22,
                                    width: 22

                                ),
                                endChild: Text(
                                  "Pending",
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              ),
                              if (widget.orderData.orderStatus=="pending"||widget.orderData.orderStatus=="delivered") TimelineTile(
                                alignment: TimelineAlign.center,
                                axis: TimelineAxis.horizontal,
                                isFirst: true,
                                beforeLineStyle: lineStyle,
                                afterLineStyle: lineStyle,
                                indicatorStyle: IndicatorStyle(
                                  color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                                  iconStyle: IconStyle(iconData: Icons.done,color: Colors.white,fontSize: 16),
                                  height: 22,
                                  width: 22

                                ),
                                endChild: Text(
                                  "Accepted",
                                  style:
                                      TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              ),
                              if (widget.orderData.orderStatus=="delivered"||widget.orderData.orderStatus=="pending")TimelineTile(
                                alignment: TimelineAlign.center,
                                axis: TimelineAxis.horizontal,
                                beforeLineStyle: lineStyle,
                                afterLineStyle: lineStyle,
                                isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                    color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                                    iconStyle: IconStyle(iconData: Icons.access_time,color: Colors.white,fontSize: 16),
                                    height: 22,
                                    width: 22
                                ),
                                endChild: Text(
                                  "Dispatched",
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              ),if (widget.orderData.orderStatus!="delivered")TimelineTile(
                                alignment: TimelineAlign.center,
                                axis: TimelineAxis.horizontal,
                                isLast: true,
                                beforeLineStyle: lineStyle,
                                afterLineStyle: lineStyle,
                                endChild: Text(
                                  "",
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              ),
                              if (widget.orderData.orderStatus=="delivered")TimelineTile(
                                alignment: TimelineAlign.center,
                                axis: TimelineAxis.horizontal,
                                isLast: true,
                                beforeLineStyle: lineStyle,
                                afterLineStyle: lineStyle,
                                indicatorStyle: IndicatorStyle(
                                    color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                                    iconStyle: IconStyle(iconData: Icons.airport_shuttle,color: Colors.white,fontSize: 16),
                                    height: 22,
                                    width: 22
                                ),
                                endChild: Text(
                                  "Delivered",
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              height: 25,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text("Discount Applied",
                                    style: FontsTheme.valueStyle(size: 14)),
                                trailing: Text(
                                    "- \u{20B9}" +
                                        "${widget.orderData.couponAmount}",
                                    style: FontsTheme.valueStyle(
                                        size: 14, fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              height: 25,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text("Tax",
                                    style: FontsTheme.valueStyle(size: 14)),
                                trailing: Text(
                                    "\u{20B9}" +
                                        "${widget.orderData.taxAmount}",
                                    style: FontsTheme.valueStyle(
                                        size: 14, fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              height: 25,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text("Shipping Fee",
                                    style: FontsTheme.valueStyle(size: 14)),
                                trailing: Text(
                                    "\u{20B9}" +
                                        "${widget.orderData.deliveryCharges}",
                                    style: FontsTheme.valueStyle(
                                        size: 14, fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13.0),
                            child: SizedBox(
                              height: 35,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text("Total",
                                    style: FontsTheme.valueStyle(
                                        size: 16, fontWeight: FontWeight.w700)),
                                trailing: Text(
                                    "\u{20B9}" +
                                        " " +
                                        "${widget.orderData.finalPaidAmount}",
                                    style: FontsTheme.valueStyle(
                                        size: 16, fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 25.0, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 44,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Download invoice",
                      style: TextStyle(fontSize: 13),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                      ),
                    )
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
