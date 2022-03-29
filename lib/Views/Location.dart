import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:multi_vendor_customer/CommonWidgets/MyTextFormField.dart';
import 'package:multi_vendor_customer/CommonWidgets/Space.dart';
import 'package:multi_vendor_customer/Data/Controller/CustomerController.dart';
import 'package:multi_vendor_customer/Data/Models/AddressModel.dart';
import 'package:multi_vendor_customer/Utils/Providers/ColorProvider.dart';
import 'package:multi_vendor_customer/Utils/SharedPrefs.dart';
import 'package:provider/provider.dart';

import 'map/search.dart';

class LocationScreen extends StatefulWidget {
  final String subAddress;
  final String area;
  final String city;
  final String pincode;
  final String type;
  final int index;
  final bool isEditing;

  const LocationScreen(
      {required this.index,
      required this.city,
      required this.area,
      required this.pincode,
      required this.isEditing,
      required this.subAddress,
      required this.type,
      Key? key})
      : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final GlobalKey<FormState> _addressKey = GlobalKey();

  TextEditingController houseNo = TextEditingController();
  TextEditingController areaTxt = TextEditingController();
  TextEditingController cityTxt = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController addressType = TextEditingController();

  bool _serviceEnabled = false;
  bool isLoading = false;
  late PermissionStatus _permissionGranted;
  LocationData _locationData = loc.LocationData.fromMap({});

  _saveAddress(Address address) {
    print(address.toJson());
    if (addressList.contains(address)) {
      Fluttertoast.showToast(
          msg: "Address Already Exist",
          webPosition: "center",
          webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
    } else {
      addressList.add(address);
      _updateCustomerData();
    }
  }

  _updateAddress(Address address) {
    addressList[widget.index] = address;
    _updateCustomerData();
  }

  _updateCustomerData() async {
    setState(() {
      isLoading = true;
    });
    List<Map<String, dynamic>> object = [];
    for (int i = 0; i < addressList.length; i++) {
      object.add({
        "type": addressList.elementAt(i).type,
        "subAddress": addressList.elementAt(i).subAddress,
        "area": addressList.elementAt(i).area,
        "city": addressList.elementAt(i).city,
        "pincode": addressList.elementAt(i).pinCode,
      });
    }
    await CustomerController.updateCustomerAddress(
      customerId: sharedPrefs.customer_id,
      address: object,
    ).then((value) {
      if (value.success) {
        sharedPrefs.customer_email = value.data!.customerEmailAddress;
        sharedPrefs.customer_name = value.data!.customerName;
        sharedPrefs.customer_id = value.data!.customerUniqId;
        sharedPrefs.customer_mobileNo = value.data!.customerMobileNumber;

        setState(() {
          isLoading = false;
        });
        log(GoRouter.of(context).location);
        if (GoRouter.of(context).location.contains("/cart")) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }else {
          GoRouter.of(context).go('/' + sharedPrefs.storeLink+"/account");
        }
        Fluttertoast.showToast(
            msg: "Address Update Success",
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
      } else {
        Fluttertoast.showToast(
            msg: value.message,
            webPosition: "center",
            webBgColor: "linear-gradient(to right, #5A5A5A, #5A5A5A)");
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      log(e.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  int defaultChoiceIndex = 0;
  List<String> _choicesList = ['Home', 'Work', 'Other'];

  bool isLocationLoaded = false;

  //for showing google map
  GoogleMapController? _controller;

  late CameraPosition _kGooglePlex;

  var googleGeocoding =
      GoogleGeocoding("AIzaSyBGVURpKj-7hA1Nra-MthetW7qOyjyX8Sc");

  //get users location
  loc.Location location = new loc.Location();

  setData({
    // required String flat,
    required String area,
    required String city,
    // required String pincode,
  }) {
    houseNo.text = area;
    List<String> temp = city.split(",");
    areaTxt.text = List.generate(
      temp.length - 3,
      (index) => "${temp[index]} ",
    ).toString().replaceAll("[", "").replaceAll("]", "");
    cityTxt.text =
        "${temp[temp.length - 3]}, ${temp[temp.length - 2]}, ${temp[temp.length - 1]}, ";
    // pinCode.text=pincode;
  }

  Marker temp = Marker(markerId: MarkerId("abcd"));

  setLocation(double lat, double long, String placeID) {
    if (_controller != null &&
        _locationData.longitude != null &&
        _locationData.latitude != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(lat, long),
        ),
      );
      _controller!.animateCamera(
        CameraUpdate.zoomTo(19),
      );
      temp = Marker(markerId: MarkerId(placeID), position: LatLng(lat, long));

      setState(() {});
      // _controller!.showMarkerInfoWindow(temp.markerId);

    }
  }

  setLiveLocation() {
    if (_controller != null &&
        _locationData.longitude != null &&
        _locationData.latitude != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_locationData.latitude!, _locationData.longitude!),
        ),
      );
      _controller!.animateCamera(
        CameraUpdate.zoomTo(19),
      );
    }
  }

  _getUsersLoaction() async {
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

    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(_locationData.latitude!, _locationData.longitude!),
        zoom: 18,
      );
      isLocationLoaded = true;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          child: LocationSearchBar(
              lat: _locationData.latitude,
              long: _locationData.longitude,
              setData: setData,
              setLocation: setLocation),
        );
      },
    );
  }

  _setData() {
    houseNo.text = widget.subAddress;
    areaTxt.text = widget.area;
    cityTxt.text = widget.city;
    pinCode.text = widget.pincode;
    int temp = 0;
    if (widget.type == "Home") {
      temp = 0;
    } else if (widget.type == "Work") {
      temp = 1;
    } else {
      temp = 2;
      addressType.text = widget.type;
    }
    setState(() {
      defaultChoiceIndex = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _setData();
    }
    _getUsersLoaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _addressKey,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.grey.shade300,
                        height: MediaQuery.of(context).size.height / 1.6,
                        child: isLocationLoaded
                            ? GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: _kGooglePlex,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller = controller;
                                },
                                markers: {
                                  temp,
                                },
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                              )
                            : Center(
                                child: Text("Map is loading"),
                              ),
                      ),
                      Positioned(
                          right: 9,
                          top: MediaQuery.of(context).size.height / 1.6 - 155,
                          child: SizedBox(
                            height: 41,
                            width: 41,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {
                                setLiveLocation();
                              },
                              child: Icon(Icons.my_location,
                                  color: Color(0xff333333)),
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, right: 17, top: 30, bottom: 10),
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
                        (defaultChoiceIndex == 2)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: TextFormField(
                                  controller: addressType,
                                  autofocus: true,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value!.isEmpty) return "Enter type";
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hoverColor: Colors.white,
                                    hintText: "Enter type",
                                    constraints: BoxConstraints(
                                      maxHeight: 30,
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    prefixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            defaultChoiceIndex = 0;
                                          });
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.grey,
                                          size: 20,
                                        )),
                                    contentPadding: EdgeInsets.only(
                                      left: 15,
                                      right: 8,
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 0.7),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.7),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Wrap(
                                spacing: 8,
                                children:
                                    List.generate(_choicesList.length, (index) {
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
                                    selectedColor:
                                        Provider.of<ThemeColorProvider>(context)
                                            .appPrimaryMaterialColor,
                                    onSelected: (value) {
                                      setState(() {
                                        defaultChoiceIndex =
                                            value ? index : defaultChoiceIndex;
                                      });
                                    },
                                    elevation: 1,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                          controller: houseNo,
                        ),
                        MyTextFormField(
                          hintText: "area",
                          maxLines: 1,
                          controller: areaTxt,
                          validator: (value) {
                            if (value!.isEmpty) return "enter area";
                            return null;
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: MyTextFormField(
                                hintText: "city, state, country",
                                maxLines: 1,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return "enter city, state, country";
                                  return null;
                                },
                                controller: cityTxt,
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
                                controller: pinCode,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 17.0, right: 17, bottom: 12, top: 5),
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
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
                            widget.isEditing
                                ? _updateAddress(Address(
                                    type: defaultChoiceIndex == 2
                                        ? addressType.text
                                        : _choicesList
                                            .elementAt(defaultChoiceIndex),
                                    subAddress: houseNo.text,
                                    area: areaTxt.text,
                                    city: cityTxt.text,
                                    pinCode: int.parse(pinCode.text),
                                  ))
                                : _saveAddress(
                                    Address(
                                      type: defaultChoiceIndex == 2
                                          ? addressType.text
                                          : _choicesList
                                              .elementAt(defaultChoiceIndex),
                                      subAddress: houseNo.text,
                                      area: areaTxt.text,
                                      city: cityTxt.text,
                                      pinCode: int.parse(pinCode.text),
                                    ),
                                  );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 30, right: 17, left: 17),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(60)),
              child: Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: Icon(
                        Icons.chevron_left,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 85,
                    child: TextFormField(
                      onTap: () {
                        _showMyDialog();
                      },
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 13),
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        hintText: "Search here",
                        hintStyle: TextStyle(
                            fontSize: 12, color: Colors.grey.shade400),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.only(
                            left: 15, right: 8, top: 4, bottom: 4),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.7),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
