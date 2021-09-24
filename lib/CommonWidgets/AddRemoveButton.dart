// ignore_for_file: must_call_super, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/CartController.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:provider/provider.dart';

class AddRemoveButton extends StatefulWidget {
  ProductData productData;
  bool isRounded = true;
  int colorIndex = 0;
  int sizeIndex = 0;

  AddRemoveButton(
      {required this.productData,
      required this.isRounded,
      required this.colorIndex,
      required this.sizeIndex});

  @override
  _AddRemoveButtonState createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  int q = 0;
  String? cartId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        q = widget.productData.cartDetails == null
            ? 0
            : widget.productData.cartDetails!.productQuantity;
      });
    });
  }

  Future addToCart() async {
    if (sharedPrefs.customer_id.isEmpty) {
      Navigator.pushNamed(context, PageCollection.login);
      return;
    }
    await CartController.addToCart(
            customerId: "${sharedPrefs.customer_id}",
            vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .vendorUniqId,
            productId: widget.productData.productId,
            quantity: 1,
            mrp: widget.productData.productMrp,
            isActive: widget.productData.productVariationSizes!.length != 0
                ? widget.productData.productVariationSizes!
                    .elementAt(widget.sizeIndex)
                    .isActive
                : false,
            size: widget.productData.productVariationSizes!.length!=0?widget.productData.productVariationSizes!
                .elementAt(widget.sizeIndex)
                .size:"",
            colorCode:widget.productData.productVariationColors!.length!=0? widget.productData.productVariationColors!
                .elementAt(widget.colorIndex)
                .colorCode:"3242161711",
            sellingPrice: widget.productData.productVariationSizes!.length!=0?widget.productData.productVariationSizes!
                .elementAt(widget.sizeIndex)
                .sellingPrice:0,
            isColorActive: widget.productData.productVariationColors!.length!=0?widget.productData.productVariationColors!
                .elementAt(widget.colorIndex)
                .isActive:false,
            isVarientAvailable: widget.productData.productVariationColors!.length!=0?true:false)
        .then((value) {
      if (value.success) {
        setState(() {
          q++;
          cartId = value.data!.cartId;
        });
        Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
            vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .vendorUniqId);
      } else {}
    }, onError: (e) {
      print(e);
    });
  }

  Future deleteCart() async {
    log("--cart id $cartId");
    log("--cart id ${widget.productData.cartDetails!.cartId}");

    await CartController.deleteCart(
            cartId: cartId != null
                ? "$cartId"
                : "${widget.productData.cartDetails!.cartId}")
        .then((value) {
      if (value.success) {
        print(value.success);
        print(value.data);
        setState(() {
          q = 0;
        });
        Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
            vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .vendorUniqId);
      } else {}
    }, onError: (e) {
      print(e);
    });
  }

  Future updateCart(int quantity) async {
    log("--cart id $cartId");
    await CartController.update(jsonMap: {
      "cart_id":
          cartId != null ? cartId : widget.productData.cartDetails!.cartId,
      "product_quantity": quantity
    }).then((value) {
      if (value.success) {
        setState(() {
          print(quantity);
          q = quantity;
        });
        Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
            vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .vendorUniqId);
      } else {}
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void didUpdateWidget(oldWidget) {
    updateQuantity();
  }

  updateQuantity() {
    q = Provider.of<CartDataWrapper>(context, listen: false)
        .getIndividualQuantity(productId: widget.productData.productId);
    print("q uapdted to $q");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return q == 0
        ? widget.isRounded
            ? SizedBox(
                width: 35,
                height: 35,
                child: Card(
                  shape: CircleBorder(),
                  elevation: 0,
                  color: appPrimaryMaterialColor[700],
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
            : ElevatedButton(
                onPressed: () {
                  addToCart();
                },
                child: Text("Add to Cart",
                    style: FontsTheme.boldTextStyle(color: Colors.white)),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(appPrimaryMaterialColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              )
        : SizedBox(
            width: 85,
            height: 35,
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
                        onTap: () {
                          if (q > 1) {
                            updateCart((q - 1));
                          } else if (q == 1) {
                            deleteCart();
                          }
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
                      child: Text(
                        "$q",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          updateCart((q + 1));
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
          );
  }
}
