import 'package:flutter/material.dart';

class ZoomImage extends StatefulWidget {
  var imgLink;
  ZoomImage({this.imgLink, Key key}) : super(key: key);

  @override
  _ZoomImageState createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: NetworkImage(widget.imgLink))),
    );
  }
}
