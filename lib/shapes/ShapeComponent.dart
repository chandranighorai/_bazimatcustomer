import 'package:bazimat/shapes/blueClip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ShapeComponent(BuildContext context, double shapeHeight) {
  return ClipPath(
    clipper: BlueClipper(MediaQuery.of(context).size.width, shapeHeight),
    child: Container(
      alignment: Alignment.centerRight,
      height: shapeHeight * 1.55,
      decoration: BoxDecoration(color: Colors.blue),
    ),
  );
}
