import 'package:bazimat/login/Login.dart';
import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/popular%20cuisin/PopularCuisinResturentModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopularCuisinList extends StatefulWidget {
  RestaurantsCuisin cuisinList;
  var image, latitude, longitude;
  PopularCuisinList(
      {this.cuisinList, this.image, this.latitude, this.longitude, Key key})
      : super(key: key);

  @override
  _PopularCuisinListState createState() => _PopularCuisinListState();
}

class _PopularCuisinListState extends State<PopularCuisinList> {
  var dio = Dio();
  bool _distanceLoad;
  var distanceResponse, token;
  @override
  void initState() {
    super.initState();
    _distanceLoad = false;
    _getDistance();
  }

  @override
  Widget build(BuildContext context) {
    var imagePath = widget.image + widget.cuisinList.coverPhoto;
    print("imagePath..." + imagePath.toString());
    return InkWell(
      onTap: () {
        if (token == null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogIn()));
        } else {
          _distanceLoad == false
              ? showCustomToast("wait a few seconds")
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CuisinDetails(
                          cuisinList: widget.cuisinList,
                          resturentLat: widget.cuisinList.latitude,
                          resturentLng: widget.cuisinList.longitude,
                          distance: distanceResponse.data["rows"][0]["elements"]
                              [0]["distance"]["text"],
                          duration: distanceResponse.data["rows"][0]["elements"]
                              [0]["duration"]["text"],
                          section: "cuisin")));
        }
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 20.0, left: 8.0, right: 8.0),
            child: Container(
              //height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.12), blurRadius: 6.0)
                  ],
                  //border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.02))),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                MediaQuery.of(context).size.width * 0.02),
                            bottomLeft: Radius.circular(
                                MediaQuery.of(context).size.width * 0.02)),
                        color: Colors.grey[300],
                        image: DecorationImage(
                            image: NetworkImage(imagePath), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cuisinList.name.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "${widget.cuisinList.description}",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          //color: Colors.red,
                          child: RichText(
                              text: TextSpan(children: [
                            WidgetSpan(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 3.0, bottom: 3.0, right: 2.5),
                              child: Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width * 0.03,
                              ),
                            )),
                            TextSpan(
                                text: '${widget.cuisinList.avgRating}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03)),
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
                                text: _distanceLoad == false
                                    ? "..."
                                    : '${distanceResponse.data["rows"][0]["elements"][0]["distance"]["text"]} (${distanceResponse.data["rows"][0]["elements"][0]["duration"]["text"]} )',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03)),
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
                                text: '${widget.cuisinList.offerprice}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03)),
                          ])),
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.width * 0.02,
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          widget.cuisinList.discount == ""
              ? SizedBox()
              : Positioned(
                  top: MediaQuery.of(context).size.width * 0.29,
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width / 1.5,
                  bottom: MediaQuery.of(context).size.width * 0.03,
                  child: Container(
                    //height: MediaQuery.of(context).size.width * 0.2,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(
                            MediaQuery.of(context).size.width * 0.02))),
                    child: Text(
                      "${widget.cuisinList.discount} off",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
        ],
      ),
    );
  }

  void _getDistance() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString("token");
      print("Token... in top.." + token.toString());
      var params = "?";
      params += "origin_lat=" +
          widget.cuisinList.latitude +
          "&origin_lng=" +
          widget.cuisinList.longitude;
      params += "&destination_lat=" +
          widget.latitude +
          "&destination_lng=" +
          widget.longitude;
      print("PArams..." + params.toString());
      var url = Const.distanceApi + params;
      print("Url in params..." + url.toString());
      distanceResponse = await dio.get(url);
      print("response body..." + distanceResponse.statusCode.toString());
      print("response body in popular..." + distanceResponse.data.toString());
      setState(() {
        _distanceLoad = true;
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
