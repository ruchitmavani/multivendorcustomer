import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/AuthConntroller.dart';
import 'package:multi_vendor_customer/Views/HomeScreen.dart';
import 'package:multi_vendor_customer/Views/Register.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  String otp;

  OTPScreen({required this.mobileNumber, required this.otp});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp = TextEditingController();
  bool isLoading = false;

  _sendOtp() async {
    print("Calling");
    setState(() {
      isLoading = true;
    });
    await AuthController.sendOtp(widget.mobileNumber).then((value) {
      if (value.success) {
        print(value.success);
        print(value.data);
        setState(() {
          isLoading = false;
          widget.otp = value.data;
        });
        Fluttertoast.showToast(msg: "Resend Success");
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

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
                      text: "OTP sent to  ",
                      style: FontsTheme.descriptionText(
                          size: 15, color: Colors.grey),
                      children: [
                        TextSpan(
                            text: "+91 " + "${widget.mobileNumber}",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: Colors.grey.shade800))
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      icon: Icon(Icons.edit, size: 18))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 0.0, bottom: 20.0),
                child: MyTextFormField(
                  hintText: "Enter OTP code",
                  maxLength: 6,
                  controller: otp,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (widget.otp == otp.text) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Register(widget.mobileNumber);
                      },));
                    } else {
                      Fluttertoast.showToast(msg: "Wrong otp");
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Verify OTP"),
                  )),
              Space(
                height: 15,
              ),
              GestureDetector(
                onTap: () => _sendOtp(),
                child: Text("Resend OTP",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
