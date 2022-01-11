import 'package:bazimat/favourites/FavouriteModel.dart';
import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FavouriteList extends StatefulWidget {
  FavRestaurant favouriteData;
  var imageUrl, latitude, longitude;
  FavouriteList(
      {this.favouriteData,
      this.imageUrl,
      this.latitude,
      this.longitude,
      Key key})
      : super(key: key);

  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  var dio = Dio();
  bool _distanceLoad;
  var getDistanceResponse;
  @override
  void initState() {
    super.initState();
    _distanceLoad = false;
    _getDistance();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var image = widget.imageUrl + widget.favouriteData.coverPhoto;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CuisinDetails(
                    favResturentData: widget.favouriteData,
                    resturentLat: widget.favouriteData.latitude,
                    resturentLng: widget.favouriteData.longitude,
                    distance: getDistanceResponse.data["rows"][0]["elements"][0]
                        ["distance"]["text"],
                    duration: getDistanceResponse.data["rows"][0]["elements"][0]
                        ["duration"]["text"],
                    section: "favourite")));
      },
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, left: 8.0, right: 8.0, bottom: 12.0),
          child: Container(
            //height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width,
            //color: Colors.amber,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.favouriteData.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.045),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        "${widget.favouriteData.description}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        "${widget.favouriteData.address} | ${widget.favouriteData.offerprice}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      RichText(
                          softWrap: true,
                          text: TextSpan(children: [
                            WidgetSpan(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3.0, bottom: 3.0, right: 3.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width * 0.03,
                              ),
                            )),
                            TextSpan(
                                text: '${widget.favouriteData.avgRating}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035)),
                            WidgetSpan(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 5.0, right: 4.0, left: 4.0),
                              child: Icon(
                                Icons.circle,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width * 0.015,
                              ),
                            )),
                            TextSpan(
                                text: _distanceLoad == false
                                    ? '...'
                                    : '${getDistanceResponse.data["rows"][0]["elements"][0]["duration"]["text"]}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035)),
                            WidgetSpan(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 5.0, right: 4.0, left: 4.0),
                              child: Icon(
                                Icons.circle,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width * 0.015,
                              ),
                            )),
                            TextSpan(
                                text: _distanceLoad == false
                                    ? '...'
                                    : '${getDistanceResponse.data["rows"][0]["elements"][0]["distance"]["text"]}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035)),
                          ])),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.03,
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: MediaQuery.of(context).size.width * 0.04,
                      //       width: MediaQuery.of(context).size.width / 20,
                      //       decoration: BoxDecoration(
                      //           //color: Colors.red,
                      //           image: DecorationImage(
                      //               image: AssetImage("images/discount.png"))),
                      //     ),
                      //     Text(
                      //       " 60% off upto \u20B9125",
                      //       style: TextStyle(
                      //           color: Colors.grey,
                      //           fontSize:
                      //               MediaQuery.of(context).size.width * 0.03),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.width * 0.01,
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        widget.favouriteData.discount == ""
            ? SizedBox()
            : Positioned(
                top: MediaQuery.of(context).size.width * 0.29,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.68,
                bottom: MediaQuery.of(context).size.height * 0.00,
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width * 0.02,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(
                          MediaQuery.of(context).size.width * 0.01))),
                  child: Text(
                    "${widget.favouriteData.discount} off".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
      ]),
    );
  }

  _getDistance() async {
    try {
      var params = "?";
      params +=
          "origin_lat=" + widget.latitude + "&origin_lng=" + widget.longitude;
      params += "&destination_lat=" +
          widget.favouriteData.latitude +
          "&destination_lng=" +
          widget.favouriteData.longitude;
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
