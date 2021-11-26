import 'package:flutter/material.dart';

class BlueClipper extends CustomClipper<Path> {
  double width;
  double height;
  BlueClipper(this.width, this.height);
  @override
  getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    print("size... width..." + size.width.toString());
    path.lineTo(0.0, height);
    var firstStartpoint =
        Offset(size.width / 8 - size.width / 4, size.height - 98);
    var firstEndpoint =
        Offset(size.width / 4 + size.width / 200 + 8, size.height - 90);
    path.quadraticBezierTo(
      firstStartpoint.dx,
      firstStartpoint.dy,
      firstEndpoint.dx,
      firstEndpoint.dy,
    );
    var secStartpoint =
        Offset(size.width / 1.7 + size.width / 80 - 80, size.height - 88);
    var secEndpoint =
        Offset(size.width / 1.5 + size.width / 100 - 35, size.height - 46);
    path.quadraticBezierTo(
      secStartpoint.dx,
      secStartpoint.dy,
      secEndpoint.dx,
      secEndpoint.dy,
    );
    var tStartpoint =
        Offset(3 * (size.width / 6) + size.width / 3, size.height);
    var tecEndpoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
      tStartpoint.dx,
      tStartpoint.dy,
      tecEndpoint.dx,
      tecEndpoint.dy,
    );
    // path.lineTo(width * 0.9, height * 0.80);
    path.lineTo(size.width, 0);
    path.close();
    //throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
