import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Data/Controller/CouponController.dart';
import 'package:multi_vendor_customer/Data/Models/NewCartModel.dart';
import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

class CartDataWrapper extends ChangeNotifier {
  List<NewCartModel> cartData = [];
  List<TaxDetail> taxData = [];
  bool _isLoading = true;
  bool isCouponApplied = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) => _isLoading = isLoading;
  int totalItems = 0;
  late double totalAmount;
  late double tax;
  late double taxPercentage;
  late double discount = 0;
  late int shipping;
  late double initialSaving = 0;

  Future loadCartData() async {
    totalItems = cartData.length;
    totalAmount = 0;
    initialSaving = 0;

    for (int i = 0; i < cartData.length; i++) {
      totalAmount = totalAmount +
          (cartData.elementAt(i).productQuantity *
              (cartData.elementAt(i).isBulk
                  ? cartData.elementAt(i).productSellingPrice
                  : cartData.elementAt(i).productSize == null
                      ? cartData.elementAt(i).productSellingPrice
                      : cartData.elementAt(i).productSize!.sellingPrice));

      int q = cartData.elementAt(i).productQuantity;

      initialSaving = initialSaving +
          q *
              (cartData.elementAt(i).productMrp -
                  cartData.elementAt(i).productSellingPrice);
    }
    tax = 0;
    taxPercentage = 0;
    for (int i = 0; i < sharedPrefs.tax.length; i++) {
      tax = tax +
          (totalAmount * double.parse(sharedPrefs.tax.elementAt(i)) / 100);
      taxPercentage =
          taxPercentage + double.parse(sharedPrefs.tax.elementAt(i));
    }
    isLoading = false;
    isCouponApplied = false;
    notifyListeners();
  }

  verifyCoupon(String coupon) async {
    await CouponController.validateCoupon(
            vendorId: "${sharedPrefs.vendor_uniq_id}",
            customerId: "${sharedPrefs.customer_id}",
            couponName: "$coupon")
        .then((value) {
      if (value.success) {
        if (value.data!.couponType.toLowerCase() == "flat") {
          if (totalAmount >= value.data!.minAmount) {
            totalAmount = totalAmount - value.data!.flatAmount;
            discount = value.data!.flatAmount as double;
            isCouponApplied = true;
            Fluttertoast.showToast(
                msg: "${value.message}",
                webPosition: "center",
                webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
          } else {
            discount = 0;
            Fluttertoast.showToast(
                msg: "your coupon do not meet minimum requirements",
                webPosition: "center",
                webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
          }
        }
        if (value.data!.couponType.toLowerCase() == "percentage") {
          if (totalAmount >= value.data!.minAmount) {
            double temp = (totalAmount * value.data!.offerPercentage / 100);
            if (temp <= value.data!.offerUptoAmount) {
              totalAmount = totalAmount - temp;
              discount = temp;
            } else {
              totalAmount = totalAmount - value.data!.offerUptoAmount;
              discount = value.data!.offerUptoAmount.toDouble();
            }
            isCouponApplied = true;
            Fluttertoast.showToast(
                msg: "${value.message}",
                webPosition: "center",
                webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
          } else {
            discount = 0;
            Fluttertoast.showToast(
                msg: "your coupon do not meet minimum requirements",
                webPosition: "center",
                webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
          }
        }
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: "${value.message}",
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
      }
    }, onError: (e) {
      Fluttertoast.showToast(
          msg: "Apply Coupon failed, Please try after Sometime!",
          webPosition: "center",
          webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
    });
  }

  int getIndividualQuantity(
      {required String productId,
      ProductSize? productSize,
      ProductColor? productColor}) {
    if (cartData.indexWhere((element) {
          return element.productId == productId &&
              element.productColor == productColor &&
              element.productSize == productSize;
        }) !=
        -1) {
      return cartData.elementAt(cartData.indexWhere((element) {
        return element.productId == productId &&
            element.productColor == productColor &&
            element.productSize == productSize;
      })).productQuantity;
    }
    return 0;
  }

  int getQuantity(String productId) {
    int _count = 0;
    for (int i = 0; i < cartData.length; i++) {
      if (cartData.elementAt(i).productId == productId) {
        _count++;
      }
    }
    return _count;
  }

  incrementQuantity(
      {required int quantity,
      required String productId,
      required ProductSize? productSize,
      required ProductColor? productColor}) {
    int index = cartData.indexWhere((element) {
      return element.productId == productId &&
          element.productColor == productColor &&
          element.productSize == productSize;
    });
    cartData.elementAt(cartData.indexWhere((element) {
      return element.productId == productId &&
          element.productColor == productColor &&
          element.productSize == productSize;
    })).productQuantity = quantity;

    log("--$initialSaving");
    notifyListeners();
  }

  deleteFromCart(
      {required String productId,
      ProductSize? productSize,
      ProductColor? productColor}) {
    if (cartData.indexWhere((element) {
          return element.productId == productId &&
              element.productColor == productColor &&
              element.productSize == productSize;
        }) !=
        -1)
      cartData.removeAt(cartData.indexWhere((element) {
        return element.productId == productId &&
            element.productColor == productColor &&
            element.productSize == productSize;
      }));
    notifyListeners();
  }
}
