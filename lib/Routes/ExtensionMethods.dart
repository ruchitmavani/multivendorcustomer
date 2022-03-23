import 'package:multi_vendor_customer/Routes/RoutingData.dart';

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(
        route: uriData.path, queryParameters: uriData.queryParameters,);
  }
}
