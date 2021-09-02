import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/AuthConntroller.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Location.dart';

class Register extends StatefulWidget {
  final String mobile;

  Register(this.mobile);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
  TextEditingController address = TextEditingController();

  final GlobalKey<FormState> _registerKey = GlobalKey();

  DateTime selectedDate = DateTime.now();

  _uploadCustomerData() async {
    print("Calling");
    setState(() {
      isLoading = true;
    });
    await AuthController.register(
            name: name.text,
            email: email.text,
            mobileNumber: mobile.text,
            address: "123, Surat",
            dob: dob.text)
        .then((value) {
      if (value.success) {
        print(value.success);
        sharedPrefs.customer_email=customerData.customerEmailAddress;
        setState(() {
          customerData = value.data;
          name.text = customerData.customerName;
          email.text = customerData.customerEmailAddress;
          mobile.text = customerData.customerMobileNumber;
          dob.text = DateFormat.yMd().format(customerData.customerDob);
          isLoading = true;
        });
        Navigator.pushNamed(context, PageCollection.home);
      } else {
        Fluttertoast.showToast(msg: value.message);
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      print(e);
      setState(() {
        isLoading = true;
      });
    });
  }

  _login() async {
    print("Calling");
    setState(() {
      isLoadingCustomer = true;
    });
    await AuthController.login("${widget.mobile}").then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          isLoadingCustomer = false;
        });
        sharedPrefs.customer_email=value.data!.customerEmailAddress;
        sharedPrefs.customer_name=value.data!.customerName;
        sharedPrefs.cutomer_id=value.data!.customerUniqId;
        sharedPrefs.mobileNo=value.data!.customerMobileNumber;
        Navigator.pushNamed(context, PageCollection.home);
      } else {
        setState(() {
          isLoadingCustomer = false;
        });
        Fluttertoast.showToast(msg: value.message);
      }
    }, onError: (e) {
      setState(() {
        isLoadingCustomer = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    mobile.text = widget.mobile;
    _login();
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
      appBar: isLoadingCustomer
          ? AppBar()
          : AppBar(
              title: Text(
                "My Account",
                style: FontsTheme.boldTextStyle(size: 16),
              ),
            ),
      body: isLoadingCustomer
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: _registerKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      MyTextFormField(
                        lable: "Name",
                        controller: name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Name";
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: MyTextFormField(
                          lable: "Email address",
                          controller: email,
                          validator: (value) {
                            return RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(value!)
                                ? null
                                : "please input email";
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: MyTextFormField(
                          lable: "Mobile number",
                          controller: mobile,
                          isenable: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Select Birthdate";
                                  }
                                },
                                onChanged: (String? val) {
                                  print(val);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 4.0),
                        child: Text(
                          "Address",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
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
                                      builder: (context) => Location()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "Add Address",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
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
                    "Save",
                  ),
                  onPressed: () {
                    if (_registerKey.currentState!.validate()) {
                      _uploadCustomerData();
                    }
                  },
                ),
        ),
      ),
    );
  }
}
