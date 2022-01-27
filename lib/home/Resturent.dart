import 'dart:ui';

import 'package:bazimat/home/GetDistance.dart';
import 'package:bazimat/home/ResturentList.dart';
import 'package:bazimat/home/ResturentModel.dart';
import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Resturent extends StatefulWidget {
  Restaurants resturentData;
  var coverimgpath, latitude, longitude;
  Resturent(
      {this.resturentData,
      this.coverimgpath,
      this.latitude,
      this.longitude,
      Key key});

  @override
  _ResturentState createState() => _ResturentState();
}

class _ResturentState extends State<Resturent> {
  var dio = Dio();
  bool _distanceLoad;
  var getDistanceResponse;
  //Future<GetDistance> _distance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _distanceLoad = false;
    _getDistance(widget.resturentData.latitude, widget.resturentData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    print("resturentData...image..." + widget.coverimgpath.toString());
    print("resturentData...coverPhoto..." +
        widget.resturentData.coverPhoto.toString());
    var image = widget.coverimgpath + widget.resturentData.coverPhoto;
    print("resturentData..." + widget.resturentData.name.toString());
    return InkWell(
      onTap: () {
        _distanceLoad == false
            ? showCustomToast("wait a few seconds")
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CuisinDetails(
                        resturentData: widget.resturentData,
                        resturentLat: widget.resturentData.latitude,
                        resturentLng: widget.resturentData.longitude,
                        distance: getDistanceResponse.data["rows"][0]
                            ["elements"][0]["distance"]["text"],
                        duration: getDistanceResponse.data["rows"][0]
                            ["elements"][0]["duration"]["text"])));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 30.0),
            child: Container(
              // height: MediaQuery.of(context).size.width * 0.75,
              // width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width * 0.02)),
              ),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        //color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width * 0.02))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.resturentData.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "${widget.resturentData.description}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.01,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Text(
                                "${widget.resturentData.address}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                              VerticalDivider(
                                // thickness:
                                //     MediaQuery.of(context).size.width * 0.01,
                                color: Colors.grey,
                                width: MediaQuery.of(context).size.width * 0.05,
                                //height: 5,
                              ),
                              Text(
                                //"",
                                _distanceLoad == false
                                    ? "..."
                                    : "${getDistanceResponse.data["rows"][0]["elements"][0]["distance"]["text"]}",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.01,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, left: 0.0, bottom: 3.0, right: 3.0),
                            child: Icon(
                              Icons.star,
                              size: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.grey,
                            ),
                          )),
                          TextSpan(
                              text: "${widget.resturentData.avgRating}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              )),
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
                            child: Icon(
                              Icons.circle,
                              color: Colors.grey,
                              size: MediaQuery.of(context).size.width * 0.01,
                            ),
                          )),
                          TextSpan(
                              text:
                                  // "",
                                  _distanceLoad == false
                                      ? "..."
                                      : "${getDistanceResponse.data["rows"][0]["elements"][0]["duration"]["text"]}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              )),
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
                            child: Icon(
                              Icons.circle,
                              color: Colors.grey,
                              size: MediaQuery.of(context).size.width * 0.01,
                            ),
                          )),
                          TextSpan(
                              text: "${widget.resturentData.offerprice}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ))
                        ]))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          widget.resturentData.discount == ""
              ? SizedBox()
              : Positioned(
                  top: MediaQuery.of(context).size.height * 0.13,
                  //bottom: MediaQuery.of(context).size.width * 0.0,
                  left: MediaQuery.of(context).size.width / 15,
                  right: MediaQuery.of(context).size.width / 1.57,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width * 0.02))),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04,
                        top: MediaQuery.of(context).size.width * 0.02,
                        bottom: MediaQuery.of(context).size.width * 0.02),
                    child: Text(
                      "${widget.resturentData.discount} off",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
        ],
      ),
    );
    // FutureBuilder(
    //     initialData: null,
    //     future: _distance,
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasData) {
    //         var distance = snapshot.data.rows.elements;
    //         print("distance in resturent..." + distance.toString());
    //         return ResturentList(
    //             resturentData: widget.resturentData,
    //             coverImage: widget.coverimgpath,
    //             getDistane: distance);
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     });
  }

  _getDistance(String lat, String lng) async {
    print("distanceload..." + _distanceLoad.toString());
    try {
      var params = "?";
      params += "origin_lat=" + lat + "&origin_lng=" + lng;
      params += "&destination_lat=" +
          widget.latitude +
          "&destination_lng=" +
          widget.longitude;
      var url = Const.distanceApi + params;
      print("url..." + url.toString());
      getDistanceResponse = await dio.get(url);
      print(
          "response statusCode..." + getDistanceResponse.statusCode.toString());
      print("response data...in getDistance..." +
          getDistanceResponse.data.toString());
      print("hjhj..." +
          getDistanceResponse.data["rows"][0]["elements"][0]["distance"]["text"]
              .toString());
      setState(() {
        _distanceLoad = true;
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
