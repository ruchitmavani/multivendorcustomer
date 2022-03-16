import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Data/Models/AddressModel.dart';
import 'package:multi_vendor_customer/Views/EditLocation.dart';
import 'package:multi_vendor_customer/Views/Location.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({Key? key}) : super(key: key);

  @override
  _SavedAddressState createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Saved Address"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addressList.length > 0
                ? ListView.builder(
                    itemCount: addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${addressList.elementAt(index).type}",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return EditLocation(
                                            subAddress: addressList
                                                .elementAt(index)
                                                .subAddress,
                                            area: addressList
                                                .elementAt(index)
                                                .area,
                                            city: addressList
                                                .elementAt(index)
                                                .city,
                                            pincode: addressList
                                                .elementAt(index)
                                                .pinCode
                                                .toString(),
                                            index: index);
                                      },
                                    )).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                ),
                                if (addressList.length >= 2)
                                  InkWell(
                                    onTap: () {
                                      addressList.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 18,
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade100),
                              child: Text(
                                "${addressList.elementAt(index).subAddress}, ${addressList.elementAt(index).area}, ${addressList.elementAt(index).city}, ${addressList.elementAt(index).pinCode}",
                                style: TextStyle(
                                    fontSize: 12,color: Color(0xff383838),),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Container(
                    height: MediaQuery.of(context).size.height - 60,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Text("No address Added"))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationScreen(),
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("+ Add Address"),
        ),
      ),
    );
  }
}
