import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';

class OrderDetailComponent extends StatefulWidget {
  const OrderDetailComponent({Key? key}) : super(key: key);

  @override
  _OrderDetailComponentState createState() => _OrderDetailComponentState();
}

class _OrderDetailComponentState extends State<OrderDetailComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 13, bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "https://thumbs.dreamstime.com/b/transparent-photoshop-psd-png-seamless-grid-pattern-background-transparent-photoshop-psd-png-seamless-grid-pattern-background-grey-175598426.jpg",
            width: 55,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Copper flash CF-125",
                          style: FontsTheme.valueStyle(
                              size: 13, fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: appPrimaryMaterialColor,
                              size: 11,
                            ),
                            Space(
                              width: 2,
                            ),
                            Text(
                              "Rate",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: appPrimaryMaterialColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Space(
                    height: 17,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Qty : 1",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "\u{20B9}",
                            style: TextStyle(
                                fontFamily: "",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          Text(
                            "249",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
