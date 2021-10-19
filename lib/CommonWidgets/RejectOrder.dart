import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Data/Controller/OrderController.dart';

import 'MyTextFormField.dart';

class RejectOrder extends StatefulWidget {
  final String oderIdData;

  RejectOrder({required this.oderIdData,});

  @override
  _RejectOrderState createState() => _RejectOrderState();
}

class _RejectOrderState extends State<RejectOrder> {
  bool isLoading = false;
  TextEditingController txtReason = new TextEditingController();

  _rejectOrder() async {
    setState(() {
      isLoading = true;
    });
    await OrderController.rejectOrder(orderId: widget.oderIdData,reason: txtReason.text).then((value) {
      if (value.success) {
        print(value.data);
        setState(() {
          GoRouter.of(context).push(PageCollection.myOrders);
          Fluttertoast.showToast(msg: "Order Rejected");
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                height: 6,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text("Enter reason for rejection(if any)",
                ),
          ),
          MyTextFormField(
            controller: txtReason,
            contentPadding:
            EdgeInsets.only(left: 15, right: 8, top: 15, bottom: 4),
            hintText: "Enter reason for rejection",
            maxLines: 7,
          ),
          SizedBox(
            height: 50,
          ),
          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
            height: 43,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.red.shade800),
              ),
              child: Text("Reject Order"),
              onPressed: () {
                if(txtReason.text.length>1){
                _rejectOrder();}
                else
                  Fluttertoast.showToast(msg: "Enter reason");
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
