import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Data/Controller/CartController.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

class CartDataWrapper extends ChangeNotifier {
  CartDataModel? cartData;
  int totalItems = 0;

  Future loadCartData() async {
    print("load cart data Calling");
    if (sharedPrefs.customer_id.isEmpty) {
      return;
    }
    await CartController.getCartData("${sharedPrefs.customer_id}").then(
        (value) {
      if (value.success) {
        print(value.success);
        cartData = value.data;
        notifyListeners();
      } else {}
    }, onError: (e) {
      print(e);
    });
  }
}
