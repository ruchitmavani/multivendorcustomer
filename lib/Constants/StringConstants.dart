

const String rupeesIcon="₹";

class StringConstants{

  /*API & IMAGEURLS */
  static String API_URL="http://192.168.1.7:8080/";
// static String API_URL="http://18.221.208.96:8080/";

  /*API NAMES*/
  //vendor
  static String vendor_all_product="vendor_all_product/";
  static String category_wise__all_product_find="category_wise__all_product_find/";


  //customer
  static String cart_view="cart_view";
  static String customer_view="customer_view";


}

class PageCollection{
  static const String home = '/home';
  static const String login = '/login';
  static const String cart = '$home/cart';
  static const String about_us = '$home/about_us';
  static const String myAccount = '/myAccount';
  static const String categories = '$home/categories';
  static const String myOrders = '/myOrders';
}