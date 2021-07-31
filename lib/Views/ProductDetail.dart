import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  List<Color> colorList = [Colors.black87, Colors.red];
  List<String> sizeList = ["S", "M", "L"];
  int currentIndex = 0;
  int currentSizeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: ListView(
                children: [
                  Space(
                    height: 20,
                  ),
                  SizedBox(
                      height: 230,
                      child: Image.network(
                          "https://images-na.ssl-images-amazon.com/images/I/61ihz46SLOL._SL1500_.jpg")),
                  Space(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(4.0)),
                          width: 50,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.network(
                                "https://images-na.ssl-images-amazon.com/images/I/61ihz46SLOL._SL1500_.jpg"),
                          )),
                      Space(width: 6),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(4.0)),
                          width: 50,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.network(
                                "https://images-na.ssl-images-amazon.com/images/I/61ihz46SLOL._SL1500_.jpg"),
                          )),
                      Space(width: 6),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(4.0)),
                          width: 50,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.network(
                                "https://images-na.ssl-images-amazon.com/images/I/61ihz46SLOL._SL1500_.jpg"),
                          )),
                      Space(width: 6),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(4.0)),
                          width: 50,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.network(
                                "https://images-na.ssl-images-amazon.com/images/I/61ihz46SLOL._SL1500_.jpg"),
                          )),
                    ],
                  ),
                  Space(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sony Headphone",
                                  style: FontsTheme.boldTextStyle(size: 16)),
                              Space(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 18),
                                  Text("4.5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12))
                                ],
                              ),
                              Space(height: 8),
                              Text(
                                  "Lorem ipsum dolor sit amet, consectetuer adipis"
                                  "cing elit, sed diam nonummy nibh euismod"
                                  "tincid unt ut laoreet dolore magna.",
                                  style: FontsTheme.descriptionText(size: 13),
                                  textAlign: TextAlign.left),

                              // Color Option

                              Space(height: 20),
                              Text("Color option",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700)),
                              Space(height: 8),
                              Row(
                                children: colorList.map<Widget>((e) {
                                  int index = colorList.indexOf(e);

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        decoration: currentIndex == index
                                            ? BoxDecoration(
                                                border: Border.all(
                                                    width: 3,
                                                    color:
                                                        appPrimaryMaterialColor),
                                                borderRadius:
                                                    BorderRadius.circular(50.0))
                                            : null,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Container(
                                                  color: e,
                                                  height: 30,
                                                  width: 30)),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              // Size Option

                              Space(height: 18),
                              Text("Size Option",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700)),
                              Space(height: 8),
                              Row(
                                children: sizeList.map<Widget>((e) {
                                  int index = sizeList.indexOf(e);

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentSizeIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 3,
                                                color: currentSizeIndex == index
                                                    ? appPrimaryMaterialColor
                                                    : Colors.grey.shade400),
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              child: Container(
                                                  child: Center(
                                                      child: Text(e,
                                                          style: FontsTheme.boldTextStyle(
                                                              color: currentSizeIndex ==
                                                                      index
                                                                  ? appPrimaryMaterialColor
                                                                  : Colors.grey
                                                                      .shade400,
                                                              size: 17))),
                                                  height: 28,
                                                  width: 28)),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              Space(height: 6)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(2, 1), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "₹",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                          children: [
                        TextSpan(
                            text: " 1500", style: FontsTheme.boldTextStyle()),
                      ])),

                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Add to Cart",style: FontsTheme.boldTextStyle(color: Colors.white)),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              appPrimaryMaterialColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
