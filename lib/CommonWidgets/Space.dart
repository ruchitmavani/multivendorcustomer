import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double? width;
  final double? height;

  Space({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width ?? 0, height: height ?? 0);
  }
}
