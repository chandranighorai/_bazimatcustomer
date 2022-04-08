import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(22.5692879, 88.4307626);
// const LatLng DEST_LOCATION =
//     LatLng(22.568957368567034, 88.43185323969915); // Indusnet Technology
LatLng DEST_LOCATION = LatLng(22.569204060167028, 88.43307748465863); // RDB,

class DeliveryBoyTrack extends StatefulWidget {
  const DeliveryBoyTrack({Key key}) : super(key: key);

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

  // for my custom marker pins
  BitmapDescriptor sourceIcon, destinationIcon;
  // the user's initial location and current location
  // as it moves
  // a reference to the destination location
  LocationData currentLocation, destinationLocation;
  // wrapper around the location API
  Location location;
  @override
  void initState() {
    super.initState();
    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();
    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();
    });
    // set custom marker pins
    setSourceAndDestinationIcon();

    // set the initial location
    setInitialLocation();
  }

  void setSourceAndDestinationIcon() async {
    // sourceIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 0.5), 'images/driving_pin.jpg');
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5), 'images/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/destination_map_marker.png');
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();
    print("get Location..." + currentLocation.toString());
    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
    print("get Location..." + destinationLocation.toString());
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    print("set polylines called..." + pinPosition.toString());

    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);
    print("set polylines called..." + destPosition.toString());

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
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

  void setPolylines() async {
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

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation

    CameraPosition cPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(currentLocation.latitude, currentLocation.longitude));
    print("CPosition..." + cPosition.toString());
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((element) => element.markerId.value == "sourcePin");
      _markers.add(Marker(
          markerId: MarkerId("sourcePin"),
          position: pinPosition,
          icon: sourceIcon));
    });
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    print("CPosition..." + initialCameraPosition.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Track"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: GoogleMap(
                myLocationEnabled: true,
                compassEnabled: true,
                tiltGesturesEnabled: false,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}