import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocode/geocode.dart' as geo;
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Constants/textStyles.dart';
import 'package:multi_vendor_customer/Data/Models/AddressModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:provider/provider.dart';

import 'map/search.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final GlobalKey<FormState> _addressKey = GlobalKey();

  TextEditingController houseNo = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pinCode = TextEditingController();

  _saveAddress(Address address) async {
    if (addressList.contains(address)) {
      Fluttertoast.showToast(
          msg: "Address Already Exist",
          webPosition: "center",
          webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
    } else {
      addressList.add(address);
      print("$address");
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }

  int defaultChoiceIndex = 0;
  List<String> _choicesList = ['Home', 'Work', 'Other'];

  bool isLocationLoaded = false;

  //for showing google map
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _kGooglePlex;

  var googleGeocoding = GoogleGeocoding("AIzaSyBGVURpKj-7hA1Nra-MthetW7qOyjyX8Sc");

  //get users location
  loc.Location location = new loc.Location();

  _getUsersLoaction() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);

    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(_locationData.latitude!, _locationData.longitude!),
        zoom: 18,
      );
      isLocationLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsersLoaction();
  }

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
                  child: isLocationLoaded
                      ? GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          myLocationEnabled: true,
                          onTap: (value) async {
                            //todo location implementation
                            // var risult = await googleGeocoding.geocoding.getReverse(LatLon(value.latitude, value.longitude));
                            // print(risult?.results![0].addressComponents![0].shortName);
                            // if (risult.streetNumber != null) {
                            //   houseNo.text = risult.streetNumber.toString();
                            // }
                            // if (risult.streetAddress != null) {
                            //  area.text  = risult.streetAddress!;
                            // }
                            // if (risult.city != null) {
                            //   city.text = risult.city!;
                            // }
                            // if (risult.postal != null) {
                            //   pinCode.text = risult. postal!;
                            // }
                          },
                        )
                      : Center(
                          child: Text("Map is loading"),
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
                              selectedColor: Provider.of<CustomColor>(context)
                                  .appPrimaryMaterialColor,
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
                          },
                          maxLines: 1,
                          controller: houseNo,
                        ),
                        MyTextFormField(
                          hintText: "area",
                          maxLines: 1,
                          controller: area,
                          validator: (value) {
                            if (value!.isEmpty) return "enter area";
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
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                maxLines: 1,
                                controller: pinCode,
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
                child: LocationSearchBar(),
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
            ),
            child: Text(
              "Save",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              if (_addressKey.currentState!.validate()) {
                _saveAddress(
                  Address(
                    type: _choicesList.elementAt(defaultChoiceIndex),
                    subAddress: houseNo.text,
                    area: area.text,
                    city: city.text,
                    pinCode: int.parse(pinCode.text),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
