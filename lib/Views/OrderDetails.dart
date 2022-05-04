import 'dart:html';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/CommonWidgets/RejectOrder.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/updatedLabel.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Data/wesellimage.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/DoubleExtension.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/OrderDetailComponent.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timelines/timelines.dart';
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
  bool isRejected = false;
  List<String> status = [];
  bool isDownload = false;

  @override
  void initState() {
    super.initState();
    if (widget.orderData.updatedDeliveryCharges != 0) {
      setState(() {
        isChanged = true;
      });
    }
    status = widget.orderData.paymentType.toUpperCase() == "TAKEAWAY"
        ? ["Pending", "Pickup", "Delivered"]
        : ["Pending", "Dispatched", "Delivered"];
    for (int i = 0; i < widget.orderData.orderItems.length; i++) {
      if ((widget.orderData.orderItems.elementAt(i).updatedQuantity != 0 &&
              widget.orderData.orderItems.elementAt(i).updatedQuantity !=
                  null) ||
          widget.orderData.orderItems.elementAt(i).isReject == true) {
        setState(() {
          isChanged = true;
        });
      }
    }
  }

  String formatDate(DateTime? dateTime) {
    return DateFormat("MMM dd, yyyy  HH:MM a").format(dateTime!);
  }

  String formatTime(DateTime? dateTime) {
    return DateFormat('jm').format(dateTime!);
  }

  _acceptOrder() async {
    setState(() {
      isLoading = true;
    });
    await OrderController.acceptOrder(widget.orderData.orderId).then((value) {
      if (value.success) {
        setState(() {
          GoRouter.of(context).go('/' + storeConcat(PageCollection.myOrders));
          Fluttertoast.showToast(
              msg: "Order Accepted",
              webPosition: "center",
              webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
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
    var themeProvider=Provider.of<ThemeColorProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AutoSizeText(
          "#Order ${widget.orderData.orderId.split("_").first}",
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.black, fontSize: 12),
        ),
      ),
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
                  left: 15.0, right: 5, top: 11, bottom: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      window.open(
                          "${widget.orderData.vendorDetails.storeLink}", "");
                    },
                    child: CachedNetworkImage(
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
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        window.open(
                            "${widget.orderData.vendorDetails.storeLink}", "");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                                "${widget.orderData.vendorDetails.businessName}",
                                style: FontsTheme.gilroyText(size: 14)),
                            AutoSizeText(
                                "${widget.orderData.vendorDetails.businessCategory}",
                                style: FontsTheme.valueStyle(
                                    fontWeight: FontWeight.w600, size: 11)),
                          ],
                        ),
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
                            color: themeProvider
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
                                    "https://wa.me/+91${widget.orderData.vendorDetails.mobileNumber}");
                              },
                              child: Image.asset(
                                "images/whatsapp.png.",
                                height: 22,
                                width: 22,
                                color: themeProvider
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
            //order status
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
                    if ((widget.orderData.orderStatus.last.toLowerCase() ==
                            "accepted" ||
                        widget.orderData.orderStatus.last.toLowerCase() ==
                            "ready" ||
                        widget.orderData.orderStatus.last.toLowerCase() ==
                            "dispatched") && widget.orderData.deliveryApproxTime.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                " Approx Delivery Time: ",
                                style: FontsTheme.valueStyle(
                                  fontWeight: FontWeight.w400,
                                  size: 12,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 6),
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Text(
                                "${widget.orderData.deliveryApproxTime}",
                                style: FontsTheme.valueStyle(
                                  fontWeight: FontWeight.w400,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 6),
                      child: Text(
                        " Order Status ",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Container(
                        height: 60,
                        child: Timeline.tileBuilder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          // controller: ScrollController(
                          //   initialScrollOffset:
                          // ),
                          builder: TimelineTileBuilder.connected(
                            itemCount:
                                widget.orderData.orderStatusWithTime.length < 2
                                    ? 3
                                    : widget
                                        .orderData.orderStatusWithTime.length,
                            contentsBuilder: (_, index) {
                              int count =
                                  widget.orderData.orderStatusWithTime.length;
                              return Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (count < 2) ...[
                                      Text(
                                          "${index == 1 ? "Accepted" : index == 2 ? "Delivered" : widget.orderData.orderStatusWithTime[0].status}",
                                          style: TextStyle(fontSize: 12)),
                                    ] else ...[
                                      Text(
                                          "${widget.orderData.orderStatusWithTime[index].status}",
                                          style: TextStyle(fontSize: 10)),
                                    ]
                                  ],
                                ),
                              );
                            },
                            indicatorBuilder: (_, i) {
                              return DotIndicator(
                                color: widget.orderData.orderStatusWithTime
                                            .length <
                                        2
                                    ? i == 1 || i == 2
                                        ? Colors.grey
                                        : themeProvider
                                            .appPrimaryMaterialColor
                                    : themeProvider
                                        .appPrimaryMaterialColor,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              );
                            },
                            itemExtent:
                                widget.orderData.orderStatusWithTime.length <= 2
                                    ? 120
                                    : 90,
                            connectorBuilder: (_, i, ___) => SolidLineConnector(
                              color: widget.orderData.orderStatusWithTime
                                          .length <
                                      2
                                  ? i == 1 || i == 2
                                      ? Colors.grey
                                      : themeProvider
                                          .appPrimaryMaterialColor
                                  : themeProvider
                                      .appPrimaryMaterialColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //discount
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
                                    style: FontsTheme.valueStyle(
                                        size: 14,
                                        color: Colors.black.withOpacity(0.7))),
                                trailing: Text(
                                    widget.orderData.couponAmount != 0
                                        ? "- \u{20B9}" +
                                            "${widget.orderData.couponAmount}"
                                        : "\u{20B9}0",
                                    style: FontsTheme.valueStyle(
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.7))),
                              ),
                            ),
                          ),
                          //tax
                          if (widget.orderData.taxPercentage.length != 0)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.orderData.taxPercentage.length,
                              itemBuilder: (context, i) {
                                return SizedBox(
                                  height: 25,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: Text(
                                      "${widget.orderData.taxPercentage.elementAt(i).taxName}(${widget.orderData.taxPercentage.elementAt(i).taxPercentage}%)",
                                      style: FontsTheme.digitStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    trailing: Text(
                                      "\u{20B9} ${(widget.orderData.taxPercentage.elementAt(i).amount).roundOff()}",
                                      style: FontsTheme.digitStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 4.0),
                          //   child: SizedBox(
                          //     height: 25,
                          //     child: ListTile(
                          //       contentPadding: EdgeInsets.zero,
                          //       dense: true,
                          //       title: Text("Tax",
                          //           style: FontsTheme.valueStyle(
                          //               size: 14,
                          //               color: Colors.black.withOpacity(0.7))),
                          //       trailing: Text(
                          //           "\u{20B9}" +
                          //               "${widget.orderData.taxAmount}",
                          //           style: FontsTheme.valueStyle(
                          //               size: 14,
                          //               fontWeight: FontWeight.w500,
                          //               color: Colors.black.withOpacity(0.7))),
                          //     ),
                          //   ),
                          // ),
                          //delivery charges
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              height: 25,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Row(
                                  children: [
                                    Text(
                                      "Delivery charges  ",
                                      style: FontsTheme.valueStyle(
                                        size: 14,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: RichText(
                                  text: TextSpan(
                                    text: "\u{20B9}",
                                    style: FontsTheme.valueStyle(
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.7)),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${widget.orderData.deliveryCharges}",
                                        style:
                                            // widget
                                            //             .orderData.updatedDeliveryCharges !=
                                            //         0
                                            //     ? FontsTheme.valueStyle(
                                            //             size: 14,
                                            //             fontWeight: FontWeight.w500)
                                            //         .copyWith(
                                            //             decoration: TextDecoration
                                            //                 .lineThrough,
                                            //             decorationThickness: 3,
                                            //             decorationColor: themeProvider
                                            //                 .appPrimaryMaterialColor)
                                            //     :
                                            FontsTheme.valueStyle(
                                                size: 14,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //additional delivery charges
                          if (widget.orderData.updatedDeliveryCharges != 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: SizedBox(
                                height: 25,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  title: Row(
                                    children: [
                                      Text("Additional charges  ",
                                          style: FontsTheme.valueStyle(
                                              size: 14,
                                              color: Colors.black
                                                  .withOpacity(0.7))),
                                      if (widget.orderData
                                              .updatedDeliveryCharges !=
                                          0)
                                        UpdatedLabel(),
                                    ],
                                  ),
                                  trailing: RichText(
                                    text: TextSpan(
                                      text: "\u{20B9}",
                                      style: FontsTheme.valueStyle(
                                          size: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.7)),
                                      children: [
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
                          //total amount
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
                                    isChanged &&
                                            widget.orderData.orderStatus.last
                                                    .toLowerCase() ==
                                                "modified"
                                        ? UpdatedLabel()
                                        : Container(),
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
        child: (isChanged &&
                widget.orderData.orderStatus.last.toLowerCase() == "modified")
            ? (isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Accept changes?"),
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
                    isDownload
                        ? SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              child: Text(
                                "Please wait",
                                style: TextStyle(fontSize: 13),
                              ),
                              onPressed: () async {
                                // generateInvoice(PdfPageFormat.a4, qrcodeData);
                              },
                            ),
                          )
                        : SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              child: Text(
                                "Download invoice",
                                style: TextStyle(fontSize: 13),
                              ),
                              onPressed: () async {
                                // await compute(
                                setState(() {
                                  isDownload = true;
                                });
                                await compute(
                                    await buildPdf(
                                        PdfPageFormat.a4, widget.orderData),
                                    "Q");
                                setState(() {
                                  isDownload = false;
                                });
                                // generateInvoice(PdfPageFormat.a4, qrcodeData);
                              },
                            ),
                          ),
                ],
              ),
      ),
    );
  }

  Future buildPdf(PdfPageFormat format, OrderDataModel order) async {
    pw.Document pdf = pw.Document();
    final montserrat = await PdfGoogleFonts.montserratSemiBold();

    pdf.addPage(pw.Page(
        margin: pw.EdgeInsets.only(top: 30, bottom: 10),
        theme: pw.ThemeData.withFont(
            base: await PdfGoogleFonts.montserratSemiBold()),
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Padding(
              padding: pw.EdgeInsets.only(right: 20, left: 20),
              child: headerContent(order, logoByteList),
            ),
            pw.SizedBox(height: 40),
            pw.Padding(
              padding: pw.EdgeInsets.only(left: 30, right: 30),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text("ORDER DETAIL",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      )),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Expanded(
              child: pw.Padding(
                  padding: const pw.EdgeInsets.all(0.0),
                  child: pw.Container(
                    child: pw.Wrap(
                      children: List.generate(
                          order.orderItems.length >= 4
                              ? 4
                              : order.orderItems.length, (index) {
                        return pw.Padding(
                            padding: pw.EdgeInsets.only(
                                left: 30, right: 30, top: 20),
                            child: orderComponent(
                              order.orderItems[index],
                              montserrat,
                            ));
                      }),
                    ),
                  )),
            ),
            if (order.orderItems.length <= 3)
              priceContent(
                order,
                montserrat,
              )
          ]);
        }));

    if (order.orderItems.length > 4) {
      int length = order.orderItems.length >= 11 ? 11 : order.orderItems.length;
      pdf.addPage(pw.Page(
          margin: pw.EdgeInsets.only(top: 20),
          theme: pw.ThemeData.withFont(
              base: pw.Font.ttf(await rootBundle.load("Gilroy-Regular.ttf")),
              bold: pw.Font.ttf(await rootBundle.load("Gilroy-Bold.ttf"))),
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Column(children: [
                for (int index = 4; index < length; index++) ...[
                  pw.Padding(
                      padding: pw.EdgeInsets.only(left: 30, right: 30, top: 20),
                      child:
                          orderComponent(order.orderItems[index], montserrat))
                ]
              ]),
              pw.SizedBox(height: 10),
              if (order.orderItems.length <= 11)
                priceContent(
                  order,
                  montserrat,
                ),
              // pw.Padding(padding: pw.EdgeInsets.only(bottom: 30),)
            ]);
          }));
    }

    if (order.orderItems.length > 13) {
      pdf.addPage(pw.Page(
          margin: pw.EdgeInsets.only(top: 20),
          theme: pw.ThemeData.withFont(
              base: pw.Font.ttf(await rootBundle.load("Gilroy-Regular.ttf")),
              bold: pw.Font.ttf(await rootBundle.load("Gilroy-Bold.ttf"))),
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Column(children: [
                for (int index = 11;
                    index < order.orderItems.length;
                    index++) ...[
                  pw.Padding(
                      padding: pw.EdgeInsets.only(left: 30, right: 30, top: 20),
                      child:
                          orderComponent(order.orderItems[index], montserrat))
                ]
              ]),
              pw.SizedBox(height: 40),
              if (order.orderItems.length != 12 &&
                  order.orderItems.length != 13)
                priceContent(
                  order,
                  montserrat,
                ),
              // pw.Padding(padding: pw.EdgeInsets.only(bottom: 30),)
            ]);
          }));
    }

    if (order.orderItems.length == 4 ||
        order.orderItems.length == 12 ||
        order.orderItems.length == 13) {
      pdf.addPage(pw.Page(
          margin: pw.EdgeInsets.only(top: 20),
          theme: pw.ThemeData.withFont(
              base: pw.Font.ttf(await rootBundle.load("Gilroy-Regular.ttf")),
              bold: pw.Font.ttf(await rootBundle.load("Gilroy-Bold.ttf"))),
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.SizedBox(height: 40),
              priceContent(
                order,
                montserrat,
              ),
            ]);
          }));
    }

    final bytes = await pdf.save();
    final blob = Blob([bytes], 'application/pdf');
    final url = Url.createObjectUrlFromBlob(blob);
    window.open(url, '_blank');
    Url.revokeObjectUrl(url);
    setState(() {
      isDownload = false;
    });
    return (String foo) {};
  }
}

pw.Widget headerContent(
  OrderDataModel orderData,
  Uint8List logoByteList,
) {
  return pw.Column(children: [
    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Image(pw.MemoryImage(logoByteList), height: 100, width: 100),
      pw.Padding(
        padding: pw.EdgeInsets.only(right: 15),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("${sharedPrefs.businessName.toUpperCase()}",
                style: pw.TextStyle(
                  fontSize: 19,
                  fontWeight: pw.FontWeight.bold,
                )),
          ],
        ),
      )
    ]),
    pw.SizedBox(height: 40),
    pw.Padding(
        padding: pw.EdgeInsets.only(left: 10, right: 10),
        child: pw.Column(children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("Date",
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.normal)),
              pw.Text("${dateFormat(orderData.createdDateTime!)}",
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
            ],
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 5.0),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Order ID",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.normal)),
                pw.Text("${orderData.orderId.toString().split("_")[0]}",
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold))
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 5.0),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Name",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.normal)),
                pw.Text("${sharedPrefs.customer_name}",
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold))
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 5.0),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Mobile",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.normal)),
                pw.Text("${sharedPrefs.customer_mobileNo}",
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold))
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 5.0),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Payment Method",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.normal)),
                pw.Text("${orderData.paymentType}",
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold))
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 5.0),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Address",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.normal)),
                pw.Text(
                    "${orderData.deliveryAddress.subAddress}" +
                        " " +
                        "${orderData.deliveryAddress.area}",
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold))
              ],
            ),
          ),
        ]))
  ]);
}

pw.Widget priceContent(
  OrderDataModel orderData,
  final montserrat,
) {
  return pw.Column(children: [
    pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
            padding: pw.EdgeInsets.only(left: 30, right: 30),
            child: pw.Column(children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Item Total",
                      style: pw.TextStyle(
                        fontSize: 13,
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.Text("₹ " + "${orderData.itemTotalAmount}",
                      style: pw.TextStyle(font: montserrat)),
                ],
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10.0),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Delivery Fee"),
                    pw.Text("₹ ${orderData.deliveryCharges}",
                        style: pw.TextStyle(font: montserrat))
                  ],
                ),
              ),
              pw.ListView.builder(
                  direction: pw.Axis.vertical,
                  itemBuilder: (context, index) => pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 10.0),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                                "${orderData.taxPercentage[index].taxName}(${orderData.taxPercentage[index].taxPercentage})"),
                            pw.Text(
                                "₹ " +
                                    "${orderData.taxPercentage[index].amount}",
                                style: pw.TextStyle(font: montserrat))
                          ],
                        ),
                      ),
                  itemCount: orderData.taxPercentage.length),
            ]))
      ],
    ),
    pw.Padding(
      padding: const pw.EdgeInsets.only(top: 15.0),
      child: pw.Container(
        height: 70,
        color: PdfColors.deepPurple,
        child: pw.Padding(
          padding: pw.EdgeInsets.only(left: 30, right: 30),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("Total",
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 17,
                  )),
              pw.Text("₹ " + "${orderData.orderAmount}",
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      font: montserrat,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 17)),
            ],
          ),
        ),
      ),
    )
  ]);
}

//component
pw.Widget orderComponent(OrderItem orderItems, final montserrat) {
  return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
    pw.Text("${orderItems.productDetails.productName}",
        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        maxLines: 1,
        overflow: pw.TextOverflow.clip),
    pw.SizedBox(height: 5),
    pw.Row(children: [
      pw.Expanded(
        child: pw.Row(
          children: [
            pw.Text("${orderItems.productQuantity}",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 0.0),
              child: pw.Text(
                  " X ₹ ${orderItems.productDetails.productSellingPrice}",
                  style: pw.TextStyle(
                      fontSize: 15, color: PdfColors.black, font: montserrat)),
            )
          ],
        ),
      ),
      pw.Text(
          "₹" +
              "${orderItems.productQuantity * orderItems.productDetails.productSellingPrice.toDouble()}",
          style: pw.TextStyle(font: montserrat, fontSize: 15)),
    ]),
    pw.Padding(
      padding: const pw.EdgeInsets.only(top: 8.0),
      child: pw.Divider(
        color: PdfColors.grey,
        thickness: 0.2,
      ),
    ),
  ]);
}

//Date Format Function
String dateFormat(DateTime date) {
  final DateFormat formatter = DateFormat('MMM dd, yyyy  HH:MM a');
  final String formatted = formatter.format(date);
  return formatted;
}
