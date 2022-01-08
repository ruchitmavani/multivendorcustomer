import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


shareInvtoice(BuildContext context, OrderDataModel orderData) async {
  var pdf = pw.Document();
  ByteData? imageData;
  await rootBundle
      .load('Gilroy-Bold.ttf')
      .then((data) => imageData = data);
  // final image = PdfImage.jpeg(
  //     doc.document,
  //     image: imageData.buffer.asUint8List()
  // );
  final Uint8List logoByteList = imageData!.buffer.asUint8List();
  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData.withFont(
          base: await PdfGoogleFonts.montserratSemiBold()),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 12.0, left: 8, right: 15),
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(pw.MemoryImage(logoByteList),
                        height: 100, width: 100),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 8.0),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("${sharedPrefs.businessName}",
                              style: pw.TextStyle(
                                  fontSize: 19,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.Text("${orderData.deliveryAddress.city}",
                              style: pw.TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ]),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 20.0, right: 20, top: 45),
              child: pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Date",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal)),
                      pw.Text("${orderData.createdDateTime}",
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 5.0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Order ID",
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.normal)),
                        pw.Text("${orderData.orderId}",
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.normal))
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 5.0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Name", style: pw.TextStyle(fontSize: 14)),
                        pw.Text("${sharedPrefs.customer_name}",
                            style: pw.TextStyle(fontSize: 12))
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 5.0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Mobile", style: pw.TextStyle(fontSize: 14)),
                        pw.Text(
                            "${sharedPrefs.customer_mobileNo}",
                            style: pw.TextStyle(fontSize: 12))
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
                                fontSize: 14, fontWeight: pw.FontWeight.bold)),
                        pw.Text("${orderData.paymentType}",
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold))
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
                                fontSize: 14, fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            "${orderData.deliveryAddress.subAddress}" +
                                " " +
                                "${orderData.deliveryAddress.area}",
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold))
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 45),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text("ORDER DETAIL",
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 11.0),
              child: pw.Column(
                children: List.generate(
                    orderData.orderItems.length,
                        (index) =>
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(
                              top: 10, left: 20.0, right: 21),
                          child: pw.Container(
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(
                                  child: pw.Column(
                                    crossAxisAlignment:
                                    pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                        children: [
                                          pw.Expanded(
                                            child: pw.Padding(
                                              padding: const pw.EdgeInsets.only(
                                                  left: 14.0),
                                              child: pw.Column(
                                                crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.Text(
                                                      "${orderData
                                                          .orderItems[index]
                                                          .productDetails
                                                          .productName}",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.Padding(
                                                    padding: const pw
                                                        .EdgeInsets.only(
                                                        top: 5.0),
                                                    child: pw.Row(
                                                      mainAxisAlignment: pw
                                                          .MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        pw.Row(
                                                          children: [
                                                            pw.Container(
                                                              decoration: pw
                                                                  .BoxDecoration(
                                                                  borderRadius: pw
                                                                      .BorderRadius
                                                                      .circular(
                                                                      3)),
                                                              height: 22,
                                                              width: 22,
                                                              child: pw.Center(
                                                                child: pw.Text(
                                                                    "${orderData
                                                                        .orderItems[index]
                                                                        .productQuantity}",
                                                                    style: pw
                                                                        .TextStyle(
                                                                        fontWeight: pw
                                                                            .FontWeight
                                                                            .bold)),
                                                              ),
                                                            ),
                                                            pw.Padding(
                                                              padding: const pw
                                                                  .EdgeInsets
                                                                  .only(
                                                                  left: 9.0),
                                                              child:
                                                              pw.RichText(
                                                                  text: pw
                                                                      .TextSpan(
                                                                      text:
                                                                      "₹",
                                                                      style: pw
                                                                          .TextStyle(
                                                                          fontSize: 12,
                                                                          color: PdfColors
                                                                              .black),
                                                                      children: [
                                                                        pw
                                                                            .TextSpan(
                                                                            text:
                                                                            " X ${orderData
                                                                                .orderItems[index]
                                                                                .productDetails
                                                                                .productSellingPrice}")
                                                                      ])),
                                                            )
                                                            /*pw.Text("x  ₹$productPrice",
                                                  style: FontsTheme.valueStyle(
                                                      fontWeight: FontWeight.w600)),*/
                                                          ],
                                                        ),
                                                        pw.Text("₹ " +
                                                            "${orderData
                                                                .orderItems[index]
                                                                .productQuantity
                                                                .toDouble() *
                                                                orderData
                                                                    .orderItems[index]
                                                                    .productDetails
                                                                    .productSellingPrice
                                                                    .toDouble()}"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      pw.Padding(
                                        padding:
                                        const pw.EdgeInsets.only(top: 15.0),
                                        child: pw.Divider(
                                          color: PdfColors.grey,
                                          thickness: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 30.0, left: 20, right: 20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Item Total",
                          style: pw.TextStyle(
                              fontSize: 13, fontWeight: pw.FontWeight.bold)),
                      pw.Text("₹ " + "${orderData.itemTotalAmount}"),
                    ],
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 10.0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Delivery Fee"),
                        pw.Text("${orderData.deliveryCharges}")
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 10.0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Tax( ${orderData.taxPercentage} )"),
                        pw.Text("₹ " + "${orderData.taxAmount}")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 60.0),
              child: pw.Container(
                height: 70,
                color: PdfColors.deepPurple,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.only(
                      top: 10.0, bottom: 10, right: 20, left: 20),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Total",
                          style: pw.TextStyle(color: PdfColors.white)),
                      pw.Text("₹ " + "${orderData.orderAmount}",
                          style: pw.TextStyle(color: PdfColors.white)),
                    ],
                  ),
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 8.0, left: 10, bottom: 10),
            ),
          ],
        );
      },
    ),
  );

  final bytes = await pdf.save();
  final blob = Blob([bytes], 'application/pdf');
  final url = Url.createObjectUrlFromBlob(blob);
  window.open(url, '_blank');
  Url.revokeObjectUrl(url);
  return await pdf.save();

  // final String dir = (await getApplicationDocumentsDirectory()).path;
  // final String path = '$dir/Store_Qrcode.pdf';
  // final File file = File(path);
  // file.writeAsBytesSync(List.from(await pdf.save()));
  // file.exists().then((value) => log("$value"));
  // Share.shareFiles(['$dir/Store_Qrcode.pdf']);
}
