import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Data/Controller/CategoryWiseProductController.dart';
import 'package:multi_vendor_customer/Data/Controller/CouponController.dart';
import 'package:multi_vendor_customer/Data/Models/CategoryNameModel.dart';
import 'package:multi_vendor_customer/Data/Models/NewCartModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

class CategoryName extends ChangeNotifier {
  List<CategoryNameModel> categoryName = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) => _isLoading = isLoading;

  Future loadCategoryName() async {
    _isLoading = true;

    await CategoryController
    .getCategoryName()
        .then((value) {
    if (value.success) {
    print(value.data);

    categoryName = value.data;
    _isLoading = false;

    } else {

    _isLoading = false;

    }
    }, onError: (e) {

    _isLoading = false;

    });
    notifyListeners
    (
    );

  }
}
