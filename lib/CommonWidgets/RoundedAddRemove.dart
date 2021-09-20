import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Data/Controller/CartController.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:provider/provider.dart';

class RoundedAddRemove extends StatefulWidget {
  CartDataModel cartData;

  RoundedAddRemove({required this.cartData});

  @override
  _RoundedAddRemoveState createState() => _RoundedAddRemoveState();
}

class _RoundedAddRemoveState extends State<RoundedAddRemove> {
  int q = 0;

  @override
  void initState() {
    super.initState();
    q=widget.cartData.productQuantity;
  }

  Future deleteCart() async {
    await CartController.deleteCart(cartId: "${widget.cartData.cartId}").then(
        (value) {
      if (value.success) {
        print(value.success);
        print(value.data);
        setState(() {});
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
    await CartController.update(jsonMap: {
      "cart_id": widget.cartData.cartId,
      "product_quantity": quantity
    }).then((value) {
      if (value.success) {
        setState(() {
          q=quantity;
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
        .getIndividualQuantity(
            productId: widget.cartData.productDetails.first.productId);
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
                    if(q>1){
                      updateCart(q-1);
                    }else if(q==1){
                      deleteCart();
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    size: 15,
                    color: appPrimaryMaterialColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "${q}",
                  style: TextStyle(
                      color: appPrimaryMaterialColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      fontFamily: "Poppins"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    updateCart((q) + 1);
                  },
                  child: Icon(
                    Icons.add,
                    size: 15,
                    color: appPrimaryMaterialColor,
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
