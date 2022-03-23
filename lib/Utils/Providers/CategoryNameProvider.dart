import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_customer/Data/Controller/CategoryWiseProductController.dart';
import 'package:multi_vendor_customer/Data/Models/CategoryNameModel.dart';

class CategoryName extends ChangeNotifier {
  List<CategoryNameModel> categoryName = [];
  bool _isLoading = true;

  Future loadCategoryName() async {
    _isLoading = true;

    await CategoryController.getCategoryName().then((value) {
      if (value.success) {
        categoryName = value.data;
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    }, onError: (e) {
      _isLoading = false;
    });
    notifyListeners();
  }
}
