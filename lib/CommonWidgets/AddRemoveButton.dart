import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';

class AddRemoveButton extends StatefulWidget {

  @override
  _AddRemoveButtonState createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height:35,
      child: Card(
        color: appPrimaryMaterialColor[700],
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.remove,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("2",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 11,fontFamily: "Poppins"),),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
