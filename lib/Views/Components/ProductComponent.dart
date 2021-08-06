import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';

class ProductComponent extends StatefulWidget {
  @override
  _ProductComponentState createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: SizedBox(
        width: 180,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 2,
                blurRadius: 2,
                //offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space(height: 8),
                Center(
                    child: SizedBox(
                        height: 120,
                        width: 100,
                        child: Image.network(
                            "https://i.pinimg.com/originals/5d/ff/fc/5dfffc72a434a57037433570ec391dc1.png"))),
                Space(height: 8),
                Text(
                  "Product name",
                  style: FontsTheme.subTitleStyle(),
                ),
                Text("Description",
                    style: FontsTheme.descriptionText(
                        size: 11, fontWeight: FontWeight.w500)),
                Space(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              child: Container(
                                height: 2,
                                color: appPrimaryMaterialColor.shade900,
                                width: 120,
                              ),
                              top: 8,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "\u{20B9}",
                                      style: TextStyle(
                                          fontFamily: "",
                                          fontSize: 11,
                                          color: Colors.grey.shade700),
                                    ),
                                    Text(
                                      "250.00",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade700,
                                          fontSize: 11),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "\u{20B9}",
                              style: TextStyle(
                                  fontFamily: "",
                                  fontSize: 12,
                                  color: Colors.black87),
                            ),
                            Text(
                              "250.00",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                    Space(width: 8),
                    AddRemoveButton()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
