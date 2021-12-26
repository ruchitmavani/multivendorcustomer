import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class RecentlyBought extends StatefulWidget {
  final ProductData productData;

  RecentlyBought({required this.productData});

  @override
  _RecentlyBoughtState createState() => _RecentlyBoughtState();
}

class _RecentlyBoughtState extends State<RecentlyBought> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4,left: 4, top: 6.0,bottom: 2),
      child: SizedBox(
        width: 180,
        child: InkWell(
          onTap: () {
            context.go(helper(
                PageCollection.product + '/${widget.productData.productId}'));
          },
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
                      child: widget.productData.productImageUrl.length == 0
                          ? Image.asset("images/placeholder.png")
                          : Image.network(
                              "${StringConstants.api_url}${widget.productData.productImageUrl.first}"),
                    ),
                  ),
                  Space(height: 8),
                  Text(
                    "${widget.productData.productName}",
                    overflow: TextOverflow.ellipsis,
                    style: FontsTheme.subTitleStyle(),
                  ),
                  Text("${widget.productData.productDescription}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FontsTheme.descriptionText(
                          size: 11, fontWeight: FontWeight.w500)),
                  Space(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(widget.productData.productSellingPrice!=widget.productData.productMrp)  Text(
                            "\u{20B9} ${widget.productData.productMrp}",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade700,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                                decorationColor:
                                    Provider.of<CustomColor>(context)
                                        .appPrimaryMaterialColor,
                                decorationThickness: 3),
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
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
