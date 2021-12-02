import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/CommonWidgets/RejectOrder.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/TimeLine.dart';
import 'package:multi_vendor_customer/CommonWidgets/updatedLabel.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/OrderDetailComponent.dart';
import 'package:multi_vendor_customer/Views/InvoiceGenerate.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
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
  LineStyle lineStyle = LineStyle(color: Colors.grey.shade300, thickness: 2);
  bool isLoading = false;
  bool isChanged = false;
  List<String> status = [];

  // Invoice orderData = Invoice(
  //     products: List.generate(widget.orderData.orderItems.length, (index) => Product(productName, price, quantity)),
  //     customerName: "${sharedPrefs.customer_name}",
  //     invoiceNumber: "",
  //     tax: 0.15,
  //     baseColor: PdfColors.teal,
  //     accentColor: PdfColors.blueGrey900);

  @override
  void initState() {
    super.initState();
    if (widget.orderData.updatedDeliveryCharges != 0) {
      setState(() {
        isChanged = true;
      });
    }
    status = widget.orderData.paymentType.toUpperCase() == "TAKEAWAY"
        ? ["Pending", "Ready", "Delivered"]
        : ["Pending", "Dispatched", "Delivered"];
    for (int i = 0; i < widget.orderData.orderItems.length; i++) {
      if (widget.orderData.orderItems.elementAt(i).updatedQuantity != 0 &&
          widget.orderData.orderItems.elementAt(i).updatedQuantity != null) {
        setState(() {
          isChanged = true;
        });
      }
    }
  }

  _acceptOrder() async {
    setState(() {
      isLoading = true;
    });
    await OrderController.acceptOrder(widget.orderData.orderId).then((value) {
      if (value.success) {
        print(value.data);
        setState(() {
          GoRouter.of(context).push(PageCollection.myOrders);
          Fluttertoast.showToast(msg: "Order Accepted");
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

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
                  CachedNetworkImage(
                    height: 60,
                    width: 60,
                    imageUrl: "${StringConstants.api_url}${sharedPrefs.logo}",
                    fit: BoxFit.fill,
                    placeholder: (context, url) => SizedBox(
                      width: 8,
                      height: 8,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'images/placeholdersquare.jpg',
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                    ),
                  ),
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
                        child: Icon(Icons.call,
                            color: Provider.of<CustomColor>(context)
                                .appPrimaryMaterialColor),
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
                              child: SvgPicture.asset(
                                "images/whatsapp.svg",
                                color: Provider.of<CustomColor>(context)
                                    .appPrimaryMaterialColor,
                              ),
                            )
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
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
                          orderItem:
                              widget.orderData.orderItems.elementAt(index),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[300],
                        thickness: 0.6,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 6),
                      child: Text(
                        " Order Status ",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    if (widget.orderData.orderStatus.last == "Pending" ||
                        widget.orderData.orderStatus.last == "Dispatched" ||
                        widget.orderData.orderStatus.last == "Delivered" ||
                        widget.orderData.orderStatus.last == "Ready")
                      Timeline(
                        children: List.generate(
                          status.length,
                          (index) => Container(
                            alignment: Alignment.centerLeft,
                            height: 40,
                            child: Text(
                              status.elementAt(index),
                              style: TextStyle(
                                fontSize: 14,
                                color: widget.orderData.orderStatus.last ==
                                        status.elementAt(index)
                                    ? Provider.of<CustomColor>(context)
                                        .appPrimaryMaterialColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        indicators: List.generate(
                          status.length,
                          (index) => Icon(
                            Icons.adjust,
                            size: 22,
                            color: widget.orderData.orderStatus.last ==
                                    status.elementAt(index)
                                ? Provider.of<CustomColor>(context)
                                    .appPrimaryMaterialColor
                                : Colors.grey,
                          ),
                        ),
                      )
                    else
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.report_problem),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${widget.orderData.orderStatus.last}",
                              style: TextStyle(
                                  color: Provider.of<CustomColor>(context)
                                      .appPrimaryMaterialColor),
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
                                    widget.orderData.couponAmount != 0
                                        ? "- \u{20B9}" +
                                            "${widget.orderData.couponAmount}"
                                        : "\u{20B9}0",
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
                                title: Row(
                                  children: [
                                    Text("Delivery charges  ",
                                        style: FontsTheme.valueStyle(size: 14)),
                                    if (widget
                                            .orderData.updatedDeliveryCharges !=
                                        0)
                                      UpdatedLabel(),
                                  ],
                                ),
                                trailing: RichText(
                                  text: TextSpan(
                                    text: "\u{20B9}",
                                    style: FontsTheme.valueStyle(
                                        size: 14, fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${widget.orderData.deliveryCharges}",
                                        style: widget
                                                    .orderData.updatedDeliveryCharges !=
                                                0
                                            ? FontsTheme.valueStyle(
                                                    size: 14,
                                                    fontWeight: FontWeight.w500)
                                                .copyWith(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationThickness: 3,
                                                    decorationColor: Provider
                                                            .of<CustomColor>(
                                                                context)
                                                        .appPrimaryMaterialColor)
                                            : FontsTheme.valueStyle(
                                                size: 14,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      if (widget.orderData
                                              .updatedDeliveryCharges !=
                                          0)
                                        TextSpan(
                                          text:
                                              " ${widget.orderData.updatedDeliveryCharges}",
                                          style: FontsTheme.valueStyle(
                                              size: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                    ],
                                  ),
                                ),
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
                                title: Row(
                                  children: [
                                    Text("Total ",
                                        style: FontsTheme.valueStyle(
                                            size: 16,
                                            fontWeight: FontWeight.w700)),
                                    isChanged ? UpdatedLabel() : Container(),
                                  ],
                                ),
                                trailing: Text(
                                    "\u{20B9}" +
                                        " " +
                                        "${widget.orderData.orderAmount}",
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
        child: (isChanged)
            ? (isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Accept Order?"),
                      ),
                      OutlinedButton(
                        child: Text("No"),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => RejectOrder(
                                    oderIdData: widget.orderData.orderId,
                                  ));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ElevatedButton(
                          child: Text("Yes"),
                          onPressed: () {
                            _acceptOrder();
                          },
                        ),
                      )
                    ],
                  )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.orderData.orderStatus.last == "Delivered")
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        child: Text(
                          "Download invoice",
                          style: TextStyle(fontSize: 13),
                        ),
                        onPressed: () {
                          Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) {
                              return generateInvoice(
                                  format,
                                  Invoice(
                                      products: List.generate(
                                          widget.orderData.orderItems.length,
                                          (index) => Product(
                                              widget.orderData.orderItems
                                                  .elementAt(index)
                                                  .productDetails
                                                  .productName,
                                              widget.orderData.orderItems
                                                  .elementAt(index)
                                                  .productDetails
                                                  .productSellingPrice,
                                              widget.orderData.orderItems
                                                  .elementAt(index)
                                                  .productQuantity)),
                                      customerName:
                                          "${sharedPrefs.customer_name}",
                                      invoiceNumber:
                                          "${widget.orderData.orderId}",
                                      tax: widget.orderData.taxPercentage == 0
                                          ? 0
                                          : widget.orderData.taxPercentage /
                                              100,
                                      baseColor: PdfColors.teal,
                                      accentColor: PdfColors.blueGrey900));
                            },
                          );
                          // generateInvoice(PdfPageFormat.a4, qrcodeData);
                        },
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Future<Uint8List> buildPdf(PdfPageFormat format) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.ConstrainedBox(
            constraints: pw.BoxConstraints.expand(),
            child: pw.FittedBox(
              child: pw.Text('Hello World'),
            ),
          );
        },
      ),
    );

    // Build and return the final Pdf file data
    return await doc.save();
  }
}
