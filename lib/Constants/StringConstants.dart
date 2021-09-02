const String rupeesIcon="₹";

class StringConstants{

  /*API & IMAGEURLS */
  static String API_URL="http://192.168.1.4:8080/";
  // static String API_URL="http://18.221.208.96:8080/";

  /*API NAMES*/
  //vendor
  static String vendor_all_product="vendor_all_product/";
  static String category_wise__all_product_find="category_wise__all_product_find/";
  static String vendor_send_sms="vendor_send_sms";

  //customer
  static String cart_view="cart_view";
  static String customer_view="customer_view";
  static String customer_registration="customer_registration";
  static String customer_login="customer_login";

  /*---------------- SharedPreference Keys ------------------*/
  static String mobile_no = "mobileNo";
  static String customer_name = "customer_name";
  static String customer_email = "customer_email";
  static String cutomer_id = "cutomer_id";
  static String customer_address_type = "customer_address_type";
  static String customer_address = "customer_address";
  static String vendor_uniq_id = "vendor_uniq_id";
  static String vendor_email_address = "email_address";

}

class PageCollection{
  static const String home = '/home';
  static const String login = '/login';
  static const String cart = '$home/cart';
  static const String about_us = '$home/about_us';
  static const String myAccount = '/myAccount';
  static const String categories = '$home/categories';
  static const String myOrders = '/myOrders';
  static const String register = '/register';
}