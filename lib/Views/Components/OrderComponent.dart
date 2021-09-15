import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Views/OrderDetails.dart';

class OrderComponent extends StatefulWidget {
  final OrderDataModel orderData;

  OrderComponent({required this.orderData});

  @override
  _OrderComponentState createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetails(
              orderData: widget.orderData,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Card(
            elevation: 0.1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(width: 0.9, color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 13, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 49, maxWidth: 49),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.orderData.orderItems.length >= 4
                              ? 4
                              : widget.orderData.orderItems.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return Image.network(
                              "${StringConstants.API_URL}${widget.orderData.orderItems.first.productDetails.productImageUrl.elementAt(index)}",
                              width: 23,
                              height: 23,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.orderData.orderItems.first.productDetails.productName}",
                                style: FontsTheme.boldTextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                  "and ${widget.orderData.orderItems.length-1} other items...",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total amount",
                                        style: FontsTheme.subTitleStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey)),
                                    Row(
                                      children: [
                                        Text("\u{20B9}",
                                            style: FontsTheme.digitStyle(
                                                size: 13)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Text(
                                              "${widget.orderData.finalPaidAmount}",
                                              style: FontsTheme.digitStyle(
                                                  size: 13)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 0.8,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ordered from",
                              style: FontsTheme.descriptionText(
                                fontWeight: FontWeight.w500,
                                size: 10,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "${widget.orderData.vendorDetails.businessName}",
                              style: FontsTheme.subTitleStyle(),
                            ),
                          ),
                          Text(
                              "${widget.orderData.vendorDetails.businessCategory}",
                              style: FontsTheme.subTitleStyle(
                                  size: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 28,
                          width: 85,
                          decoration: BoxDecoration(
                            color: appPrimaryMaterialColor.shade100,
                            //border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(17.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                              child: Text(
                                "Track order",
                                style: FontsTheme.boldTextStyle(
                                    color: appPrimaryMaterialColor, size: 11),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
