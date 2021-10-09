import 'dart:html';

import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';

String helper(String screen){
  print("helper pathname:  ${window.location.pathname}/$screen");
  return "${window.location.pathname}/$screen";
}

String storeConcate(String screen){
  print("helper pathname:  ${sharedPrefs.storeLink}/$screen");
  return "${sharedPrefs.storeLink}/$screen";
}