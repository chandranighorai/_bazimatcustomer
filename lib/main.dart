import 'dart:async';
//import 'package:bazimat/sign%20up/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign up/SignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Geolocator _geolocator;
  Position _position;

  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator();
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
    checkPermission();
    updateLocation();
    // ignore: cancel_subscriptions
    StreamSubscription positionStream = _geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      setState(() {
        _position = position;
      });
      //print("Position...in current...$_position");
    });
    print("Position...in current...$_position");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    checkPermission();
    updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: SignUp());
  }

  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) {
      print("Status..." + status.toString());
    });
    _geolocator
        .checkGeolocationPermissionStatus(
            locationPermission: GeolocationPermission.locationAlways)
        .then((value) {
      print("Value..." + value.toString());
    });
    _geolocator.checkGeolocationPermissionStatus(
        locationPermission: GeolocationPermission.locationWhenInUse)
      ..then((value) {
        print("Value..." + value.toString());
      });
  }

  updateLocation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      Position newPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));
      setState(() {
        _position = newPosition;
        print("Error...$_position");
        sharedPreferences.setString("latitude", _position.latitude.toString());
        sharedPreferences.setString(
            "longitude", _position.longitude.toString());
      });
    } catch (e) {
      print("Error...." + e.toString());
    }
  }
}
