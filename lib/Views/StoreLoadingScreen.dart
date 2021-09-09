import 'package:flutter/material.dart';

class StoreLoading extends StatelessWidget {
  const StoreLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text("Loading Your Store"),
        ],
      )),
    );
  }
}
