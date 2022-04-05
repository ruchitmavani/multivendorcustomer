import 'package:flutter/material.dart';

class WeSellAboutUs extends StatelessWidget {
  const WeSellAboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About us",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        //todo wesell about us update here
        child: Text("Wesell About us"),
      ),
    );
  }
}
