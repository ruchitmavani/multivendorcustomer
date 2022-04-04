import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> shareInvoice(
    BuildContext context, OrderDataModel orderData, String themeColor) async {
  var pdf = pw.Document();
  ByteData? imageData;
  final font =
      await rootBundle.load('Gilroy-Bold.ttf').then((data) => imageData = data);
  final gilroyBold = pw.Font.ttf(font);
  final montserrat = await PdfGoogleFonts.montserratSemiBold();

  // final image = PdfImage.jpeg(
  //     doc.document,
  //     image: imageData.buffer.asUint8List()
  // );
  final Uint8List logoByteList = imageData!.buffer.asUint8List();

  pdf.addPage(pw.Page(
      margin: pw.EdgeInsets.only(top: 30, bottom: 10),
      theme: pw.ThemeData.withFont(
          base: await PdfGoogleFonts.montserratSemiBold()),
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(right: 20, left: 20),
            child: headerContent(orderData, logoByteList),
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
                        orderData.orderItems.length >= 4
                            ? 4
                            : orderData.orderItems.length, (index) {
                      return pw.Padding(
                          padding:
                              pw.EdgeInsets.only(left: 30, right: 30, top: 20),
                          child: orderComponent(
                            orderData.orderItems[index],
                            montserrat,
                          ));
                    }),
                  ),
                )),
          ),
          if (orderData.orderItems.length <= 3)
            priceContent(orderData, montserrat, gilroyBold)
        ]);
      }));

  if (orderData.orderItems.length > 4) {
    int lenght =
        orderData.orderItems.length >= 11 ? 11 : orderData.orderItems.length;
    pdf.addPage(pw.Page(
        margin: pw.EdgeInsets.only(top: 20),
        theme: pw.ThemeData.withFont(
            base: Font.ttf(await rootBundle.load("fonts/Gilroy-Regular.ttf")),
            bold: Font.ttf(await rootBundle.load("fonts/Gilroy-Bold.ttf"))),
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Column(children: [
              for (int index = 4; index < lenght; index++) ...[
                pw.Padding(
                    padding: pw.EdgeInsets.only(left: 30, right: 30, top: 20),
                    child:
                        orderComponent(orderData.orderItems[index], montserrat))
              ]
            ]),
            pw.SizedBox(height: 10),
            if (orderData.orderItems.length <= 11)
              priceContent(orderData, montserrat, gilroyBold),
            // pw.Padding(padding: pw.EdgeInsets.only(bottom: 30),)
          ]);
        }));
  }

  if (orderData.orderItems.length > 13) {
    pdf.addPage(pw.Page(
        margin: pw.EdgeInsets.only(top: 20),
        theme: pw.ThemeData.withFont(
            base: Font.ttf(await rootBundle.load("fonts/Gilroy-Regular.ttf")),
            bold: Font.ttf(await rootBundle.load("fonts/Gilroy-Bold.ttf"))),
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Column(children: [
              for (int index = 11;
                  index < orderData.orderItems.length;
                  index++) ...[
                pw.Padding(
                    padding: pw.EdgeInsets.only(left: 30, right: 30, top: 20),
                    child:
                        orderComponent(orderData.orderItems[index], montserrat))
              ]
            ]),
            pw.SizedBox(height: 40),
            if (orderData.orderItems.length != 12 &&
                orderData.orderItems.length != 13)
              priceContent(orderData, montserrat, gilroyBold),
            // pw.Padding(padding: pw.EdgeInsets.only(bottom: 30),)
          ]);
        }));
  }

  if (orderData.orderItems.length == 4 ||
      orderData.orderItems.length == 12 ||
      orderData.orderItems.length == 13) {
    pdf.addPage(pw.Page(
        margin: pw.EdgeInsets.only(top: 20),
        theme: pw.ThemeData.withFont(
            base: Font.ttf(await rootBundle.load("fonts/Gilroy-Regular.ttf")),
            bold: Font.ttf(await rootBundle.load("fonts/Gilroy-Bold.ttf"))),
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.SizedBox(height: 40),
            priceContent(orderData, montserrat, gilroyBold),
          ]);
        }));
  }

  final bytes = await pdf.save();
  final blob = Blob([bytes], 'application/pdf');
  final url = Url.createObjectUrlFromBlob(blob);
  window.open(url, '_blank');
  Url.revokeObjectUrl(url);
  return await pdf.save();
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
    OrderDataModel orderData, final montserrat, final gilroy) {
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
                          font: gilroy)),
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
                      font: gilroy)),
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
