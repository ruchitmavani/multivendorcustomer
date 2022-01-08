import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class OrderComponent extends StatefulWidget {
  final OrderDataModel orderData;

  OrderComponent({required this.orderData});

  @override
  _OrderComponentState createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).push( helper(PageCollection.order),
              extra: widget.orderData);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) => OrderDetails(
          //       orderData: widget.orderData,
          //     ),
          //   ),
          // );
        },
        child: Card(
            elevation: 0.1,
            margin: EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(width: 0.9, color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 49, maxWidth: 49),
                        child: widget.orderData.orderItems.length != 1
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    widget.orderData.orderItems.length >= 4
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
                                  return widget.orderData.orderItems
                                              .elementAt(index)
                                              .productDetails
                                              .productImageUrl
                                              .length ==
                                          0
                                      ? Image.asset(
                                          "images/placeholder.png",
                                          width: 23,
                                          height: 23,
                                        )
                                      : Image.network(
                                          "${StringConstants.api_url}${widget.orderData.orderItems.elementAt(index).productDetails.productImageUrl.first}",
                                          width: 23,
                                          height: 23,
                                        );
                                },
                              )
                            : widget.orderData.orderItems
                                        .elementAt(0)
                                        .productDetails
                                        .productImageUrl
                                        .length !=
                                    0
                                ? Image.network(
                                    "${StringConstants.api_url}${widget.orderData.orderItems.elementAt(0).productDetails.productImageUrl.first}",
                                    width: 50,
                                    height: 50,
                                  )
                                : Image.asset(
                                    "images/placeholder.png",
                                    width: 50,
                                    height: 50,
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
                                  widget.orderData.orderItems.length - 1 == 0
                                      ? "1 item"
                                      : "and ${widget.orderData.orderItems.length - 1} other items...",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w600,
                                    // fontStyle: FontStyle.italic,
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
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Text(
                                              "${widget.orderData.orderAmount}",
                                              style: FontsTheme.digitStyle(
                                                  fontSize: 13)),
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
                              style: FontsTheme.gilroyText(
                                color: Colors.black87,
                                size: 12
                              ),
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
                            color: Provider.of<CustomColor>(context)
                                .appPrimaryMaterialColor
                                .withOpacity(0.1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(17.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                              child: Text(
                                widget.orderData.orderStatus.isNotEmpty
                                    ? "${widget.orderData.orderStatus.last}"
                                    : "",
                                style: FontsTheme.boldTextStyle(
                                    color: Provider.of<CustomColor>(context)
                                        .appPrimaryMaterialColor,
                                    size: 11),
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
