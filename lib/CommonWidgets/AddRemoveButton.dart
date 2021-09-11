import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/colors.dart';
import 'package:multi_vendor_customer/Utils/Providers/CartProvider.dart';
import 'package:provider/provider.dart';

class AddRemoveButton extends StatefulWidget {
  String productId;

  AddRemoveButton({required this.productId});

  @override
  _AddRemoveButtonState createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  int q = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("___________");
    for (int i = 0;
        i < Provider.of<CartDataWrapper>(context).cartData.length;
        i++) {
      if (Provider.of<CartDataWrapper>(context, listen: false).cartData.elementAt(i).productId==widget.productId)
        q = Provider.of<CartDataWrapper>(context, listen: false)
            .cartData
            .elementAt(i)
            .productQuantity;
    }
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return q == 0
        ? SizedBox(
            width: 35,
            height: 35,
            child: Card(
              shape: CircleBorder(),
              elevation: 0,
              color: appPrimaryMaterialColor[700],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            width: 85,
            height: 35,
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
                        onTap: () {},
                        child: Icon(
                          Icons.remove,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "$q",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            fontFamily: "Poppins"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {},
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
