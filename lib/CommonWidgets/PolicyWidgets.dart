import 'package:flutter/material.dart';

class PolicyParagraph extends StatelessWidget {
  PolicyParagraph({required this.txt});

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$txt",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          textAlign: TextAlign.justify,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class PolicyTitle extends StatelessWidget {
  final String txt;

  PolicyTitle({required this.txt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          txt,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
