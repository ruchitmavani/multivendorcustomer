import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Components/OrderComponent.dart';
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
        print(value.success);
        setState(() {
          orderData = value.data!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
        child: isLoading
            ? Center(
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width,
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
                      index=orderData.length-1-index;
                      return OrderComponent(
                          orderData: orderData.elementAt(index));
                    },
                  ),
      ),
    );
  }
}
