import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:multi_vendor_customer/Routes/Helper.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

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
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Image.asset("images/success.png",height: 200,),
            SizedBox(
              height: 55,
            ),
            Lottie.asset(
              "images/successorder.json",
              height: 200,
              repeat: false,
            ),
            SizedBox(
              height: 19,
            ),
            Text(
              "Your order has been\nPlaced Successfully",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 36,
            ),
            SizedBox(
              width: 200,
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(6)
                ),
                onPressed: () {
                  GoRouter.of(context)
                      .go('/' + storeConcat(PageCollection.home));
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("Continue Shopping"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 32,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary:
                      Provider.of<CustomColor>(context).appPrimaryMaterialColor,

                  side: BorderSide(color: Provider.of<CustomColor>(context).appPrimaryMaterialColor),
                ),
                onPressed: () {
                  GoRouter.of(context)
                      .go('/' + storeConcat(PageCollection.myOrders));
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Track"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
