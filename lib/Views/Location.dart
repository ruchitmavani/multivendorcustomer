import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(

            children: [
              Container(
                color: Colors.grey.shade300,
                height: MediaQuery.of(context).size.height / 1.6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17.0, right: 17,top: 30),
                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Enter Address",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    MyTextFormField(
                      // hintText: "Enter address",
                      maxLines: 5,
                    )
                  ],
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 12, right: 12),
            child: SizedBox(
              height: 95,
              width: MediaQuery.of(context).size.width / 1,
              child: Card(
                color: Colors.white,
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: FontsTheme.boldTextStyle(size: 14)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                          "Mini street, Flower Bazzar, Sowcarpet - 600001",
                          style:FontsTheme.descriptionText(size: 12,color: Colors.black87)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding:
        const EdgeInsets.only(left: 17.0, right: 17, bottom: 12, top: 5),
        child: SizedBox(
          height: 45,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              //primary: Colors.deepPurpleAccent.shade100,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              /* side: BorderSide(
                    width: 0.8, color: Colors.deepPurpleAccent.shade200),*/
            ),
            child: Text(
              "Save",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {},
            /* backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurpleAccent.shade200),*/
          ),
        ),
      ),
    );
  }
}
