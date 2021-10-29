import 'dart:html';

import 'package:multi_vendor_customer/Data/Models/ProductModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

String helper(String screen){
  print("helper pathname:  ${window.location.pathname}/$screen");
  return "${window.location.pathname}/$screen";
}

String storeConcate(String screen){
  print("helper pathname:  ${sharedPrefs.storeLink}/$screen");
  return "${sharedPrefs.storeLink.isEmpty?window.localStorage["storeId"]!:sharedPrefs.storeLink}/$screen";
}

String getPrice(int qty,List<BulkPriceList> items){
  int? price;
  items.forEach((element) { if(element.fromQty<=qty && element.toQty>=qty){price=element.pricePerUnit;}});
  return "$price";
}