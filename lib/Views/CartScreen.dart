import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/RoundedAddRemove.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/exports.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cart",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delivery address",
                            style: FontsTheme.descriptionText(
                                size: 13, color: Colors.black54)),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Home",
                                style: FontsTheme.boldTextStyle(size: 13),
                              ),
                              Text(
                                "Change",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 11,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Text(
                            "60, Mint Street,Sowcarpet...",
                            style: FontsTheme.descriptionText(
                                size: 13, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade200),
              SizedBox(height: 25),
              ListView.separated(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12, top: 8, bottom: 8),
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
                              children: [
                                Text("Nike",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600)),
                                Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Positioned(
                                          child: Container(
                                            height: 1.5,
                                            color: Colors.red.shade600,
                                            width: 44,
                                          ),
                                          top: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\u{20B9}",
                                                      style: TextStyle(
                                                          fontFamily: "",
                                                          fontSize: 11,
                                                          color: Colors
                                                              .red.shade700),
                                                    ),
                                                    Text(
                                                      "250.00",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors
                                                              .red.shade700,
                                                          fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\u{20B9}",
                                                      style: TextStyle(
                                                          fontFamily: "",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                    Text(
                                                      "250.00",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.black87,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            RoundedAddRemove()
                                          ],
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
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[300],
                  thickness: 0.6,
                ),
              ),
              SizedBox(height: 35),
              Container(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(AppIcons.offer),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Text("Apply coupon",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600)),
                          )),
                          Text(
                            "View",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 11,
                                color: appPrimaryMaterialColor,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade100),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: SizedBox(
                        height: 25,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text("Discount Applied"),
                          trailing: Text("256.00"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SizedBox(
                        height: 25,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text("Tax"),
                          trailing: Text("256.00"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SizedBox(
                        height: 25,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text("Shipping Fee"),
                          trailing: Text("256.00"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SizedBox(
                        height: 35,
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            "Total",
                            style: FontsTheme.boldTextStyle(
                              size: 14,
                            ),
                          ),
                          trailing: Text(
                            "316.00",
                            style: FontsTheme.boldTextStyle(
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius:3,
              blurRadius: 5,

            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              child: Container(
                height: 48,
                 color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\u{20B9}",
                      style: TextStyle(
                          fontFamily: "", fontSize: 17, color: Colors.black87),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        "250.00",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                color: appPrimaryMaterialColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Center(
                    child: Text(
                      "PAY",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
