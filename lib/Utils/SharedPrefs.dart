import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  Future<bool> logout() async {
    _sharedPrefs!.clear();
    return true;
  }

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  // Getter
  String get mobileNo =>
      _sharedPrefs!.getString(StringConstants.mobile_no) ?? "";

  String get customer_name =>
      _sharedPrefs!.getString(StringConstants.customer_name) ?? "";

  String get customer_email =>
      _sharedPrefs!.getString(StringConstants.customer_email) ?? "";

  String get cutomer_id =>
      _sharedPrefs!.getString(StringConstants.cutomer_id) ?? "";

  String get customer_address_type =>
      _sharedPrefs!.getString(StringConstants.customer_address_type) ?? "";

  String get vendor_uniq_id =>
      _sharedPrefs!.getString(StringConstants.vendor_uniq_id) ?? "";

  String get vendor_email_address =>
      _sharedPrefs!.getString(StringConstants.vendor_email_address) ?? "";

  // Setter

  set mobileNo(String value) {
    _sharedPrefs!.setString(StringConstants.mobile_no, value);
  }

  set customer_name(String value) {
    _sharedPrefs!.setString(StringConstants.customer_name, value);
  }

  set customer_email(String value) {
    _sharedPrefs!.setString(StringConstants.customer_email, value);
  }

  set cutomer_id(String value) {
    _sharedPrefs!.setString(StringConstants.cutomer_id, value);
  }

  set customer_address_type(String value) {
    _sharedPrefs!.setString(StringConstants.customer_address_type, value);
  }

  set customer_address(String value) {
    _sharedPrefs!.setString(StringConstants.customer_address, value);
  }

  set vendor_uniq_id(String value) {
    _sharedPrefs!.setString(StringConstants.vendor_uniq_id, value);
  }

  set vendor_email_address(String value) {
    _sharedPrefs!.setString(StringConstants.vendor_email_address, value);
  }

  /*--------------- Check Is Login or Not --------------------*/
  Future<bool> isLogin() async {
    String customerId = sharedPrefs.cutomer_id;
    if (customerId == "")
      return false;
    else
      return true;
  }
}

final sharedPrefs = SharedPrefs();
