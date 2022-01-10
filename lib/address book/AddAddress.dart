import 'dart:async';

import 'package:bazimat/address%20book/AddressBook.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor customIcon1;
  Set<Marker> markers;
  bool _mapLoad;
  double lat, lng;
  String address = "";
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(22.3463779, 87.2754387),
  //   zoom: 14.4746,
  // );
  //Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //List<Marker> markers = [];
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(lat, lng),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  // final marker = Marker(
  //   markerId: MarkerId('place_name'),
  //   position: LatLng(22.3463779, 87.2754387),
  //   icon: BitmapDescriptor.defaultMarker,
  //   infoWindow: InfoWindow(
  //     title: 'title',
  //     snippet: 'address',
  //   ),
  // );

  //   setState(() {
  //     markers[MarkerId('place_name')] = marker;
  //   });
  // }

  void initState() {
    super.initState();
    _mapLoad = false;
    markers = Set.from([]);
    _getCurrentLocation();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: _mapLoad == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                    markers: markers,
                    //mapType: MapType.hybrid,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, lng),
                      zoom: 14.4746,
                    ),
                    //CameraPosition(target: LatLng(-33.870840, 151.206286), zoom: 12),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    //markers: markers.values.toSet(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(address),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddressBook())),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent)),
                          child: Text(
                            "Change",
                            style: TextStyle(color: Colors.white),
                          )),
                    )),
                Spacer(),
                TextButton(
                    onPressed: () => _locationAddress(),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    child: Text("Confirm Location".toUpperCase()))
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToTheLake,
        child: Icon(Icons.add),

        //label: Text('+'),
        // child: Column(
        //   children: [Icon(Icons.add), Icon(Icons.add)],
        // )
        //label: Text('To the lake!'),
        //icon: Icon(Icons.directions_boat),
      ),
    );
  }

  _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(lat, lng),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    print("Controller..." + controller.toString());
  }

  _getCurrentLocation() async {
    try {
      Geolocator _geolocator = Geolocator();
      SharedPreferences pref = await SharedPreferences.getInstance();
      Position position = await _geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print("latitude..." + position.latitude.toString());
      print("longitude..." + position.longitude.toString());
      // lat = double.parse(pref.getString("latitude"));
      // lng = double.parse(pref.getString("longitude"));
      lat = position.latitude;
      lng = position.longitude;
      print("latitude..." + lat.toString());
      print("longitude..." + lng.toString());
      Marker f = Marker(
          markerId: MarkerId('1'),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(lat, lng));
      markers.add(f);
      var placemarks = await _geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      address =
          '${placemarks.first.name.isNotEmpty ? placemarks.first.name + ', ' : ''}${placemarks.first.thoroughfare.isNotEmpty ? placemarks.first.thoroughfare + ', ' : ''}${placemarks.first.subLocality.isNotEmpty ? placemarks.first.subLocality + ', ' : ''}${placemarks.first.locality.isNotEmpty ? placemarks.first.locality + ', ' : ''}${placemarks.first.subAdministrativeArea.isNotEmpty ? placemarks.first.subAdministrativeArea + ', ' : ''}${placemarks.first.postalCode.isNotEmpty ? placemarks.first.postalCode + ', ' : ''}${placemarks.first.administrativeArea.isNotEmpty ? placemarks.first.administrativeArea : ''}';
      print("address..." + address.toString());
      setState(() {
        _mapLoad = true;
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _locationAddress() {
    Navigator.of(context).pop({"address": address});
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.7,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.amber,
//             child: GoogleMap(
//               mapType: MapType.hybrid,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//           ),
//           FloatingActionButton.extended(
//             onPressed: _goToTheLake,
//             label: Text('To the lake!'),
//             icon: Icon(Icons.directions_boat),
//           ),
//         ],
//       ),
//     ));
//   }

//   // Future<void> _goToTheLake() async {
//   //   final GoogleMapController controller = await _controller.future;
//   //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   // }
// }
