import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/CommonWidgets/TopButton.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Views/ProductDetail.dart';

class CategorySubScreen extends StatefulWidget {
  const CategorySubScreen({Key? key}) : super(key: key);

  @override
  _CategorySubScreenState createState() => _CategorySubScreenState();
}

class _CategorySubScreenState extends State<CategorySubScreen> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Clothing"),
      ),
      body: Column(
        children: [
          Space(
            height: 4,
          ),
          TopButtons(onChanged: (value) {
            setState(() {
              isGrid = value;
            });
            print(value);
          }),
          Expanded(
            child: GridView.builder(
              itemCount: 10,
              padding: EdgeInsets.only(left: 10, right: 10, top: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: isGrid ? 2 : 1,
                  childAspectRatio: isGrid ? 0.75 : 3.5),
              itemBuilder: (BuildContext context, int index) {
                return Container(
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
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, bottom: 15.0),
                                  child: SizedBox(
                                    child: FloatingActionButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(Icons.close, size: 16),
                                        backgroundColor: Colors.white),
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0))),
                                    child: ProductDescription()),
                              ],
                            );
                          });
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 8.0, top: 6),
                      child: isGrid
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Space(
                                  height: 5,
                                ),
                                ProductRating(),
                                ProductImage(),
                                ProductDetail(isGridView: isGrid)
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductImage(),
                                  Space(width: 8),
                                  Expanded(
                                      child: ProductDetail(isGridView: isGrid)),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: ProductRating(),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6.0),
                                        child: AddRemoveButton(),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  bool isGridView = true;
  ProductDetail({required this.isGridView});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product name",
          style: boldTitleText,
        ),
        Text(
          "Description",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 11,
              color: Colors.grey.shade400),
        ),
        Space(height: 4),
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
                          fontFamily: "", fontSize: 12, color: Colors.black87),
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
            Space(width: 4),
            isGridView ? AddRemoveButton() : SizedBox()
          ],
        )
      ],
    );
  }
}

class ProductRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 15),
        Text("4.5", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 110,
            width: 90,
            child: Image.network(
                "https://i.pinimg.com/originals/5d/ff/fc/5dfffc72a434a57037433570ec391dc1.png")));
  }
}
