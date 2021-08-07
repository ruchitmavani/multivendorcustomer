import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;

  OTPScreen({required this.mobileNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("images/login.svg", width: 300),
                Space(height: 20),
                Text("OTP Verification",
                    style: FontsTheme.boldTextStyle(size: 18)),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Space(width: 45),
                    RichText(
                        text: TextSpan(
                            text: "OTP sent to\t\t",
                            style: FontsTheme.descriptionText(
                                size: 15, color: Colors.grey),
                            children: [
                          TextSpan(
                              text: "+91\t" + "${widget.mobileNumber}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "",
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                  color: Colors.grey.shade800))
                        ])),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 18))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 0.0, bottom: 20.0),
                  child: MyTextFormField(
                    hintText: "Enter OTP code",
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Verify OTP"),
                    )),
                Space(
                  height: 15,
                ),
                Text("Resend OTP",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    )),
              ],
            ),
          ),
        ),
    );
  }
}
