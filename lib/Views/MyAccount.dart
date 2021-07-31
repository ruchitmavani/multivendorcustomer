import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/Constants/app_icons.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Views/Location.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("My Account",style: FontsTheme.boldTextStyle(size: 16),),
        ),
      body: Padding(
        padding: const EdgeInsets.only(left:12.0,right: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              MyTextFormField(
                lable: "Name",
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: MyTextFormField(
                  lable: "Email address",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: MyTextFormField(
                  lable: "Mobile number",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: MyTextFormField(
                  lable: "DOB",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, bottom: 4.0),
                child: Text(
                  "Address",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:3.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  //  width: 110,
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.white,
                      elevation: 0,
                      side: BorderSide(width: 0.5, color: Colors.grey.shade400),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,size: 16,),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            "Add Address",style: TextStyle(
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
        padding: const EdgeInsets.only(left:13.0,right: 13,bottom: 18),
        child: SizedBox(
          height: 45,
          child: ElevatedButton(
            child: Text(
              "Save",
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (contextt)=>Location()));
            },
          ),
        ),
      ),

    );
  }
}
