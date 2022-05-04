// ignore_for_file: must_call_super, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/NewCartModel.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class AddRemoveButtonBulk extends StatefulWidget {
  ProductData productData;
  bool isRounded = true;
  int qty = 0;
  double price = 0;

  AddRemoveButtonBulk({
    required this.productData,
    required this.isRounded,
    required this.qty,
    required this.price,
  });

  @override
  _AddRemoveButtonBulkState createState() => _AddRemoveButtonBulkState();
}

class _AddRemoveButtonBulkState extends State<AddRemoveButtonBulk> {
  int q = 0;
  String? cartId;

  @override
  void initState() {
    super.initState();
    updateQuantity();
  }

  Future addToCart() async {
    var cartProvider = Provider.of<CartDataWrapper>(context, listen: false);
    if (widget.productData.isStock) {
      if (widget.qty <= widget.productData.stockLeft) {
        cartProvider.cartData.add(
          NewCartModel(
              productId: widget.productData.productId,
              productColor: null,
              productImageUrl: widget.productData.productImageUrl,
              productQuantity: widget.qty,
              productMrp: widget.price,
              productName: "${widget.productData.productName}",
              productSellingPrice: widget.price,
              productSize: null,
              isBulk: true,
              rating: widget.productData.productRatingAverage),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Not in Stock",
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
      }
    } else {
      cartProvider.cartData.add(
        NewCartModel(
            productId: widget.productData.productId,
            productColor: null,
            productImageUrl: widget.productData.productImageUrl,
            productQuantity: widget.qty,
            productMrp: widget.price,
            productName: "${widget.productData.productName}",
            productSellingPrice: widget.price,
            productSize: null,
            isBulk: true,
            rating: widget.productData.productRatingAverage),
      );
    }

    cartProvider.loadCartData();
  }

  Future deleteCart() async {
    var provider = Provider.of<CartDataWrapper>(context, listen: false);
    provider.deleteFromCart(productId: widget.productData.productId);
    provider.loadCartData();
  }

  @override
  void didUpdateWidget(oldWidget) {
    // updateQuantity();
  }

  updateQuantity() {
    q = Provider.of<CartDataWrapper>(context, listen: false)
        .getIndividualQuantity(productId: widget.productData.productId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartDataWrapper>(context);
    var themeProvider = Provider.of<ThemeColorProvider>(context);

    return cartProvider.getIndividualQuantity(
                productId: widget.productData.productId) ==
            0
        ? widget.isRounded
            ? SizedBox(
                width: 40,
                height: 40,
                child: Card(
                  shape: CircleBorder(),
                  elevation: 0,
                  color: themeProvider.appPrimaryMaterialColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          addToCart();
                        },
                        child: Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 40,
                width: 93,
                child: InkWell(
                  onTap: () {
                    if (widget.qty > 0) addToCart();
                    if (widget.qty == 0)
                      Fluttertoast.showToast(
                          msg: "quantity should be greater than 0",
                          webPosition: "center",
                          webBgColor:
                              "linear-gradient(to right, #5A5A5A, #5A5A5A)");
                  },
                  child: Card(
                    elevation: 0,
                    color: themeProvider.appPrimaryMaterialColor,
                    child: Center(
                      child: Text("Add to Cart",
                          style: FontsTheme.boldTextStyle(
                              color: Colors.white, size: 9)),
                    ),
                  ),
                ),
              )
        : SizedBox(
            height: 40,
            width: 93,
            child: InkWell(
              onTap: () => deleteCart(),
              child: Card(
                elevation: 0,
                color: themeProvider.appPrimaryMaterialColor,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Consumer<CartDataWrapper>(
                        builder: (context, CartDataWrapper value, child) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "${value.getIndividualQuantity(productId: widget.productData.productId)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  fontFamily: "Poppins"),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.delete,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
