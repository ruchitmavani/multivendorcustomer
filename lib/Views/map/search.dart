import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:uuid/uuid.dart';

class LocationSearchBar extends StatefulWidget {
  LocationSearchBar(
      {this.lat, this.long, required this.setData, required this.setLocation});

  final double? lat;
  final double? long;
  final Function setData;
  final Function setLocation;

  @override
  _LocationSearchBarState createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  TextEditingController _search = TextEditingController();
  List<AutocompletePrediction> predictions = [];
  var uuid = Uuid();
  String _sessionToken = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: TextFormField(
                controller: _search,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 13),
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    autoCompleteSearch(text);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: "Search here...",
                  hintStyle:
                      TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
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
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.7),
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
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(predictions[index].fullText),
                    onTap: ()async {
                      await getLatLong(predictions[index].placeId);
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      widget.setData(
                          area: predictions[index].primaryText,
                          city: predictions[index].secondaryText);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    final places =
        FlutterGooglePlacesSdk('AIzaSyBGVURpKj-7hA1Nra-MthetW7qOyjyX8Sc');
    final result = await places.findAutocompletePredictions(
      value,
      origin: (widget.lat == null || widget.long == null)
          ? null
          : LatLng(lat: widget.lat!, lng: widget.long!),
    );
    if (mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }

  Future getLatLong(String placeId) async {
    final places =
        FlutterGooglePlacesSdk('AIzaSyBGVURpKj-7hA1Nra-MthetW7qOyjyX8Sc');
    final result = await places.fetchPlace(placeId);
    // return result.place?.latLng;

    if (mounted && result.place != null && result.place?.latLng !=null ) {
      setState(() {
        widget.setLocation(result.place?.latLng?.lat, result.place?.latLng?.lng,placeId);
      });
    }
  }
}
