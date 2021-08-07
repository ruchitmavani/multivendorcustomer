import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Views/OrderDetails.dart';

class OrderComponent extends StatefulWidget {
  const OrderComponent({Key? key}) : super(key: key);

  @override
  _OrderComponentState createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => OrderDetails()));
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
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                "https://thumbs.dreamstime.com/b/transparent-photoshop-psd-png-seamless-grid-pattern-background-transparent-photoshop-psd-png-seamless-grid-pattern-background-grey-175598426.jpg",
                                width: 23,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 3.0),
                                child: Image.network(
                                  "https://thumbs.dreamstime.com/b/transparent-photoshop-psd-png-seamless-grid-pattern-background-transparent-photoshop-psd-png-seamless-grid-pattern-background-grey-175598426.jpg",
                                  width: 23,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Row(
                              children: [
                                Image.network(
                                  "https://thumbs.dreamstime.com/b/transparent-photoshop-psd-png-seamless-grid-pattern-background-transparent-photoshop-psd-png-seamless-grid-pattern-background-grey-175598426.jpg",
                                  width: 23,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 3.0),
                                  child: Image.network(
                                    "https://thumbs.dreamstime.com/b/transparent-photoshop-psd-png-seamless-grid-pattern-background-transparent-photoshop-psd-png-seamless-grid-pattern-background-grey-175598426.jpg",
                                    width: 23,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 13.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Copper Flask",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text("and 21 other items...",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  )),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 6.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total amount",
                                        style: FontsTheme.subTitleStyle(
                                            fontWeight:
                                            FontWeight.w500)),
                                    Row(
                                      children: [
                                        Text("\u{20B9}",
                                            style:
                                            FontsTheme.digitStyle(
                                                size: 13)),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 2.0),
                                          child: Text("6999",
                                              style:
                                              FontsTheme.digitStyle(
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
                              "The flash shop",
                              style: FontsTheme.subTitleStyle(),
                            ),
                          ),
                          Text("Sowcarpet",
                              style: FontsTheme.subTitleStyle(
                                  size: 11,
                                  fontWeight: FontWeight.w500)),
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
                                    color: appPrimaryMaterialColor,
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
