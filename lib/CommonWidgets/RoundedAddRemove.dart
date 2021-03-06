// ignore_for_file: must_call_super, must_be_immutable, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Data/Models/NewCartModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class RoundedAddRemove extends StatefulWidget {
  NewCartModel productData;
  bool isBulk;

  RoundedAddRemove({required this.productData, required this.isBulk});

  @override
  _RoundedAddRemoveState createState() => _RoundedAddRemoveState();
}

class _RoundedAddRemoveState extends State<RoundedAddRemove> {
  int q = 0;

  Future deleteCart() async {
    var provider = Provider.of<CartDataWrapper>(context, listen: false);
    provider.deleteFromCart(
      productId: widget.productData.productId,
      productSize: widget.productData.productSize,
      productColor: widget.productData.productColor,
    );
    provider.loadCartData();
  }

  Future updateCart(int quantity) async {
    var provider = Provider.of<CartDataWrapper>(context, listen: false);

    provider.incrementQuantity(
      quantity: quantity,
      productId: widget.productData.productId,
      productSize: widget.productData.productSize,
      productColor: widget.productData.productColor,
    );
    provider.loadCartData();
  }

  @override
  void didUpdateWidget(oldWidget) {
    // updateQuantity();
  }

  updateQuantity() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider=Provider.of<ThemeColorProvider>(context);
    return widget.isBulk
        ? SizedBox(
            width: 74,
            height: 32,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: new BorderSide(color: Colors.grey.shade400, width: 0.8),
              ),
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
                            "${value.getIndividualQuantity(
                              productId: widget.productData.productId,
                              productSize: widget.productData.productSize,
                              productColor: widget.productData.productColor,
                            )}",
                            style: TextStyle(
                                color: themeProvider
                                    .appPrimaryMaterialColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                fontFamily: "Poppins"),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          deleteCart();
                        },
                        child: Icon(
                          Icons.delete,
                          size: 15,
                          color: themeProvider
                              .appPrimaryMaterialColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : SizedBox(
            width: 74,
            height: 32,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: new BorderSide(color: Colors.grey.shade400, width: 0.8),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          var cartProvider = Provider.of<CartDataWrapper>(
                              context,
                              listen: false);

                          if (cartProvider.getIndividualQuantity(
                                productId: widget.productData.productId,
                                productSize: widget.productData.productSize,
                                productColor: widget.productData.productColor,
                              ) >
                              1) {
                            updateCart(cartProvider.getIndividualQuantity(
                                  productId: widget.productData.productId,
                                  productSize: widget.productData.productSize,
                                  productColor: widget.productData.productColor,
                                ) -
                                1);
                          } else if (cartProvider.getIndividualQuantity(
                                productId: widget.productData.productId,
                                productSize: widget.productData.productSize,
                                productColor: widget.productData.productColor,
                              ) ==
                              1) {
                            deleteCart();
                          }
                        },
                        child: Icon(
                          Icons.remove,
                          size: 15,
                          color: themeProvider
                              .appPrimaryMaterialColor,
                        ),
                      ),
                    ),
                    Consumer<CartDataWrapper>(
                      builder: (context, CartDataWrapper value, child) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "${value.getIndividualQuantity(
                              productId: widget.productData.productId,
                              productSize: widget.productData.productSize,
                              productColor: widget.productData.productColor,
                            )}",
                            style: TextStyle(
                                color: themeProvider
                                    .appPrimaryMaterialColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                fontFamily: "Poppins"),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          var cartProvider = Provider.of<CartDataWrapper>(
                              context,
                              listen: false);
                          updateCart((cartProvider.getIndividualQuantity(
                                productId: widget.productData.productId,
                                productSize: widget.productData.productSize,
                                productColor: widget.productData.productColor,
                              )) +
                              1);
                        },
                        child: Icon(
                          Icons.add,
                          size: 15,
                          color: themeProvider
                              .appPrimaryMaterialColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
