import 'package:bazimat/home/Clipper.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class CouponList extends StatefulWidget {
  var couponL;
  CouponList({this.couponL, Key key}) : super(key: key);

  @override
  _CouponListState createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipPath(
        clipper: DesignClip(),
        child: Container(
          //height: MediaQuery.of(context).size.width * 0.23,
          width: MediaQuery.of(context).size.width / 2.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.01)),
              image: DecorationImage(
                  image: AssetImage(widget.couponL.toString()),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
