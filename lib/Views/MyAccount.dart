import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/CustomerController.dart';
import 'package:multi_vendor_customer/Data/Models/CustomerDataModel.dart';
import 'package:multi_vendor_customer/Views/Location.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  bool isLoadingCustomer=false;
  CustomerDataModel customerData=CustomerDataModel(customerName: "", customerEmailAddress: "", customerMobileNumber: "", customerAddress: "not available", id: "", customerUniqId: "", createdDateTime:DateTime.now());
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController mobile=TextEditingController();
  TextEditingController dob=TextEditingController();
  DateTime selectedDate=DateTime.now();

  _loadCustomerData() async {
    print("Calling");
    setState(() {
      isLoadingCustomer = true;
    });
    await CustomerController.getCustomerData("134202143400_9898178410").then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          customerData=value.data;
          name.text=customerData.customerName;
          email.text= customerData.customerEmailAddress;
          mobile.text=customerData.customerMobileNumber;
          // selectedDate=customerData.createdDateTime;
          isLoadingCustomer = false;
        });
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
        dob.text = DateFormat.yMd().format(selectedDate);
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
                      onTap: (){
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
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(width: 0.5, color: Colors.grey.shade400),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Location()));
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 13.0, right: 13, bottom: 18),
        child: SizedBox(
          height: 45,
          child: ElevatedButton(
            child: Text(
              "Save",
            ),
            onPressed: () {

            },
          ),
        ),
      ),
    );
  }
}
