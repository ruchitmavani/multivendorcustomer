import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("images/success.png",height: 200,),
            // Lottie.asset("images/success.json", height: 200, repeat: false,),
            Text(
              "Your order has been Placed Successfully",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/'+storeConcat(PageCollection.home));
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Continue Shopping"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
