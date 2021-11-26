import 'package:bazimat/order/PastOrderList.dart';
import 'package:flutter/material.dart';

class PastOrder extends StatefulWidget {
  const PastOrder({Key key}) : super(key: key);

  @override
  _PastOrderState createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return PastOrderList();
          }),
    );
  }
}
