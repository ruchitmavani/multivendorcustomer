import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Utils/Providers/QuantityClass.dart';
import 'package:provider/provider.dart';

class AddRemoveButton extends StatefulWidget {
  @override
  _AddRemoveButtonState createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<Quantity>(context);
    return SizedBox(
      width: 85,
      height:35,
      child: Card(
        elevation: 0,
        color: appPrimaryMaterialColor[700],
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: (){
                    provider.decrement();
                  },
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("${provider.quantity}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 11,fontFamily: "Poppins"),),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: (){
                    provider.increment();
                  },
                  child: Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
