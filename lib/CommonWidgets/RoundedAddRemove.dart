// ignore_for_file: must_call_super, must_be_immutable, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:provider/provider.dart';

class RoundedAddRemove extends StatefulWidget {
  String productId;

  RoundedAddRemove({
    required this.productId,
  });

  @override
  _RoundedAddRemoveState createState() => _RoundedAddRemoveState();
}

class _RoundedAddRemoveState extends State<RoundedAddRemove> {
  int q = 0;

  @override
  void initState() {
    super.initState();
  }

  Future deleteCart() async {
    var provider = Provider.of<CartDataWrapper>(context, listen: false);
    provider.deleteFromCart(productId: widget.productId);
    Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
        vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
            .vendorModel!
            .vendorUniqId);
    // await CartController.deleteCart(cartId: "${widget.cartData.cartId}").then(
    //     (value) {
    //   if (value.success) {
    //     print(value.success);
    //     print(value.data);
    //     setState(() {});
    //     Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
    //         vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
    //             .vendorModel!
    //             .vendorUniqId);
    //   } else {}
    // }, onError: (e) {
    //   print(e);
    // });
  }

  Future updateCart(int quantity) async {
    // await CartController.update(jsonMap: {
    //   "cart_id": widget.cartData.cartId,
    //   "product_quantity": quantity
    // }).then((value) {
    //   if (value.success) {
    //     setState(() {
    //       q=quantity;
    //     });
    //     Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
    //         vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
    //             .vendorModel!
    //             .vendorUniqId);
    //
    //   } else {}
    // }, onError: (e) {
    //   print(e);
    // });

    var provider = Provider.of<CartDataWrapper>(context, listen: false);

    provider.incrementQuantity(
        quantity: quantity, productId: widget.productId);
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
    return SizedBox(
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
                    if (Provider.of<CartDataWrapper>(context,listen: false)
                        .getIndividualQuantity(
                        productId: widget.productId) > 1) {
                      updateCart(Provider.of<CartDataWrapper>(context,listen: false)
                          .getIndividualQuantity(
                          productId: widget.productId) - 1);
                    } else if (Provider.of<CartDataWrapper>(context,listen: false)
                        .getIndividualQuantity(
                        productId: widget.productId) == 1) {
                      deleteCart();
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    size: 15,
                    color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                  ),
                ),
              ),
              Consumer<CartDataWrapper>(builder: (context,CartDataWrapper value, child) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "${value.getIndividualQuantity(productId: widget.productId)}",
                    style: TextStyle(
                        color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: "Poppins"),
                  ),
                );
              },)
              ,
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    updateCart((Provider.of<CartDataWrapper>(context,listen: false)
                        .getIndividualQuantity(
                        productId: widget.productId)) + 1);
                  },
                  child: Icon(
                    Icons.add,
                    size: 15,
                    color: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
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
