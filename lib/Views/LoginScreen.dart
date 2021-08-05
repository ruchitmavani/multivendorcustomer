import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Views/OTPScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController mobileNo=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("images/login.svg", width: 300),
          Space(height: 20),
          Text("Enter Mobile Number", style: FontsTheme.boldTextStyle(size: 15)),
          Text("We will send a OTP to this number",
              style: FontsTheme.descriptionText(size: 12,color: Colors.grey)),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
            child: MyTextFormField(
              controller: mobileNo,
              hintText: "Mobile number",
              maxLength: 10,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(mobileNumber: mobileNo.text)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Send OTP"),
              ))
        ],
      ),
    );
  }
}
