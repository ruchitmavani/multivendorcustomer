import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/CustomerController.dart';
import 'package:multi_vendor_customer/Data/Models/AddressModel.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/SavedAddress.dart';

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

  _loadCustomerData() async {
    setState(() {
      isLoadingCustomer = true;
    });
    print(sharedPrefs.customer_id);
    await CustomerController.getCustomerData("${sharedPrefs.customer_id}").then(
        (value) {
      if (value.success) {
        print(value.success);
        print(sharedPrefs.customer_id);
        customerData = value.data;
        print(customerData);
        addressList.clear();
        for (int i = 0; i < customerData.customerAddress.length; i++) {
          addressList.add(Address(
              type: customerData.customerAddress.elementAt(i).type,
              subAddress: customerData.customerAddress.elementAt(i).subAddress,
              area: customerData.customerAddress.elementAt(i).area,
              city: customerData.customerAddress.elementAt(i).city,
              pinCode: customerData.customerAddress.elementAt(i).pincode));
        }
        setState(() {
          customerData = value.data;
          name.text = customerData.customerName;
          email.text = customerData.customerEmailAddress;
          mobile.text = customerData.customerMobileNumber;
          dob.text = DateFormat("yyyy-MM-dd").format(customerData.customerDob);
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
    await CustomerController.updateCustomerData(
            customerId: sharedPrefs.customer_id,
            name: name.text,
            email: email.text,
            mobileNumber: mobile.text,
            address: object,
            dob: dob.text)
        .then((value) {
      if (value.success) {
        print(value.success);
        sharedPrefs.customer_email = value.data!.customerEmailAddress;
        sharedPrefs.customer_name = value.data!.customerName;
        sharedPrefs.customer_id = value.data!.customerUniqId;
        sharedPrefs.mobileNo = value.data!.customerMobileNumber;
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, PageCollection.home);
        Fluttertoast.showToast(msg: "Account Update Success");
      } else {
        Fluttertoast.showToast(msg: value.message);
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCustomerData();
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              MyTextFormField(
                lable: "Name",
                controller: name,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: MyTextFormField(
                  lable: "Email address",
                  controller: email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: MyTextFormField(
                  lable: "Mobile number",
                  controller: mobile,
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: addressList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${addressList.elementAt(index).type}",
                        style: TextStyle(
                            fontFamily: 'popins',
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade100),
                        child: Text(
                          "${addressList.elementAt(index).subAddress}, ${addressList.elementAt(index).area}, ${addressList.elementAt(index).city}, ${addressList.elementAt(index).pinCode}",
                          style: TextStyle(
                            fontFamily: 'popins',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, bottom: 12),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(width: 0.5, color: Colors.grey.shade400),
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
