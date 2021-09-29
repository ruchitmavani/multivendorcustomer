import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayScreen extends StatefulWidget {
  RazorPayScreen();

  @override
  RazorPayScreenState createState() => RazorPayScreenState();
}

class RazorPayScreenState extends State<RazorPayScreen> {
  late Razorpay _razorpay;
  bool isLoading = false;
  String orderId = "";
  String paymentId = "";
  String signature = "";

  TextEditingController contact = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController name = TextEditingController();

  _sendPaymentDetails() async {

  }

  _getSharedPref() async {

  }

  @override
  void initState() {
    _getSharedPref();
    // _sendPaymentDetails();
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_CjIP1C7K4yRoqo',
      'amount': 2100000,
      'name': '${name.text}',
      'description': 'Advertisement',
      'prefill': {'contact': '${contact.text}', 'email': '${mail.text}'},
      'external': {
        'wallets': ['paytm']
      }
    };
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName!);
  }

  @override
  void dispose() {
    super.dispose();
    // _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    // changeStatusColor(primaryColor);
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 24, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.only(left: 16, right: 16, bottom: 28),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    SizedBox(height: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "MY JINI",
                            style: TextStyle(fontSize: 22),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Total Payment : ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "21000 \₹",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Name",
                    // textColor: primaryColor,
                    // fontFamily: fontSemibold,
                    // fontSize: textSizeLargeMedium,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: TextFormField(
                    // initialValue: "MyJini Advertisement",
                    controller: name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        // labelText: "Enter Name",
                        hintStyle: TextStyle(fontSize: 13)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Email",
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: mail,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        // labelText: "Enter Name",
                        hintStyle: TextStyle(fontSize: 13)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Contact",
                    // textColor: primaryColor,
                    // fontFamily: fontSemibold,
                    // fontSize: textSizeLargeMedium,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    // initialValue: "8488027477",
                    maxLength: 10,
                    controller: contact,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        // labelText: "Enter Name",
                        hintStyle: TextStyle(fontSize: 13)),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 30),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(114, 34, 169, 1),
                      // color: primaryColor,
                      // border: Border.all(width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Pay Now',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    openCheckout();
                  },
                ),
              ],
            )

            /*MaterialButton(
              color: primaryColor,
              onPressed: () => openCheckout(),
              child: textPrimary('Pay with RazorPay'),
            )*/
            ,
          ),
        ),
      ),
    );
  }
}
