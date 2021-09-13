import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Data/Controller/CartController.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:provider/provider.dart';

class AddRemoveButton extends StatefulWidget {
  ProductData productData;

  AddRemoveButton({required this.productData});

  @override
  _AddRemoveButtonState createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  int q = 0;

  Future addToCart() async {
    if (sharedPrefs.customer_id.isEmpty) {
      Navigator.pushNamed(context, PageCollection.login);
    }
    await CartController.addToCart(
            customerId: "${sharedPrefs.customer_id}",
            vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .vendorUniqId,
            productId: widget.productData.productId,
            quantity: 1,
            mrp: widget.productData.productMrp,
            isActive: widget.productData.productVariationSizes.first.isActive,
            size: widget.productData.productVariationSizes.first.size,
            colorCode:
                widget.productData.productVariationColors.first.colorCode,
            sellingPrice:
                widget.productData.productVariationSizes.first.sellingPrice,
            isColorActive:
                widget.productData.productVariationColors.first.isActive)
        .then((value) {
      if (value.success) {
        print(value.success);
        print(value.data);
        Provider.of<CartDataWrapper>(context, listen: false).loadCartData(
            vendorId: Provider.of<VendorModelWrapper>(context, listen: false)
                .vendorModel!
                .vendorUniqId);
        setState(() {
          q++;
        });
      } else {}
    }, onError: (e) {
      print(e);
    });
  }

  Future deleteCart() async {
    if (sharedPrefs.customer_id.isEmpty) {
      Navigator.pushNamed(context, PageCollection.login);
    }
    await CartController.deleteCart(
            cartId: "${widget.productData.cartDetails!.cartId}")
        .then((value) {
      if (value.success) {
        print(value.success);
        print(value.data);
        setState(() {
          if (q > 0) q--;
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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      q = widget.productData.cartDetails == null
          ? 0
          : widget.productData.cartDetails!.productQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return q == 0
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
                          deleteCart();
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
                        "${q}",
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
                          addToCart();
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
