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
import 'package:multi_vendor_customer/Views/OTPScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNo = new TextEditingController();
  bool isLoading = false;
  bool isLoadingCustomer = false;

  _sendOtp() async {
    setState(() {
      isLoading = true;
    });
    await AuthController.sendOtp(mobileNo.text).then((value) {
      if (value.success) {
        print(value.success);
        setState(() {
          isLoading = false;
        });
        print(value.data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              mobileNumber: mobileNo.text,
              otp: value.data,
            ),
          ),
        );
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("images/login.svg", width: 300),
              Space(height: 20),
              Text("Enter Mobile Number",
                  style: FontsTheme.boldTextStyle(size: 15)),
              Text("We will send a OTP to this number",
                  style:
                      FontsTheme.descriptionText(size: 12, color: Colors.grey)),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                child: MyTextFormField(
                  controller: mobileNo,
                  hintText: "Mobile number",
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (mobileNo.text.length == 10) {
                          _sendOtp();
                        } else {
                          Fluttertoast.showToast(msg: "enter valid number");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Send OTP"),
                      ),
                    ),
              Space(
                height: 15,
              ),
              GestureDetector(
                onTap: (){
                  GoRouter.of(context).go('/'+storeConcat(PageCollection.home));
                },
                child: Text("skip",
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
