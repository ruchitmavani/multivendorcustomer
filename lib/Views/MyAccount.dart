import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/CustomerController.dart';
import 'package:multi_vendor_customer/Data/Models/AddressModel.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/SavedAddress.dart';
import 'package:shimmer/shimmer.dart';

import 'Components/AddressComponent.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isLoading = false;
  bool isLoadingCustomer = false;
  CustomerDataModel customerData = CustomerDataModel(
      customerName: "",
      customerEmailAddress: "",
      customerMobileNumber: "",
      customerAddress: [],
      id: "",
      customerUniqId: "",
      customerDob: DateTime.now());
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController dob = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode nameF = FocusNode();
  FocusNode emailF = FocusNode();
  FocusNode mobileF = FocusNode();
  FocusNode dobF = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadCustomerData();
  }

  _loadCustomerData() async {
    setState(() {
      isLoadingCustomer = true;
    });
    await CustomerController.getCustomerData("${sharedPrefs.customer_id}").then(
            (value) {
          if (value.success) {
            customerData = value.data;
            addressList.clear();
            for (int i = 0; i < customerData.customerAddress.length; i++) {
              addressList.add(Address(
                  type: customerData.customerAddress
                      .elementAt(i)
                      .type,
                  subAddress: customerData.customerAddress
                      .elementAt(i)
                      .subAddress,
                  area: customerData.customerAddress
                      .elementAt(i)
                      .area,
                  city: customerData.customerAddress
                      .elementAt(i)
                      .city,
                  pinCode: customerData.customerAddress
                      .elementAt(i)
                      .pinCode));
            }
            setState(() {
              customerData = value.data;
              name.text = customerData.customerName;
              email.text = customerData.customerEmailAddress;
              mobile.text = customerData.customerMobileNumber;
              dob.text =
                  DateFormat("yyyy-MM-dd").format(customerData.customerDob);
              isLoadingCustomer = false;
            });
          }
        }, onError: (e) {
      setState(() {
        isLoadingCustomer = false;
      });
    });
  }

  _updateCustomerData() async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    List<Map<String, dynamic>> object = [];
    for (int i = 0; i < addressList.length; i++) {
      object.add({
        "type": addressList
            .elementAt(i)
            .type,
        "subAddress": addressList
            .elementAt(i)
            .subAddress,
        "area": addressList
            .elementAt(i)
            .area,
        "city": addressList
            .elementAt(i)
            .city,
        "pincode": addressList
            .elementAt(i)
            .pinCode,
      });
    }
    await CustomerController.updateCustomerData(
        customerId: sharedPrefs.customer_id,
        name: name.text,
        email: email.text,
        mobileNumber: mobile.text,
        address: object,
        dob: dob.text)
        .then((value) {
      if (value.success) {
        sharedPrefs.customer_email = value.data!.customerEmailAddress;
        sharedPrefs.customer_name = value.data!.customerName;
        sharedPrefs.customer_id = value.data!.customerUniqId;
        sharedPrefs.customer_mobileNo = value.data!.customerMobileNumber;
        setState(() {
          isLoading = false;
        });
        GoRouter.of(context).go('/' + sharedPrefs.storeLink);

        Fluttertoast.showToast(
            msg: "Account Update Success",
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dob.text = DateFormat("yyyy-MM-dd").format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Account",
          style: FontsTheme.boldTextStyle(size: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: isLoadingCustomer
            ? GridView.builder(
          itemCount: 8,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery
                  .of(context)
                  .size
                  .width,
              mainAxisExtent: 60,
              mainAxisSpacing: 16,
              crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey[300]!,
              period: Duration(seconds: 2),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,
                height: 100,
                decoration: ShapeDecoration(
                  color: Colors.grey[300]!,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            );
          },
        )
            : SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFormField(
                  lable: "Name",
                  controller: name,
                  focusNode: nameF,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: MyTextFormField(
                    lable: "Email address",
                    controller: email,
                    focusNode: emailF,
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      if (value == "" || value == null)
                        return "Email is Empty";
                      if (!regex.hasMatch(value.trim()))
                        return 'Enter Valid Email';
                      else
                        return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: MyTextFormField(
                    lable: "Mobile number",
                    controller: mobile,
                    maxLength: 10,
                    isenable: false,
                    keyboardType: TextInputType.number,
                    showLight: true,
                    validator: (value) {
                      if (value!.length != 10)
                        return 'Mobile Number must be of 10 digit';
                      else
                        return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: MyTextFormField(
                          lable: "DOB",
                          controller: dob,
                          isenable: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 4.0, left: 4, right: 4),
                  child: Text(
                    "Address",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      margin: EdgeInsets.only(bottom: 8, top: 4),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade100),
                      child: AddressComponent(addressType: addressList
                          .elementAt(index)
                          .type, address: addressList.elementAt(index)),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0, bottom: 12),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: BorderSide(
                            width: 0.5, color: Colors.grey.shade400),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SavedAddress(),
                          ),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "Manage Address",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 13.0, right: 13, bottom: 18),
        child: SizedBox(
          height: 45,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
            child: Text(
              "Update",
            ),
            onPressed: () {
              _updateCustomerData();
            },
          ),
        ),
      ),
    );
  }
}

