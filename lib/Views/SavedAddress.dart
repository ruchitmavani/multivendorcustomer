import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/CustomerController.dart';
import 'package:multi_vendor_customer/Data/Models/AddressModel.dart';
import 'package:multi_vendor_customer/Views/Location.dart';

import '../Utils/SharedPrefs.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({Key? key}) : super(key: key);

  @override
  _SavedAddressState createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  bool isLoading = false;

  _updateCustomerData() async {
    setState(() {
      isLoading = true;
    });
    List<Map<String, dynamic>> object = [];
    for (int i = 0; i < addressList.length; i++) {
      object.add({
        "type": addressList.elementAt(i).type,
        "subAddress": addressList.elementAt(i).subAddress,
        "area": addressList.elementAt(i).area,
        "city": addressList.elementAt(i).city,
        "pincode": addressList.elementAt(i).pinCode,
      });
    }
    await CustomerController.updateCustomerAddress(
      customerId: sharedPrefs.customer_id,
      address: object,
    ).then((value) {
      if (value.success) {
        sharedPrefs.customer_email = value.data!.customerEmailAddress;
        sharedPrefs.customer_name = value.data!.customerName;
        sharedPrefs.customer_id = value.data!.customerUniqId;
        sharedPrefs.customer_mobileNo = value.data!.customerMobileNumber;

        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Address Delete Success",
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
      } else {
        Fluttertoast.showToast(
            msg: value.message,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      log(e.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Saved Address",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addressList.length > 0
                ? ListView.builder(
                    itemCount: addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${addressList.elementAt(index).type}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return LocationScreen(
                                          isEditing: true,
                                          type:
                                              addressList.elementAt(index).type,
                                          subAddress: addressList
                                              .elementAt(index)
                                              .subAddress,
                                          area:
                                              addressList.elementAt(index).area,
                                          city:
                                              addressList.elementAt(index).city,
                                          pincode: addressList
                                              .elementAt(index)
                                              .pinCode
                                              .toString(),
                                          index: index,
                                        );
                                      },
                                    )).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                ),
                                if (addressList.length >= 2)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        addressList.removeAt(index);
                                        _updateCustomerData();
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade100),
                              child: Text(
                                "${addressList.elementAt(index).subAddress}, ${addressList.elementAt(index).area}, ${addressList.elementAt(index).city}, ${addressList.elementAt(index).pinCode}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff383838),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Container(
                    height: MediaQuery.of(context).size.height - 60,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Text("No address Added"))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationScreen(
                isEditing: false,
                index: 0,
                area: "",
                city: "",
                pincode: "",
                subAddress: "",
                type: "",
              ),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("+ Add Address"),
        ),
      ),
    );
  }
}
