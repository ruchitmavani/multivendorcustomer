// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Controller/AuthConntroller.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:multi_vendor_customer/Views/Register.dart';
import 'package:provider/provider.dart';

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
  bool isLoadingCustomer = false;
  FocusNode otpFocus=FocusNode();

  _login() async {
    setState(() {
      isLoadingCustomer = true;
    });
    print("${widget.mobileNumber}");
    await AuthController.login("${widget.mobileNumber}").then((value) {
      print(value);
      if (value.success) {
        print(value.success);
        setState(() {
          isLoadingCustomer = false;
        });
        sharedPrefs.customer_email = value.data!.customerEmailAddress;
        sharedPrefs.customer_name = value.data!.customerName;
        sharedPrefs.customer_id = value.data!.customerUniqId;
        sharedPrefs.customer_mobileNo = value.data!.customerMobileNumber;
        Provider.of<CartDataWrapper>(context, listen: false).cartData.length > 0
            ? GoRouter.of(context).go('/' + storeConcat(PageCollection.cart))
            : GoRouter.of(context).go('/' + sharedPrefs.storeLink);
      } else {
        setState(() {
          isLoadingCustomer = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Register(widget.mobileNumber);
          },
        ));
        Fluttertoast.showToast(msg: value.message,webPosition:"center" ,webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
      }
    }, onError: (e) {
      setState(() {
        isLoadingCustomer = false;
      });
    });
  }

  _sendOtp() async {
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
        Fluttertoast.showToast(msg: "Resend Success",webPosition:"center" ,webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
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
                  focusNode: otpFocus,
                  autofocus: true,
                  controller: otp,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              isLoadingCustomer
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (widget.otp == otp.text) {
                          _login();
                        } else {
                          Fluttertoast.showToast(msg: "Wrong otp",webPosition:"center" ,webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
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
