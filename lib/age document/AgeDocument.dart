import 'dart:io';

import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

class AgeDocument extends StatefulWidget {
  const AgeDocument({Key key}) : super(key: key);

  @override
  _AgeDocumentState createState() => _AgeDocumentState();
}

class _AgeDocumentState extends State<AgeDocument> {
  var _image, _image1;
  //String _img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.moreText,
        title: Text("Additional Information"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                color: Colors.white,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter Date Of Birth',
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      _getImage(ImgSource.Both, 1);
                      // print("bytes..." + imagePath.toString());
                      // final bytes = imagePath.readAsBytesSync();
                      // print("bytes..." + bytes.toString());
                      // _img = base64Encode(bytes);
                      // print("Img..." + _img.toString());
                    },
                    child: Text("Govt. id for age proof (front page)")),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              _image != null
                  ? Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.35,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              //color: Colors.redAccent,
                              ),
                          child: Image.file(
                            File(_image),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                            //top: MediaQuery.of(context).size.width * 0.00,
                            left: MediaQuery.of(context).size.width * 0.23,
                            bottom: MediaQuery.of(context).size.width * 0.25,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                            )),
                      ],
                    )
                  : SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () => _getImage(ImgSource.Both, 2),
                    child: Text("Govt. id for age proof (back page)")),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              _image1 != null
                  ? Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.35,
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                              //color: Colors.redAccent,
                              ),
                          child: Image.file(
                            File(_image1),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                            //top: MediaQuery.of(context).size.width * 0.00,
                            left: MediaQuery.of(context).size.width * 0.23,
                            bottom: MediaQuery.of(context).size.width * 0.25,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _image1 = null;
                                });
                              },
                            )),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.moreText),
                    onPressed: null,
                    child: Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getImage(ImgSource source, int data) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        closeIcon: Icon(
          Icons.close,
          color: Colors.black,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraText: Text(
          "From Camera",
          style: TextStyle(color: Colors.black),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(color: Colors.black),
        ));
    if (data == 1) {
      setState(() {
        _image = image.path;
        print("Image..." + _image.toString());
      });
      return _image;
    } else {
      setState(() {
        _image1 = image.path;
        print("Image..." + _image1.toString());
      });
      return _image1;
    }
  }
}