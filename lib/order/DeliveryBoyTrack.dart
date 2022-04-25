import 'dart:async';
import 'dart:math';
// import 'dart:math';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
//import 'package:flutter_compass/flutter_compass.dart';

double CAMERA_ZOOM = 16.8;
double CAMERA_TILT = 0;
double CAMERA_BEARING = 0;
// const LatLng SOURCE_LOCATION = LatLng(22.5692879, 88.4307626);
// const LatLng DEST_LOCATION =
//     LatLng(22.568957368567034, 88.43185323969915); // Indusnet Technology
//LatLng DEST_LOCATION = LatLng(22.569204060167028, 88.43307748465863); // RDB,

class DeliveryBoyTrack extends StatefulWidget {
  String orderId, latitude, longitude, totalAmount;
  DeliveryBoyTrack(
      {this.orderId, this.latitude, this.longitude, this.totalAmount, Key key})
      : super(key: key);

  @override
  State<DeliveryBoyTrack> createState() => _DeliveryBoyTrackState();
}

class _DeliveryBoyTrackState extends State<DeliveryBoyTrack> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

  // for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = "AIzaSyDJ_Ip4XJXlLr4XZZ2i1vm56ClFaaofjDI";
  var dio = Dio();
  // for my custom marker pins
  BitmapDescriptor sourceIcon, destinationIcon;
  // the user's initial location and current location
  // as it moves
  // a reference to the destination location
  LocationData currentLocation, destinationLocation;
  LatLng SOURCE_LOCATION;
  // LatLng DEST_LOCATION = LatLng(22.568957368567034, 88.43185323969915);
  LatLng DEST_LOCATION;
  CameraPosition initialCameraPosition;
  // wrapper around the location API
  //Location location;
  bool _pageLoad = false;
  var orderId, totalItems, totalPrice, boyName, phNo, boyImage;
  double _direction;
  @override
  void initState() {
    super.initState();
    // create an instance of LocationcurrentLocation
    print("initState...called...");

    DEST_LOCATION = LatLng(double.parse(widget.latitude.toString()),
        double.parse(widget.longitude.toString()));
    print("destinationLocation..." + DEST_LOCATION.toString());
    //location = new Location();
    polylinePoints = PolylinePoints();
    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    // location.onLocationChanged.listen((LocationData cLoc) {
    //   // cLoc contains the lat and long of the
    //   // current user's position in real time,
    //   // so we're holding on to it
    //   currentLocation = cLoc;
    //   //updatePinOnMap();
    // });
    //setInitialLocation();
    //location.enableBackgroundMode(enable: true);
    // set custom marker pins
    setSourceAndDestinationIcon();
    getLocation();

    // set the initial location
    // setInitialLocation();
  }

  void dispose() {
    super.dispose();
    updatePinOnMap();
    setInitialLocation();
  }

  void setSourceAndDestinationIcon() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5), 'images/bigb.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/destination_map_marker.png');
  }

  setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    // currentLocation = await location.getLocation();
    // print("get Location..." + currentLocation.toString());
    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
    print("get Location..." + destinationLocation.toString());
  }

  showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    print("set polylines called..." + pinPosition.toString());
    print("set polylines called...in destint..." +
        destinationLocation.latitude.toString());

    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);
    print("set polylines called..." + destPosition.toString());
    print("set polylines called..." + currentLocation.heading.toString());

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        rotation: 169.970703125,
        flat: false,
        icon: sourceIcon));

    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon));
    print("set polylines called..." + _markers.toString());

    // set the route lines on the map from source to destination
    setPolylines();
  }

  setPolylines() async {
    print("set polylines called...");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      print("polylines... coordinate..." + polylineCoordinates.toString());
      setState(() {
        _polylines.add(Polyline(
            width: 5,
            polylineId: PolylineId("poly"),
            color: Colors.black,
            points: polylineCoordinates));
      });
    }
  }

  updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    print("update pin on map");
    // CameraPosition cPosition = CameraPosition(
    //     zoom: CAMERA_ZOOM,
    //     tilt: CAMERA_TILT,
    //     bearing: CAMERA_BEARING,
    //     target: LatLng(currentLocation.latitude, currentLocation.longitude));
    // print("CPosition..." + cPosition.toString());
    // GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    if (mounted) {
      print("mount called...");
    }
    GoogleMapController controller = await _controller.future;

    setState(() {
      // updated position
      // double bearing = getBearing(
      //     LatLng(currentLocation.latitude, currentLocation.longitude),
      //     LatLng(destinationLocation.latitude, destinationLocation.longitude));
      // print("bearing..." + bearing.toString());
      CameraPosition cPosition = CameraPosition(
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: 0,
          target: LatLng(currentLocation.latitude, currentLocation.longitude));
      print("CPosition..." + cPosition.toString());
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
      //controller.moveCamera(CameraUpdate.newCameraPosition(cPosition));
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      print("CPosition..." + pinPosition.toString());
      _markers.removeWhere((element) => element.markerId.value == "sourcePin");
      _markers.add(Marker(
          markerId: MarkerId("sourcePin"),
          position: pinPosition,
          //rotation: 90,
          //alpha: destinationLocation.heading,
          icon: sourceIcon));
    });
  }

  @override
  Widget build(BuildContext context) {
    // CameraPosition initialCameraPosition = CameraPosition(
    //     zoom: CAMERA_ZOOM,
    //     tilt: CAMERA_TILT,
    //     bearing: CAMERA_BEARING,
    //     target: SOURCE_LOCATION);
    // if (currentLocation != null) {
    //   initialCameraPosition = CameraPosition(
    //       target: LatLng(currentLocation.latitude, currentLocation.longitude),
    //       zoom: CAMERA_ZOOM,
    //       tilt: CAMERA_TILT,
    //       bearing: CAMERA_BEARING);
    //   Future.delayed(Duration(seconds: 10), () {
    //     print("delayed....");
    //     getLocation();
    //   });
    // }
    // print("CPosition..." + initialCameraPosition.toString());
    print("orderId..." + widget.orderId.toString());
    print("orderId..." + widget.latitude.toString());
    print("orderId..." + widget.longitude.toString());

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.buttonColor.withOpacity(0.2),
          title: Text("Track"),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded))),
      body: _pageLoad == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: GoogleMap(
                      //myLocationEnabled: true,
                      //buildingsEnabled: true,
                      compassEnabled: true,
                      tiltGesturesEnabled: false,
                      rotateGesturesEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: true,
                      markers: _markers,
                      polylines: _polylines,
                      mapType: MapType.normal,
                      initialCameraPosition: initialCameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        // my map has completed being created;
                        // i'm ready to show the pins on the map
                        showPinsOnMap();
                      },
                      //onCameraMove: (CameraPosition pos) {},
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.01),
                    child: Text("Order ID:  #${widget.orderId}"),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.01),
                    child:
                        Text("$totalItems items,\u20B9${widget.totalAmount}"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.red,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width / 10,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  //shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage("images/logo.png"))),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              //color: Colors.teal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text("Order Picked Up",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05)),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                      "$boyName is on his way to deliver your delicious Food"),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Icon(Icons.domain_verification_rounded),
                                  //     Text(
                                  //       "Fully Vaccinated",
                                  //       style: TextStyle(
                                  //           fontSize: MediaQuery.of(context)
                                  //                   .size
                                  //                   .width *
                                  //               0.03),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.17,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4.0)
                                  ],
                                  //color: Colors.red,
                                  //shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(boyImage))),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.width * 0.12,
                          right: MediaQuery.of(context).size.width * 0.05,
                          child: InkWell(
                            onTap: () {
                              FlutterPhoneDirectCaller.callNumber(
                                  phNo.toString());
                            },
                            child: Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 0.2)
                                ], color: Colors.white, shape: BoxShape.circle),
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02),
                                child: Icon(
                                  Icons.phone,
                                  size:
                                      MediaQuery.of(context).size.width * 0.04,
                                )),
                          ))
                    ],
                  )
                ],
              ),
            ),
    );
  }

  getLocation() async {
    try {
      //var params = Const.deliveryBoyTrack + "?order_id=100323";
      var params = Const.deliveryBoyTrack + "?order_id=${widget.orderId}";

      print("params..." + params.toString());
      var response = await dio.get(params);
      print("params..." + response.data.toString());
      print("params..." + response.data['state'].toString());
      print("params..." + currentLocation.toString());
      if (response.data['state'] == 0) {
        print("currentLocation..." + currentLocation.toString());
        orderId = response.data['respData']['location_data'][0]['order_id']
            .toString();
        totalItems =
            response.data['respData']['cart_details'].length.toString();
        boyName = response.data['respData']['delivery_agent']['f_name'] +
            " " +
            response.data['respData']['delivery_agent']['l_name'];
        phNo = response.data['respData']['delivery_agent']['phone'];
        boyImage = response.data['respData']['delivery_agent']['image'];

        if (currentLocation == null) {
          if (mounted) {
            print("mounting in getLocation....");
          }
          setState(() {
            currentLocation = LocationData.fromMap({
              "latitude": double.parse(
                  response.data['respData']['location_data'][0]['latitude']),
              "longitude": double.parse(
                  response.data['respData']['location_data'][0]['longitude'])
            });
            print("mounting in getLocation....in..." +
                currentLocation.toString());

            // double bearing = getBearing(
            //     LatLng(currentLocation.latitude, currentLocation.longitude),
            //     LatLng(destinationLocation.latitude,
            //         destinationLocation.longitude));
            SOURCE_LOCATION =
                LatLng(currentLocation.latitude, currentLocation.longitude);
            initialCameraPosition = CameraPosition(
                zoom: CAMERA_ZOOM,
                tilt: CAMERA_TILT,
                bearing: 0,
                target: SOURCE_LOCATION);
            if (currentLocation != null) {
              // double bearing = getBearing(
              //     LatLng(currentLocation.latitude, currentLocation.longitude),
              //     LatLng(destinationLocation.latitude,
              //         destinationLocation.longitude));
              initialCameraPosition = CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: CAMERA_ZOOM,
                  tilt: CAMERA_TILT,
                  bearing: 0);
              Future.delayed(Duration(seconds: 3), () {
                print("delayed....");
                getLocation();
              });
            }
            print("CPosition..." + SOURCE_LOCATION.toString());
            print("CPosition..." + initialCameraPosition.toString());
          });

          print("params...in currentLocation..." + currentLocation.toString());
        } else {
          setState(() {
            currentLocation = LocationData.fromMap({
              "latitude": double.parse(response.data['respData']
                          ['location_data']
                      [response.data['respData']['location_data'].length - 1]
                  ['latitude']),
              "longitude": double.parse(response.data['respData']
                          ['location_data']
                      [response.data['respData']['location_data'].length - 1]
                  ['longitude'])
            });
            SOURCE_LOCATION =
                LatLng(currentLocation.latitude, currentLocation.longitude);
            // double bearing = getBearing(
            //     LatLng(currentLocation.latitude, currentLocation.longitude),
            //     LatLng(destinationLocation.latitude,
            //         destinationLocation.longitude));
            // print("bearing..." + bearing.toString());
            initialCameraPosition = CameraPosition(
                zoom: CAMERA_ZOOM,
                tilt: CAMERA_TILT,
                bearing: 12,
                target: SOURCE_LOCATION);
            if (currentLocation != null) {
              initialCameraPosition = CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: CAMERA_ZOOM,
                  tilt: CAMERA_TILT,
                  bearing: 12);
              Future.delayed(Duration(seconds: 10), () {
                print("delayed....");
                getLocation();
              });
            }
            print("CPosition..." + initialCameraPosition.toString());
          });
          print("params...in currentLocation..." + currentLocation.toString());

          updatePinOnMap();
        }
        // currentLocation = LocationData.fromMap({
        //   "latitude": double.parse(response.data['respData']
        //       [response.data['respData'].length - 1]['longitude']),
        //   "longitude": double.parse(response.data['respData']
        //       [response.data['respData'].length - 1]['latitude'])
        // });

        print("current Location from Api..." + currentLocation.toString());
        setInitialLocation();
        setState(() {
          _pageLoad = true;
        });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _call() async {
    print("pho..." + phNo.toString());
    FlutterPhoneDirectCaller.callNumber(phNo.toString());
  }

  double getBearing(LatLng begin, LatLng end) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((end.latitude - begin.latitude) * p) / 2 +
        c(begin.latitude * p) *
            c(end.latitude * p) *
            (1 - c((end.longitude - begin.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
    // double lat = (begin.latitude - end.latitude).abs();
    // double lng = (begin.longitude - end.longitude).abs();
    // if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
    //   return degrees(atan(lng / lat));
    // } else if (begin.latitude >= end.latitude &&
    //     begin.longitude < end.longitude) {
    //   return (90 - degrees(atan(lng / lat))) + 90;
    // } else if (begin.latitude >= end.latitude &&
    //     begin.longitude >= end.longitude) {
    //   return degrees(atan(lng / lat)) + 180;
    // } else if (begin.latitude < end.latitude &&
    //     begin.longitude >= end.longitude) {
    //   return (90 - degrees(atan(lng / lat))) + 270;
    // }

    // return -1;
  }
}

// import 'dart:async';
// import 'package:bazimat/util/Const.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// const double CAMERA_ZOOM = 16;
// const double CAMERA_TILT = 80;
// const double CAMERA_BEARING = 30;
// //const LatLng SOURCE_LOCATION = LatLng(22.5692879, 88.4307626);
// const LatLng DEST_LOCATION = LatLng(22.5692879, 88.4307626);
// // LatLng(22.568957368567034, 88.43185323969915); // Indusnet Technology
// // //LatLng DEST_LOCATION = LatLng(22.569204060167028, 88.43307748465863); // RDB,

// class DeliveryBoyTrack extends StatefulWidget {
//   const DeliveryBoyTrack({Key key}) : super(key: key);

//   @override
//   State<DeliveryBoyTrack> createState() => _DeliveryBoyTrackState();
// }

// class _DeliveryBoyTrackState extends State<DeliveryBoyTrack> {
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> _markers = Set<Marker>();

//   // for my drawn routes on the map
//   Set<Polyline> _polylines = Set<Polyline>();
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints;
//   String googleAPIKey = "AIzaSyDJ_Ip4XJXlLr4XZZ2i1vm56ClFaaofjDI";

//   // double CAMERA_ZOOM = 16;
//   // double CAMERA_TILT = 80;
//   // double CAMERA_BEARING = 30;
//   // LatLng SOURCE_LOCATION = LatLng(22.5692879, 88.4307626);
//   // LatLng DEST_LOCATION =
//   //     LatLng(22.568957368567034, 88.43185323969915); // Indusnet Technology
// //LatLng DEST_LOCATION = LatLng(22.569204060167028, 88.43307748465863); // RDB,

//   // for my custom marker pins
//   BitmapDescriptor sourceIcon, destinationIcon;
//   // the user's initial location and current location
//   // as it moves
//   // a reference to the destination location
//   LocationData currentLocation, destinationLocation;
//   // wrapper around the location API
//   Location location;
//   var pinPosition;
//   var dio = Dio();
//   bool _pageLoad = false;
//   CameraPosition initialCameraPosition;
//   @override
//   void initState() {
//     super.initState();
//     // create an instance of Location
//     print("initState...called...");
//     location = new Location();
//     polylinePoints = PolylinePoints();
//     getLocation();
//     // subscribe to changes in the user's location
//     // by "listening" to the location's onLocationChanged event
//     // location.onLocationChanged.listen((LocationData cLoc) {
//     //   // cLoc contains the lat and long of the
//     //   // current user's position in real time,
//     //   // so we're holding on to it
//     //   currentLocation = cLoc;
//     //   updatePinOnMap();
//     // });

//     //setInitialLocation();
//     //location.enableBackgroundMode(enable: true);
//     // set custom marker pins
//     setSourceAndDestinationIcon();

//     // set the initial location
//     // setInitialLocation();
//   }

//   // void dispose() {
//   //   super.dispose();

//   //   // _polylines.clear();
//   //   // polylineCoordinates.clear();
//   //   // showPinsOnMap();

//   //   // updatePinOnMap();
//   //   // setInitialLocation();
//   // }

//   setSourceAndDestinationIcon() async {
//     // sourceIcon = await BitmapDescriptor.fromAssetImage(
//     //     ImageConfiguration(devicePixelRatio: 0.5), 'images/driving_pin.jpg');
//     sourceIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 0.5), 'images/driving_pin.png');
//     destinationIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 2.5),
//         'images/destination_map_marker.png');
//   }

//   setInitialLocation() async {
//     // set the initial location by pulling the user's
//     // current location from the location's getLocation()
//     //currentLocation = await location.getLocation();
//     print("get Location..." + currentLocation.toString());
//     // hard-coded destination for this example
//     destinationLocation = LocationData.fromMap({
//       "latitude": DEST_LOCATION.latitude,
//       "longitude": DEST_LOCATION.longitude
//     });
//     print("get Location...dest..." + destinationLocation.toString());
//   }

//   showPinsOnMap() {
//     // get a LatLng for the source location
//     // from the LocationData currentLocation object
//     var pinPosition =
//         LatLng(currentLocation.latitude, currentLocation.longitude);
//     print("set polylines called..." + pinPosition.toString());
//     print("set polylines called...in destint..." +
//         destinationLocation.latitude.toString());

//     // get a LatLng out of the LocationData object
//     var destPosition =
//         LatLng(destinationLocation.latitude, destinationLocation.longitude);
//     print("set polylines called..." + destPosition.toString());

//     // add the initial source location pin
//     _markers.add(Marker(
//         markerId: MarkerId('sourcePin'),
//         position: pinPosition,
//         icon: sourceIcon));

//     // destination pin
//     _markers.add(Marker(
//         markerId: MarkerId('destPin'),
//         position: destPosition,
//         icon: destinationIcon));
//     print("set polylines called..." + _markers.toString());

//     // set the route lines on the map from source to destination
//     setPolylines();
//   }

//   setPolylines() async {
//     print("set polylines called...");
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPIKey,
//         PointLatLng(currentLocation.latitude, currentLocation.longitude),
//         PointLatLng(
//             destinationLocation.latitude, destinationLocation.longitude),
//         travelMode: TravelMode.driving);
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//       print("polylines... coordinate..." + polylineCoordinates.toString());
//       setState(() {
//         _polylines.add(Polyline(
//             width: 5,
//             polylineId: PolylineId("poly"),
//             color: Colors.black,
//             points: polylineCoordinates));
//       });
//     }
//   }

//   updatePinOnMap() async {
//     // create a new CameraPosition instance
//     // every time the location changes, so the camera
//     // follows the pin as it moves with an animation

//     CameraPosition cPosition = CameraPosition(
//         zoom: CAMERA_ZOOM,
//         tilt: CAMERA_TILT,
//         bearing: CAMERA_BEARING,
//         target: LatLng(currentLocation.latitude, currentLocation.longitude));
//     print("CPosition..." + cPosition.toString());
//     GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//     if (mounted) {
//       print("mounting on...");
//     }
//     setState(() {
//       // updated position
//       pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
//       print("heading..." + currentLocation.heading.toString());
//       // the trick is to remove the marker (by id)
//       // and add it again at the updated location
//       _markers.removeWhere((element) => element.markerId.value == "sourcePin");
//       _markers.add(Marker(
//           markerId: MarkerId("sourcePin"),
//           position: pinPosition,
//           //rotation: currentLocation.heading,
//           //rotation: true,
//           icon: sourceIcon));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Track"),
//       ),
//       body: _pageLoad == false
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height / 1.8,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.transparent,
//                     child: GoogleMap(
//                       myLocationEnabled: true,
//                       compassEnabled: true,
//                       tiltGesturesEnabled: false,
//                       markers: _markers,
//                       polylines: _polylines,
//                       mapType: MapType.normal,
//                       initialCameraPosition: initialCameraPosition,
//                       onMapCreated: (GoogleMapController controller) {
//                         _controller.complete(controller);
//                         // my map has completed being created;
//                         // i'm ready to show the pins on the map
//                         showPinsOnMap();
//                       },
//                       // onCameraMove: (position) {
//                       //   pinPosition = position.target;
//                       // },
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.width * 0.02,
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(
//                         MediaQuery.of(context).size.width * 0.01),
//                     child: Text("Order #112209199"),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(
//                         MediaQuery.of(context).size.width * 0.01),
//                     child: Text("4 items,\u20B9470"),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.width * 0.02,
//                   ),
//                   Stack(
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         //color: Colors.red,
//                         padding: EdgeInsets.all(
//                             MediaQuery.of(context).size.width * 0.02),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: MediaQuery.of(context).size.width * 0.1,
//                               width: MediaQuery.of(context).size.width / 10,
//                               decoration: BoxDecoration(
//                                   color: Colors.amber,
//                                   //shape: BoxShape.circle,
//                                   image: DecorationImage(
//                                       image: AssetImage("images/logo.png"))),
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.01,
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width / 1.5,
//                               //color: Colors.teal,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     child: Text("Order Picked Up",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.05)),
//                                   ),
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.width *
//                                         0.01,
//                                   ),
//                                   Text(
//                                       "abc is on his way to deliver your delicious Food"),
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.width *
//                                         0.01,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.domain_verification_rounded),
//                                       Text(
//                                         "Fully Vaccinated",
//                                         style: TextStyle(
//                                             fontSize: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.03),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Spacer(),
//                             Container(
//                               height: MediaQuery.of(context).size.height * 0.07,
//                               width: MediaQuery.of(context).size.width * 0.17,
//                               decoration: BoxDecoration(
//                                   color: Colors.red,
//                                   //shape: BoxShape.circle,
//                                   image: DecorationImage(
//                                       image: AssetImage("images/logo.png"))),
//                             )
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                           top: MediaQuery.of(context).size.width * 0.12,
//                           right: MediaQuery.of(context).size.width * 0.05,
//                           child: Container(
//                               decoration: BoxDecoration(boxShadow: [
//                                 BoxShadow(color: Colors.grey, blurRadius: 0.2)
//                               ], color: Colors.white, shape: BoxShape.circle),
//                               padding: EdgeInsets.all(
//                                   MediaQuery.of(context).size.width * 0.03),
//                               child: Icon(
//                                 Icons.phone,
//                                 size: MediaQuery.of(context).size.width * 0.04,
//                               )))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//     );
//   }

//   getLocation() async {
//     try {
//       var params = Const.deliveryBoyTrack + "?order_id=100269";
//       print("params..." + params.toString());
//       var response = await dio.get(params);
//       print("params..." + response.data.toString());
//       print("params..." + response.data['state'].toString());
//       if (response.data['state'] == 0) {
//         print("response get Location..." +
//             response.data['respData'].length.toString());
//         LatLng SOURCE_LOCATION = LatLng(
//             double.parse(response.data['respData'][0]['longitude']),
//             double.parse(response.data['respData'][0]['latitude']));
//         print("Source_...." + SOURCE_LOCATION.toString());
//         initialCameraPosition = CameraPosition(
//             zoom: CAMERA_ZOOM,
//             tilt: CAMERA_TILT,
//             bearing: CAMERA_BEARING,
//             target: SOURCE_LOCATION);
//         currentLocation = await location.getLocation();
//         print("currentLocation in widget..." + currentLocation.toString());
//         if (currentLocation != null) {
//           initialCameraPosition = CameraPosition(
//               target:
//                   LatLng(currentLocation.latitude, currentLocation.longitude),
//               zoom: CAMERA_ZOOM,
//               tilt: CAMERA_TILT,
//               bearing: CAMERA_BEARING);
//         }
//         print("CPosition..." + initialCameraPosition.toString());
//         setState(() {
//           _pageLoad = true;
//           updatePinOnMap();
//         });
//         //currentLocation = LatLng(respo, longitude);
//       }
//     } on DioError catch (e) {
//       print(e.toString());
//     }
//   }
// }
