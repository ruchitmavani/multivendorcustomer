import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Data/Controller/CartController.dart';
import 'package:multi_vendor_customer/Data/Controller/CouponController.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

class CartDataWrapper extends ChangeNotifier {
  List<CartDataModel> cartData = [];
  bool _isLoading = true;
  bool isCouponApplied = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) => _isLoading = isLoading;

  int totalItems = 0;
  late double totalAmount;
  late double tax;
  late double discount;
  late int shipping;

  Future loadCartData({required String vendorId}) async {
    if (sharedPrefs.customer_id.isEmpty) {
      cartData = [];
      return;
    }
    print("vendor $vendorId");
    await CartController.getCartData(
            customerId: "${sharedPrefs.customer_id}", vendorId: vendorId)
        .then((value) {
      if (value.success) {
        print(value.data);
        cartData = value.data!;
        totalItems = cartData.length;
        totalAmount = 0;
        for (int i = 0; i < cartData.length; i++) {
          totalAmount = totalAmount +
              (cartData.elementAt(i).productQuantity *
                  (cartData.elementAt(i).productSize == null
                      ? cartData
                          .elementAt(i)
                          .productDetails
                          .first
                          .productSellingPrice
                      : cartData.elementAt(i).productSize!.sellingPrice));
        }
        tax = 0;
        for (int i = 0; i < cartData.length; i++) {
          print(i);
          for (int j = 0;
              j < cartData.elementAt(i).productDetails.first.taxId.length;
              j++) {
            tax = tax +
                (cartData
                        .elementAt(i)
                        .productDetails
                        .first
                        .taxDetails
                        .elementAt(j)
                        .taxPercentage *
                    cartData.elementAt(i).productQuantity *
                    (cartData.elementAt(i).productSize == null
                        ? cartData
                        .elementAt(i)
                        .productDetails
                        .first
                        .productSellingPrice
                        : cartData.elementAt(i).productSize!.sellingPrice) /
                    100);
          }
        }
        totalAmount = totalAmount + tax;
        isLoading = false;
        isCouponApplied = false;
        notifyListeners();
      } else {
        notifyListeners();
      }
    }, onError: (e) {
      print(e);
    });
  }

  Future addToCart()async{

  }

  verifyCoupon(String coupon) async {
    await CouponController.validateCoupon(
            vendorId: "${sharedPrefs.vendor_uniq_id}",
            customerId: "${sharedPrefs.customer_id}",
            couponName: "$coupon")
        .then((value) {
      if (value.success) {
        print(value.success);
        Fluttertoast.showToast(msg: "${value.message}");
        if (value.data!.couponType == "flat") {
          if (totalAmount >= value.data!.minAmount) {
            totalAmount = totalAmount - value.data!.flatAmount;
            discount = value.data!.flatAmount as double;
          }
        }
        if (value.data!.couponType == "percentage") {
          if (totalAmount >= value.data!.minAmount) {
            double temp =
                totalAmount - (totalAmount * value.data!.offerPercentage / 100);
            if (temp <= value.data!.offerUptoAmount) {
              totalAmount = totalAmount - temp;
              discount = totalAmount * value.data!.offerPercentage / 100;
            } else {
              totalAmount = totalAmount - value.data!.offerUptoAmount;
              discount = value.data!.offerUptoAmount.toDouble();
            }
          }
        }
        isCouponApplied = true;
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
}
