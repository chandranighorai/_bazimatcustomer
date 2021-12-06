import 'dart:io';
import 'package:flutter/material.dart';

class PhotoView extends StatelessWidget {
  var _image;
  PhotoView(this._image);

  @override
  Widget build(BuildContext context) {
    print("image...$_image");
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   image: DecorationImage(ima)
      // ),
      child: Image.file(File(_image)),
    );
  }
}
