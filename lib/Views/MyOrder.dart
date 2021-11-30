import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Data/Models/VendorModel.dart';
import 'package:multi_vendor_customer/Utils/HelperFunctions.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/Providers/VendorClass.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/OrderComponent.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  bool isLoading = false;
  List<OrderDataModel> orderData = [];

  _loadData() async {
    setState(() {
      isLoading = true;
    });
    await OrderController.getOrder("${sharedPrefs.customer_id}").then((value) {
      if (value.success) {
        setState(() {
          orderData = value.data!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  int todayIndex = DateTime.now().weekday - 1;


  String getShopTimingStatus(VendorDataModel vendorProvider) {
    List<BusinessHour> list = vendorProvider.businessHours;
    if (list[todayIndex].isOpen == false) {
      return "Closed";
    } else {
      TimeOfDay startTime = TimeOfDay.fromDateTime(
          DateFormat.jm().parse(list[todayIndex].openTime));
      TimeOfDay endTime = TimeOfDay.fromDateTime(
          DateFormat.jm().parse(list[todayIndex].closeTime));
      TimeOfDay currentTime = TimeOfDay.now();
      if (currentTime.hour > startTime.hour &&
          currentTime.hour < endTime.hour) {
        return "${list[todayIndex].openTime} - ${list[todayIndex].closeTime}";
      } else if ((currentTime.hour == startTime.hour &&
          currentTime.minute > startTime.minute) ||
          (currentTime.hour == endTime.hour &&
              currentTime.minute < endTime.minute)) {
        return "${list[todayIndex].openTime} - ${list[todayIndex].closeTime}";
      } else {
        return "Closed";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
        //todo: shop close
        // actions: [
        //   IconButton(
        //     icon: Icon(CupertinoIcons.search,
        //         size: 20,
        //         color:
        //             Provider.of<CustomColor>(context).appPrimaryMaterialColor),
        //     onPressed: () {
        //       GoRouter.of(context).push(PageCollection.search);
        //     },
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: cartIconWidget(context),
        //   ),
        // ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
        child: isLoading
            ? Center(
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width,
                      mainAxisExtent: 150,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12),
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey[300]!,
                      period: Duration(seconds: 2),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 100,
                        decoration: ShapeDecoration(
                          color: Colors.grey[300]!,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    );
                  },
                ),
              )
            : orderData.length == 0
                ? Center(
                    child: Text("No orders Available"),
                  )
                : ListView.builder(
                    itemCount: orderData.length,
                    itemBuilder: (BuildContext context, int index) {
                      index = orderData.length - 1 - index;
                      return OrderComponent(
                          orderData: orderData.elementAt(index));
                    },
                  ),
      ),
    );
  }
}
