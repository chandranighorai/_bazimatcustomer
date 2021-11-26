import 'package:flutter/material.dart';

class CurrentOrder extends StatefulWidget {
  const CurrentOrder({Key key}) : super(key: key);

  @override
  _CurrentOrderState createState() => _CurrentOrderState();
}

class _CurrentOrderState extends State<CurrentOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Current Order",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
