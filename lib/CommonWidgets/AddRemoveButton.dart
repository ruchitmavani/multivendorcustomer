// ignore_for_file: must_call_super, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/NewCartModel.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class AddRemoveButton extends StatefulWidget {
  ProductData productData;
  bool isRounded = true;
  int colorIndex = 0;
  int sizeIndex = 0;

  AddRemoveButton({required this.productData,
    required this.isRounded,
    required this.colorIndex,
    required this.sizeIndex});

  @override
  _AddRemoveButtonState createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  int q = 0;

  @override
  void initState() {
    super.initState();
    // updateQuantity();
  }

  getColorValue() {

  }

  getSizeValue() {

  }

  Future addToCart() async {
    Provider
        .of<CartDataWrapper>(context, listen: false)
        .cartData
        .add(
      NewCartModel(
          productId: widget.productData.productId,
          productColor: widget.productData.productVariationColors != null
              && widget.productData.productVariationColors!.length != 0
              ? ProductColor(
            colorCode: widget.productData.productVariationColors!.length != 0
                ? widget.productData.productVariationColors!
                .elementAt(widget.colorIndex)
                .colorCode
                : 0,
            isActive: widget.productData.productVariationColors!.length != 0
                ? widget.productData.productVariationColors!
                .elementAt(widget.colorIndex)
                .isActive
                : false,
          )
              : null
          ,
          productImageUrl: widget.productData.productImageUrl,
          productQuantity: 1,
          productMrp: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .mrp
              : widget.productData.productMrp,
          productName: "${widget.productData.productName}",
          productSellingPrice:
          widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .sellingPrice
              : widget.productData.productSellingPrice,
          productSize: widget.productData.productVariationSizes != null
              && widget.productData.productVariationSizes!.length != 0
              ? ProductSize(
              size: widget.productData.productVariationSizes!.length != 0
                  ? widget.productData.productVariationSizes!
                  .elementAt(widget.sizeIndex)
                  .size
                  : "",
              mrp: widget.productData.productVariationSizes!.length != 0
                  ? widget.productData.productVariationSizes!
                  .elementAt(widget.sizeIndex)
                  .mrp
                  : widget.productData.productMrp,
              sellingPrice: widget.productData.productVariationSizes!.length !=
                  0
                  ? widget.productData.productVariationSizes!
                  .elementAt(widget.sizeIndex)
                  .sellingPrice
                  : widget.productData.productSellingPrice,
              isActive: widget.productData.productVariationSizes!.length != 0
                  ? widget.productData.productVariationSizes!
                  .elementAt(widget.sizeIndex)
                  .isActive
                  : false)
              : null
          ,
          isBulk: false,
          rating: widget.productData.productRatingAverage),
    );
    Provider
        .of<CartDataWrapper>(context, listen: false)
        .cartData
        .forEach((element) {
    });
    Provider.of<CartDataWrapper>(context, listen: false).loadCartData();
    Fluttertoast.showToast(
      msg: "Added to Cart",
      webPosition: "center",
      webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)",
    );
  }

  Future deleteCart() async {
    var provider = Provider.of<CartDataWrapper>(context, listen: false);
    provider.deleteFromCart(
        productId: widget.productData.productId,
        productSize: widget.productData.productVariationSizes != null
            && widget.productData.productVariationSizes!.length != 0
            ? ProductSize(
            size: widget.productData.productVariationSizes!.length != 0
                ? widget.productData.productVariationSizes!
                .elementAt(widget.sizeIndex)
                .size
                : "",
            mrp: widget.productData.productVariationSizes!.length != 0
                ? widget.productData.productVariationSizes!
                .elementAt(widget.sizeIndex)
                .mrp
                : widget.productData.productMrp,
            sellingPrice: widget.productData.productVariationSizes!.length != 0
                ? widget.productData.productVariationSizes!
                .elementAt(widget.sizeIndex)
                .sellingPrice
                : widget.productData.productSellingPrice,
            isActive: widget.productData.productVariationSizes!.length != 0
                ? widget.productData.productVariationSizes!
                .elementAt(widget.sizeIndex)
                .isActive
                : false) : null,
        productColor: widget.productData.productVariationColors != null
            && widget.productData.productVariationColors!.length != 0
            ? ProductColor(
          colorCode: widget.productData.productVariationColors!.length != 0
              ? widget.productData.productVariationColors!
              .elementAt(widget.colorIndex)
              .colorCode
              : 0,
          isActive: widget.productData.productVariationColors!.length != 0
              ? widget.productData.productVariationColors!
              .elementAt(widget.colorIndex)
              .isActive
              : false,
        ) : null);
    Provider.of<CartDataWrapper>(context, listen: false).loadCartData();
  }

  Future updateCart(int quantity) async {
    var provider = Provider.of<CartDataWrapper>(context, listen: false);
    if (widget.productData.isStock) {
      if (quantity <= widget.productData.stockLeft) {
        provider.incrementQuantity(
            quantity: quantity,
            productId: widget.productData.productId,
            productColor: widget.productData.productVariationColors != null
                && widget.productData.productVariationColors!.length != 0
                ? ProductColor(
              colorCode: widget.productData.productVariationColors!.length != 0
                  ? widget.productData.productVariationColors!
                  .elementAt(widget.colorIndex)
                  .colorCode
                  : 0,
              isActive: widget.productData.productVariationColors!.length != 0
                  ? widget.productData.productVariationColors!
                  .elementAt(widget.colorIndex)
                  .isActive
                  : false,
            ) : null,
            productSize: widget.productData.productVariationSizes != null
                && widget.productData.productVariationSizes!.length != 0
                ? ProductSize(
                size: widget.productData.productVariationSizes!.length != 0
                    ? widget.productData.productVariationSizes!
                    .elementAt(widget.sizeIndex)
                    .size
                    : "",
                mrp: widget.productData.productVariationSizes!.length != 0
                    ? widget.productData.productVariationSizes!
                    .elementAt(widget.sizeIndex)
                    .mrp
                    : widget.productData.productMrp,
                sellingPrice: widget.productData.productVariationSizes!
                    .length != 0
                    ? widget.productData.productVariationSizes!
                    .elementAt(widget.sizeIndex)
                    .sellingPrice
                    : widget.productData.productSellingPrice,
                isActive: widget.productData.productVariationSizes!.length != 0
                    ? widget.productData.productVariationSizes!
                    .elementAt(widget.sizeIndex)
                    .isActive
                    : false) : null);
      } else {
        Fluttertoast.showToast(
            msg: "No more left in Stock",
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
      }
    } else {
      provider.incrementQuantity(
          quantity: quantity,
          productId: widget.productData.productId,
          productSize: widget.productData.productVariationSizes != null
              && widget.productData.productVariationSizes!.length != 0
              ? ProductSize(
              size: widget.productData.productVariationSizes!.length != 0
                  ? widget.productData.productVariationSizes!
                  .elementAt(widget.sizeIndex)
                  .size
                  : "",
              mrp: widget.productData.productVariationSizes!.length != 0
                  ? widget.productData.productVariationSizes!
                  .elementAt(widget.sizeIndex)
                  .mrp
                  : widget.productData.productMrp,
              sellingPrice: widget.productData.productVariationSizes!.length !=
                  0
                  ? widget.productData.productVariationSizes!
                  .elementAt(widget.sizeIndex)
                  .sellingPrice
                  : widget.productData.productSellingPrice,
              isActive: widget.productData.productVariationSizes!.length != 0
                  ? widget.productData.productVariationSizes!
                  .elementAt(widget.sizeIndex)
                  .isActive
                  : false) : null,
          productColor: widget.productData.productVariationColors != null
              && widget.productData.productVariationColors!.length != 0
              ? ProductColor(
            colorCode: widget.productData.productVariationColors!.length != 0
                ? widget.productData.productVariationColors!
                .elementAt(widget.colorIndex)
                .colorCode
                : 0,
            isActive: widget.productData.productVariationColors!.length != 0
                ? widget.productData.productVariationColors!
                .elementAt(widget.colorIndex)
                .isActive
                : false,
          ) : null);
    }

    provider.loadCartData();
  }

  @override
  void didUpdateWidget(oldWidget) {
    // updateQuantity();
  }

  updateQuantity() {
    q = Provider.of<CartDataWrapper>(context, listen: false)
        .getIndividualQuantity(
      productId: widget.productData.productId,
      productColor: ProductColor(
        colorCode: widget.productData.productVariationColors!.length != 0
            ? widget.productData.productVariationColors!
            .elementAt(widget.colorIndex)
            .colorCode
            : 0,
        isActive: widget.productData.productVariationColors!.length != 0
            ? widget.productData.productVariationColors!
            .elementAt(widget.colorIndex)
            .isActive
            : false,
      ),
      productSize: ProductSize(
          size: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .size
              : "",
          mrp: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .mrp
              : widget.productData.productMrp,
          sellingPrice: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .sellingPrice
              : widget.productData.productSellingPrice,
          isActive: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .isActive
              : false),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<CartDataWrapper>(context).getIndividualQuantity(
      productId: widget.productData.productId,
      productColor: widget.productData.productVariationColors != null
          && widget.productData.productVariationColors!.length != 0
          ? ProductColor(
        colorCode: widget.productData.productVariationColors!.length != 0
            ? widget.productData.productVariationColors!
            .elementAt(widget.colorIndex)
            .colorCode
            : 0,
        isActive: widget.productData.productVariationColors!.length != 0
            ? widget.productData.productVariationColors!
            .elementAt(widget.colorIndex)
            .isActive
            : false,
      ) : null,
      productSize: widget.productData.productVariationSizes != null
          && widget.productData.productVariationSizes!.length != 0
          ? ProductSize(
          size: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .size
              : "",
          mrp: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .mrp
              : widget.productData.productMrp,
          sellingPrice: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .sellingPrice
              : widget.productData.productSellingPrice,
          isActive: widget.productData.productVariationSizes!.length != 0
              ? widget.productData.productVariationSizes!
              .elementAt(widget.sizeIndex)
              .isActive
              : false) : null,
    ) ==
        0
        ? widget.isRounded
        ? SizedBox(
      width: 37,
      height: 37,
      child: Card(
        shape: CircleBorder(),
        elevation: 0,
        color:
        Provider
            .of<CustomColor>(context)
            .appPrimaryMaterialColor,
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
          height: 37,
          width: 87,
          child: InkWell(
            onTap: () {
              addToCart();
            },
            child: Card(
              color: Provider
                  .of<CustomColor>(context)
                  .appPrimaryMaterialColor,
              child: Center(
                child: Text(
                  "Add to Cart",
                  style: FontsTheme.boldTextStyle(
                      color: Colors.white, size: 9),
                  maxLines: 1,
                ),
              ),
            ),
          ),
        )
        : SizedBox(
      height: 37,
      width: 87,
      child: Card(
        elevation: 0,
        color:
        Provider
            .of<CustomColor>(context)
            .appPrimaryMaterialColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    if (Provider.of<CartDataWrapper>(context,
                        listen: false)
                        .getIndividualQuantity(
                      productId: widget.productData.productId,
                      productColor: widget.productData
                          .productVariationColors != null
                          &&
                          widget.productData.productVariationColors!.length !=
                              0
                          ? ProductColor(
                        colorCode: widget.productData.productVariationColors!
                            .length != 0
                            ? widget.productData.productVariationColors!
                            .elementAt(widget.colorIndex)
                            .colorCode
                            : 0,
                        isActive: widget.productData.productVariationColors!
                            .length != 0
                            ? widget.productData.productVariationColors!
                            .elementAt(widget.colorIndex)
                            .isActive
                            : false,
                      ) : null,
                      productSize: widget.productData.productVariationSizes !=
                          null
                          &&
                          widget.productData.productVariationSizes!.length !=
                              0
                          ? ProductSize(
                          size: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .size
                              : "",
                          mrp: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .mrp
                              : widget.productData.productMrp,
                          sellingPrice: widget.productData
                              .productVariationSizes!.length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .sellingPrice
                              : widget.productData.productSellingPrice,
                          isActive: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .isActive
                              : false) : null,
                    ) >
                        1) {
                      updateCart((Provider.of<CartDataWrapper>(context,
                          listen: false)
                          .getIndividualQuantity(
                        productId: widget.productData.productId,
                        productColor: widget.productData
                            .productVariationColors != null
                            && widget.productData.productVariationColors!
                                .length != 0
                            ? ProductColor(
                          colorCode: widget.productData
                              .productVariationColors!.length != 0
                              ? widget.productData.productVariationColors!
                              .elementAt(widget.colorIndex)
                              .colorCode
                              : 0,
                          isActive: widget.productData.productVariationColors!
                              .length != 0
                              ? widget.productData.productVariationColors!
                              .elementAt(widget.colorIndex)
                              .isActive
                              : false,
                        ) : null,
                        productSize: widget.productData
                            .productVariationSizes != null
                            && widget.productData.productVariationSizes!
                                .length != 0
                            ? ProductSize(
                            size: widget.productData.productVariationSizes!
                                .length != 0
                                ? widget.productData.productVariationSizes!
                                .elementAt(widget.sizeIndex)
                                .size
                                : "",
                            mrp: widget.productData.productVariationSizes!
                                .length != 0
                                ? widget.productData.productVariationSizes!
                                .elementAt(widget.sizeIndex)
                                .mrp
                                : widget.productData.productMrp,
                            sellingPrice: widget.productData
                                .productVariationSizes!.length != 0
                                ? widget.productData.productVariationSizes!
                                .elementAt(widget.sizeIndex)
                                .sellingPrice
                                : widget.productData.productSellingPrice,
                            isActive: widget.productData
                                .productVariationSizes!.length != 0
                                ? widget.productData.productVariationSizes!
                                .elementAt(widget.sizeIndex)
                                .isActive
                                : false) : null,
                      ) -
                          1));
                    } else if (Provider.of<CartDataWrapper>(context,
                        listen: false)
                        .getIndividualQuantity(
                      productId: widget.productData.productId,
                      productColor: widget.productData
                          .productVariationColors != null
                          &&
                          widget.productData.productVariationColors!.length !=
                              0
                          ? ProductColor(
                        colorCode: widget.productData.productVariationColors!
                            .length != 0
                            ? widget.productData.productVariationColors!
                            .elementAt(widget.colorIndex)
                            .colorCode
                            : 0,
                        isActive: widget.productData.productVariationColors!
                            .length != 0
                            ? widget.productData.productVariationColors!
                            .elementAt(widget.colorIndex)
                            .isActive
                            : false,
                      ) : null,
                      productSize: widget.productData.productVariationSizes !=
                          null
                          &&
                          widget.productData.productVariationSizes!.length !=
                              0
                          ? ProductSize(
                          size: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .size
                              : "",
                          mrp: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .mrp
                              : widget.productData.productMrp,
                          sellingPrice: widget.productData
                              .productVariationSizes!.length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .sellingPrice
                              : widget.productData.productSellingPrice,
                          isActive: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .isActive
                              : false) : null,
                    ) ==
                        1) {
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
              Consumer<CartDataWrapper>(
                builder: (context, CartDataWrapper value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "${value.getIndividualQuantity(
                        productId: widget.productData.productId,
                        productColor: widget.productData
                            .productVariationColors != null
                            && widget.productData.productVariationColors!
                                .length != 0
                            ? ProductColor(
                          colorCode: widget.productData
                              .productVariationColors!.length != 0
                              ? widget.productData.productVariationColors!
                              .elementAt(widget.colorIndex)
                              .colorCode
                              : 0,
                          isActive: widget.productData.productVariationColors!
                              .length != 0
                              ? widget.productData.productVariationColors!
                              .elementAt(widget.colorIndex)
                              .isActive
                              : false,
                        ) : null,
                        productSize: widget.productData
                            .productVariationSizes != null
                            && widget.productData.productVariationSizes!
                                .length != 0
                            ? ProductSize(
                            size: widget.productData.productVariationSizes!
                                .length != 0
                                ? widget.productData.productVariationSizes!
                                .elementAt(widget.sizeIndex)
                                .size
                                : "",
                            mrp: widget.productData.productVariationSizes!
                                .length != 0
                                ? widget.productData.productVariationSizes!
                                .elementAt(widget.sizeIndex)
                                .mrp
                                : widget.productData.productMrp,
                            sellingPrice: widget.productData
                                .productVariationSizes!.length != 0
                                ? widget.productData.productVariationSizes!
                                .elementAt(widget.sizeIndex)
                                .sellingPrice
                                : widget.productData.productSellingPrice,
                            isActive: widget.productData
                                .productVariationSizes!.length != 0
                                ? widget.productData.productVariationSizes!
                                .elementAt(widget.sizeIndex)
                                .isActive
                                : false) : null,
                      )}",
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
                child: InkWell(
                  onTap: () {
                    updateCart(Provider.of<CartDataWrapper>(context,
                        listen: false)
                        .getIndividualQuantity(
                      productId: widget.productData.productId,
                      productColor: widget.productData
                          .productVariationColors != null
                          &&
                          widget.productData.productVariationColors!.length !=
                              0
                          ? ProductColor(
                        colorCode: widget.productData.productVariationColors!
                            .length != 0
                            ? widget.productData.productVariationColors!
                            .elementAt(widget.colorIndex)
                            .colorCode
                            : 0,
                        isActive: widget.productData.productVariationColors!
                            .length != 0
                            ? widget.productData.productVariationColors!
                            .elementAt(widget.colorIndex)
                            .isActive
                            : false,
                      ) : null,
                      productSize: widget.productData.productVariationSizes !=
                          null
                          &&
                          widget.productData.productVariationSizes!.length !=
                              0
                          ? ProductSize(
                          size: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .size
                              : "",
                          mrp: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .mrp
                              : widget.productData.productMrp,
                          sellingPrice: widget.productData
                              .productVariationSizes!.length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .sellingPrice
                              : widget.productData.productSellingPrice,
                          isActive: widget.productData.productVariationSizes!
                              .length != 0
                              ? widget.productData.productVariationSizes!
                              .elementAt(widget.sizeIndex)
                              .isActive
                              : false) : null,
                    ) +
                        1);
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
