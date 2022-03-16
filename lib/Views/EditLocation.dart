// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/AddressModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

class EditLocation extends StatefulWidget {
  String subAddress;
  String area;
  String city;
  String pincode;
  int index;

  EditLocation({required this.subAddress, required this.area, required this.city, required this.pincode,required this.index});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<EditLocation> {
  final GlobalKey<FormState> _addressKey = GlobalKey();

  TextEditingController subAddress = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();

  _saveAdress(Address address) async {
    addressList[widget.index]=address;
    if(Navigator.canPop(context))
      Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    subAddress.text = widget.subAddress;
    area.text = widget.area;
    city.text = widget.city;
    pincode.text = widget.pincode;
  }

  int defaultChoiceIndex = 0;
  List<String> _choicesList = ['Home', 'Work', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: Image.network(
                    "https://www.smcrealty.com/images/microsites/location-map/mantri-serenity-251.jpg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 17.0, right: 17, top: 30, bottom: 10),
                  child: Form(
                    key: _addressKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Address",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Wrap(
                          spacing: 8,
                          children: List.generate(_choicesList.length, (index) {
                            return ChoiceChip(
                              labelPadding: EdgeInsets.all(2.0),
                              label: Text(
                                _choicesList[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: defaultChoiceIndex == index
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                              ),
                              selected: defaultChoiceIndex == index,
                              selectedColor: Provider.of<CustomColor>(context).appPrimaryMaterialColor,
                              onSelected: (value) {
                                setState(() {
                                  defaultChoiceIndex =
                                      value ? index : defaultChoiceIndex;
                                });
                              },
                              elevation: 1,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            );
                          }),
                        ),
                        MyTextFormField(
                          hintText: "flat no, society name",
                          validator: (value) {
                            if (value!.isEmpty)
                              return "enter flat no. and society name";
                            return null;
                          },
                          maxLines: 1,
                          controller: subAddress,
                        ),
                        MyTextFormField(
                          hintText: "area",
                          maxLines: 1,
                          controller: area,
                          validator: (value) {
                            if (value!.isEmpty) return "enter area";
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: MyTextFormField(
                                hintText: "city",
                                maxLines: 1,
                                validator: (value) {
                                  if (value!.isEmpty) return "enter city";
                                  return null;
                                },
                                controller: city,
                              ),
                            ),
                            Space(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: MyTextFormField(
                                hintText: "pincode",
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                validator: (value) {
                                  if (value!.length < 6)
                                    return "enter valid pincode";
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                maxLines: 1,
                                controller: pincode,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 12, right: 12),
            child: SizedBox(
              height: 95,
              width: MediaQuery.of(context).size.width / 1,
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location",
                          style: FontsTheme.subTitleStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              size: 15)),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                            "Mini street, Flower Bazzar, Sowcarpet - 600001",
                            style: FontsTheme.descriptionText(
                                fontWeight: FontWeight.w500,
                                size: 12,
                                color: Colors.black87)),
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
              "Update Adress",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              if (_addressKey.currentState!.validate()) {
                _saveAdress(
                  Address(
                    type: _choicesList.elementAt(defaultChoiceIndex),
                    subAddress: subAddress.text,
                    area: area.text,
                    city: city.text,
                    pinCode: int.parse(pincode.text),
                  ),
                );
              }
            },
            /* backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurpleAccent.shade200),*/
          ),
        ),
      ),
    );
  }
}
