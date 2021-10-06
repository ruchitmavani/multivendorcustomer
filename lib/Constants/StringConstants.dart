const String rupeesIcon="₹";

class StringConstants{

  /*API & IMAGEURLS */
  // static String API_URL="http://192.168.1.13:8080/";
  static String API_URL="http://18.221.208.96:8080/";

  /*API NAMES*/
  //vendor
  static String vendor_all_product="vendor_all_product/";
  // static String category_wise_all_product_find="category_wise_all_product_find/";
  static String vendor_send_sms="vendor_send_sms";
  static String vendor_view="vendor_view";
  static String vendor_all_banner = "vendor_all_banner";
  static String top_selling_product = "top_selling_product";


  //customer
  static String cart_view="cart_view";
  static String customer_view="customer_view";
  static String customer_registration="customer_registration";
  static String customer_login="customer_login";
  static String my_order="my_order";
  static String vendor_coupon_validate="vendor_coupon_validate";
  static String customer_update="customer_update";
  static String product_add_to_cart="product_add_to_cart";
  static String search_product="search_product";
  static String delete_cart="delete_cart";
  static String cart_details_update="cart_details_update";
  static String find_a_product="find_a_product";
  static String recently_bought_product="recently_bought_product";
  static String customer_category_wise_all_product_find="customer_category_wise_all_product_find";
  static String customer_add_rating="customer_add_rating";
  static String view_rating="view_rating";
  static String add_order="add_order";

  /*---------------- SharedPreference Keys ------------------*/

  //customer
  static String customer_mobileno = "mobileNo";
  static String customer_name = "customer_name";
  static String customer_email = "customer_email";
  static String cutomer_id = "cutomer_id";
  static String customer_address_type = "customer_address_type";
  static String customer_address = "customer_address";

  //vendor
  static String vendor_uniq_id = "vendor_uniq_id";
  static String vendor_email_address = "email_address";
  static String vendorUniqId="vendorUniqId";
  static String businessName="businessName";
  static String businessCategory="businessCategory";
  static String vendorMobileNumber="mobileNumber";
  static String emailAddress="emailAddress";
  static String gstNumber="gstNumber";
  static String storeLink="storeLink";
  static String logo="logo";
  static String latitude="latitude";
  static String longitude="longitude";
  static String isWhatsappSupport="isWhatsappSupport";
  static String color_theme="color_theme";


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
  static const String savedAddress = '/savedAddress';
  static const String location = '/location';
  static const String loading = '/loading';
  static const String search = '$home/search';
  static const String product = '/product';
  static const String store = '/veer0411';

}