import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/AddRemoveButton.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/QuantityClass.dart';
import 'package:provider/provider.dart';

import '../CategorySubScreen.dart';

class ProductComponent extends StatefulWidget {
  ProductData productData;

  ProductComponent({required this.productData});

  @override
  _ProductComponentState createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4,top: 8.0, bottom: 8.0),
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
                        child: ProductImage(
                          banners: widget.productData.productImageUrl.length > 0
                              ? widget.productData.productImageUrl
                              : ["https://i.stack.imgur.com/y9DpT.jpg"],
                          gridView: false,
                        ))),
                Space(height: 8),
                Text(
                  "${widget.productData.productName}",
                  style: FontsTheme.subTitleStyle(),
                ),
                Text(
                  "${widget.productData.productDescription}",
                  style: FontsTheme.descriptionText(
                      size: 11, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
                                      "${widget.productData.productMrp}",
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
                              "${widget.productData.productSellingPrice}",
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
                    SizedBox(
                      width: 85,
                      height:35,
                      child: Card(
                        elevation: 0,
                        color: appPrimaryMaterialColor[700],
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: (){
                                    Provider.of<Quantity>(context,listen: false).decrement();
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("${Provider.of<Quantity>(context,listen: true).quantity}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 11,fontFamily: "Poppins"),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: (){
                                    Provider.of<Quantity>(context,listen: false).increment();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
