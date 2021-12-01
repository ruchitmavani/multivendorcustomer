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
  late double discount;
  late int shipping;

  Future loadCartData({required String vendorId}) async {
    totalItems = cartData.length;
    totalAmount = 0;
    for (int i = 0; i < cartData.length; i++) {
      totalAmount = totalAmount +
          (cartData.elementAt(i).productQuantity *
              (cartData.elementAt(i).isBulk
                  ? cartData.elementAt(i).productSellingPrice
                  : cartData.elementAt(i).productSize == null
                      ? cartData.elementAt(i).productSellingPrice
                      : cartData.elementAt(i).productSize!.sellingPrice));
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
            Fluttertoast.showToast(msg: "${value.message}");

          }else{
            discount=0;
            Fluttertoast.showToast(msg: "your coupon do not meet minimum requirements");
          }
        }
        if (value.data!.couponType.toLowerCase() == "percentage") {
          if (totalAmount >= value.data!.minAmount) {
            double temp =
                (totalAmount * value.data!.offerPercentage / 100);
            print("temp ->> $temp");
            if (temp <= value.data!.offerUptoAmount) {
              totalAmount = totalAmount - temp;
              discount = temp;
            } else {
              totalAmount = totalAmount - value.data!.offerUptoAmount;
              discount = value.data!.offerUptoAmount.toDouble();
            }
            isCouponApplied = true;
            Fluttertoast.showToast(msg: "${value.message}");

          }else{
            discount=0;
            Fluttertoast.showToast(msg: "your coupon do not meet minimum requirements");
          }
        }
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "${value.message}");
      }
    }, onError: (e) {
      Fluttertoast.showToast(
          msg: "Apply Coupon failed, Please try after Sometime!");
    });
  }

  getIndividualQuantity({required String productId}) {
    for (int i = 0; i < cartData.length; i++) {
      if (cartData.elementAt(i).productId == productId) {
        return cartData.elementAt(i).productQuantity;
      }
    }
    return 0;
  }

  incrementQuantity({required int quantity, required String productId}) {
    print(cartData.indexWhere((element) => element.productId == productId));
    cartData
        .elementAt(
            cartData.indexWhere((element) => element.productId == productId))
        .productQuantity = quantity;
    notifyListeners();
  }

  deleteFromCart({required String productId}) {
    if (cartData.indexWhere((element) => element.productId == productId) != -1)
      cartData.removeAt(
          cartData.indexWhere((element) => element.productId == productId));
    notifyListeners();
  }
}
