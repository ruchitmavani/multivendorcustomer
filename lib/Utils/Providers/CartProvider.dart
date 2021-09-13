import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_customer/Data/Controller/CartController.dart';
import 'package:multi_vendor_customer/Data/Models/CartDataMoodel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

class CartDataWrapper extends ChangeNotifier {
  List<CartDataModel> cartData=[];
  int totalItems = 0;

  Future loadCartData({required String vendorId}) async {
    if (sharedPrefs.customer_id.isEmpty) {
      return;
    }
    print("vendor $vendorId");
    await CartController.getCartData(customerId: "${sharedPrefs.customer_id}",vendorId: vendorId).then(
        (value) {
      if (value.success) {
        print(value.success);
        print(value.data);
        cartData = value.data!;
        totalItems=cartData.length;
        notifyListeners();
      } else {}
    }, onError: (e) {
      print(e);
    });
  }


}
