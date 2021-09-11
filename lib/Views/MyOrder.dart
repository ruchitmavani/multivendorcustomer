import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';
import 'package:multi_vendor_customer/Data/Models/OrderDataModel.dart';
import 'package:multi_vendor_customer/Views/Components/OrderComponent.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  bool isLoading = false;
  List<OrderDataModel> orderData = [];

  _loadData() async {
    print("Calling");
    setState(() {
      isLoading = true;
    });
    await OrderController.getOrder("68202120831_7698178410").then((value) {
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
        padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
        child: ListView.builder(
          itemCount: orderData.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderComponent(orderData: orderData.elementAt(index));
          },
        ),
      ),
    );
  }
}
