// import 'dart:html';

import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
//import 'package:geocoder/services/base.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AddressType { home, office }

class ManualAddress extends StatefulWidget {
  const ManualAddress({Key key}) : super(key: key);

  @override
  _ManualAddressState createState() => _ManualAddressState();
}

class _ManualAddressState extends State<ManualAddress> {
  var dio = Dio();
  AddressType _type = AddressType.home;
  TextEditingController _nameText, _phoneText, _addrText;
  var lat, lng, userId, name, phoneNumber, token;
  // GoogleMapsPlaces _places =
  //     GoogleMapsPlaces(apiKey: "AIzaSyDJ_Ip4XJXlLr4XZZ2i1vm56ClFaaofjDI",apiHeaders: await GoogleApiHeaders().getHeaders(),);
  //List<Location> locations;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfo();
    _nameText = new TextEditingController();
    _phoneText = new TextEditingController();
    _addrText = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Manual Address",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            children: [
              TextFormField(
                controller: _nameText,
                decoration: InputDecoration(hintText: "Enter Name"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              TextFormField(
                controller: _phoneText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Enter Phone Number"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              TextFormField(
                controller: _addrText,
                maxLines: 2,
                decoration: InputDecoration(hintText: "Enter Address"),
                // onChanged: (value) {
                //   print("Vall..." + value.toString());
                //   _getLatLng(value.toString());
                // },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Container(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () async {
                      print("button click...");
                      // show input autocomplete with selected mode
                      // then get the Prediction selected
                      Prediction p = await PlacesAutocomplete.show(
                        context: context,
                        mode: Mode.fullscreen,
                        region: "in",
                        strictbounds: false,
                        offset: 0,
                        radius: 30000, // required
                        types: [],
                        components: [Component(Component.country, "in")],
                        apiKey: "AIzaSyDJ_Ip4XJXlLr4XZZ2i1vm56ClFaaofjDI",
                      );
                      print("p in button..." + p.toString());
                      displayPrediction(p);
                    },
                    child: Text('Find address'),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: ListTile(
                      title: Row(
                        children: [
                          Radio(
                            value: AddressType.home,
                            groupValue: _type,
                            onChanged: (AddressType value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                          Text("Home"),
                        ],
                      ),
                      //leading: ,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: ListTile(
                      //visualDensity:
                      //VisualDensity(horizontal: 0, vertical: -4),
                      title: Row(
                        children: [
                          Radio(
                            value: AddressType.office,
                            groupValue: _type,
                            onChanged: (AddressType value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                          Text("Office"),
                        ],
                      ),
                      // leading: Radio<AddressType>(
                      //   value: AddressType.office,
                      //   groupValue: _type,
                      //   onChanged: (AddressType value) {
                      //     setState(() {
                      //       _type = value;
                      //     });
                      //   },
                      // ),
                    ),
                  ),
                  Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 12.0),
                  //   child: TextButton(
                  //       onPressed: () => Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   AddressBook(refresh: widget.refresh))),
                  //       style: ButtonStyle(
                  //           backgroundColor:
                  //               MaterialStateProperty.all(Colors.blueAccent)),
                  //       child: Text(
                  //         "Change",
                  //         style: TextStyle(color: Colors.white),
                  //       )),
                  // ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              TextButton(onPressed: _addressSubmit, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  // _getLatLng(String value) async {
  //   print("Vall..." + value.toString());
  //   Prediction p = await PlacesAutocomplete.show(
  //       context: context, apiKey: "AIzaSyDJ_Ip4XJXlLr4XZZ2i1vm56ClFaaofjDI");
  //   print("Vall...0..." + p.toString());
  //   displayPrediction(p);
  // }

  displayPrediction(Prediction p) async {
    print("Vall...0..." + p.toString());
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: "AIzaSyDJ_Ip4XJXlLr4XZZ2i1vm56ClFaaofjDI",
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      var placeId = p.placeId;
      lat = detail.result.geometry.location.lat;
      lng = detail.result.geometry.location.lng;
      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      print("Lat..." + lat.toString());
      print("Lng..." + lng.toString());
      print("Lng..." + p.description.toString());
      _addrText.text = p.description.toString();
      print("Address..." + address.toString());
    } else {
      print("Vall...0..." + p.toString());
    }
  }

//   _getLatLng(String value) async {
//     print("vall..." + value.toString());
//     var addr = await Geocoder.google("AIzaSyDJ_Ip4XJXlLr4XZZ2i1vm56ClFaaofjDI")
//         .findAddressesFromQuery(value);
//     print("vall..." + addr.first.coordinates.toString());
//     final coordinate = new Coordinates(
//         addr.first.coordinates.latitude, addr.first.coordinates.longitude);
//        var addresses = await Geocoder.google("AIzaSyDJ_Ip4XJXlLr4XZZ2i1vm56ClFaaofjDI").findAddressesFromCoordinates(coordinate);
// var first = addresses.first;
// print("${first.featureName} : ${first.addressLine}");
//     // GeoCode geoCode = GeoCode();
//     // try {
//     //   Coordinates coordinates = await geoCode.forwardGeocoding(address: value);
//     //   print("Latitude..." + coordinates.latitude.toString());
//     //   print("Longitude..." + coordinates.longitude.toString());
//     // } catch (e) {
//     //   print(e);
//     // }
//     // print("locations..." + value.toString());
//     // locations = await locationFromAddress(value);
//     // print("locations..." + locations.toString());
//   }

  _addressSubmit() async {
    try {
      print("longitude..." + lat.toString());
      print("longitude..." + lng.toString());
      print("longitude..." + _addrText.text.toString());
      print("longitude..." + _type.toString());
      if (_nameText.text.length == 0 ||
          _phoneText.text.length == 0 ||
          _addrText.text.length == 0) {
        showCustomToast("Please Fill data properly");
      } else {
        var addressType = _type == AddressType.home ? "home" : "office";
        var params = "?user_id=" +
            userId.toString() +
            "&contact_person_name=" +
            name.toString() +
            "&address_type=" +
            addressType.toString() +
            "&contact_person_number=" +
            phoneNumber.toString() +
            "&address=" +
            _addrText.text +
            "&latitude=" +
            lat.toString() +
            "&longitude=" +
            lng.toString();
        var url = Const.manualAddr + params;
        print("addressData..." + url.toString());
        var response = await dio.post(url,
            options: Options(headers: {"Authorization": "Bearer $token"}));
        print("addressData..." + response.data.toString());
        if (response.data["state"] == 0) {
          showCustomToast(response.data[""]);
        } else {
          showCustomToast(response.data["errors"][0]["message"]);
        }
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getInfo() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      userId = pref.getString("id");
      var fName = pref.getString("fName");
      var lName = pref.getString("lName");
      token = pref.getString("token");
      name = fName + " " + lName;
      phoneNumber = pref.getString("Phone");
      _nameText.text = name;
      _phoneText.text = phoneNumber;
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
