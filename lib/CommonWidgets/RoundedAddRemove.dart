import 'package:flutter/material.dart';

class RoundedAddRemove extends StatefulWidget {
  const RoundedAddRemove({Key? key}) : super(key: key);

  @override
  _RoundedAddRemoveState createState() => _RoundedAddRemoveState();
}

class _RoundedAddRemoveState extends State<RoundedAddRemove> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      height:32,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: new BorderSide(color: Colors.grey.shade400, width: 0.8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.remove,
                  size: 15,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("2",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 10,fontFamily: "Poppins"),),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.add,
                  size: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
