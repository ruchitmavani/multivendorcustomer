import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  logout() async {
    for (String key in _sharedPrefs!.getKeys()) {
      if (key != StringConstants.vendor_uniq_id &&
          key != StringConstants.storeLink) {
        await _sharedPrefs!.remove(key);
      }
    }
  }

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  // Getter
  String get customer_mobileNo =>
      _sharedPrefs!.getString(StringConstants.customer_mobileno) ?? "";

  String get customer_name =>
      _sharedPrefs!.getString(StringConstants.customer_name) ?? "";

  String get customer_email =>
      _sharedPrefs!.getString(StringConstants.customer_email) ?? "";

  String get customer_id =>
      _sharedPrefs!.getString(StringConstants.cutomer_id) ?? "";

  String get customer_address_type =>
      _sharedPrefs!.getString(StringConstants.customer_address_type) ?? "";

  String get vendor_uniq_id =>
      _sharedPrefs!.getString(StringConstants.vendor_uniq_id) ?? "";

  String get vendor_email_address =>
      _sharedPrefs!.getString(StringConstants.vendor_email_address) ?? "";

  String get businessName =>
      _sharedPrefs!.getString(StringConstants.businessName) ?? "";

  String get vendorMobileNumber =>
      _sharedPrefs!.getString(StringConstants.vendorMobileNumber) ?? "";

  String get gstNumber =>
      _sharedPrefs!.getString(StringConstants.gstNumber) ?? "";

  String get storeLink =>
      _sharedPrefs!.getString(StringConstants.storeLink) ?? "";

  String get logo => _sharedPrefs!.getString(StringConstants.logo) ?? "";

  String get businessCategory =>
      _sharedPrefs!.getString(StringConstants.businessCategory) ?? "";

  double get latitude => _sharedPrefs!.getDouble(StringConstants.latitude) ?? 0;

  double get longitude =>
      _sharedPrefs!.getDouble(StringConstants.longitude) ?? 0;

  bool get isWhatsappSupport =>
      _sharedPrefs!.getBool(StringConstants.isWhatsappSupport) ?? false;

  String get colorTheme =>
      _sharedPrefs!.getString(StringConstants.color_theme) ?? "";

  List<String> get tax =>
      _sharedPrefs!.getStringList(StringConstants.tax) ?? [];

  List<String> get taxName =>
      _sharedPrefs!.getStringList(StringConstants.taxName) ?? [];

  // Setter

  set customer_mobileNo(String value) {
    _sharedPrefs!.setString(StringConstants.customer_mobileno, value);
  }

  set customer_name(String value) {
    _sharedPrefs!.setString(StringConstants.customer_name, value);
  }

  set customer_email(String value) {
    _sharedPrefs!.setString(StringConstants.customer_email, value);
  }

  set customer_id(String value) {
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

  set businessName(String value) {
    _sharedPrefs!.setString(StringConstants.businessName, value);
  }

  set vendorMobileNumber(String value) {
    _sharedPrefs!.setString(StringConstants.vendorMobileNumber, value);
  }

  set gstNumber(String value) {
    _sharedPrefs!.setString(StringConstants.gstNumber, value);
  }

  set storeLink(String value) {
    _sharedPrefs!.setString(StringConstants.storeLink, value);
  }

  set logo(String value) {
    _sharedPrefs!.setString(StringConstants.logo, value);
  }

  set businessCategory(String value) {
    _sharedPrefs!.setString(StringConstants.businessCategory, value);
  }

  set latitude(double value) {
    _sharedPrefs!.setDouble(StringConstants.latitude, value);
  }

  set longitude(double value) {
    _sharedPrefs!.setDouble(StringConstants.longitude, value);
  }

  set isWhatsappSupport(bool value) {
    _sharedPrefs!.setBool(StringConstants.isWhatsappSupport, value);
  }

  set colorTheme(String value) {
    _sharedPrefs!.setString(StringConstants.color_theme, value);
  }

  set tax(List<String> value) {
    _sharedPrefs!.setStringList(StringConstants.tax, value);
  }

  set taxName(List<String> value) {
    _sharedPrefs!.setStringList(StringConstants.taxName, value);
  }

  /*--------------- Check Is Login or Not --------------------*/
  Future<bool> isLogin() async {
    String customerId = sharedPrefs.customer_id;
    if (customerId == "")
      return false;
    else
      return true;
  }
}

final sharedPrefs = SharedPrefs();
