import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/sub%20list/SubListModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SubListItem extends StatefulWidget {
  RestaurantsSub listData;
  var listImageUrl, latitude, longitude;
  SubListItem(
      {this.listData,
      this.listImageUrl,
      this.latitude,
      this.longitude,
      Key key})
      : super(key: key);

  @override
  _SubListItemState createState() => _SubListItemState();
}

class _SubListItemState extends State<SubListItem> {
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
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var imageUrl = widget.listImageUrl + widget.listData.coverPhoto;
    print("imageUrl..." + imageUrl.toString());
    return InkWell(
      onTap: () {
        _distanceLoad == false
            ? showCustomToast("wait a few seconds")
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CuisinDetails(
                        listData: widget.listData,
                        resturentLat: widget.listData.latitude,
                        resturentLng: widget.listData.longitude,
                        distance: getDistanceResponse.data["rows"][0]
                            ["elements"][0]["distance"]["text"],
                        duration: getDistanceResponse.data["rows"][0]
                            ["elements"][0]["duration"]["text"],
                        section: "list")));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.02)),
              color: Colors.white,
              border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.height * 0.16,
                decoration: BoxDecoration(
                    //color: Colors.red,
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.contain)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.listData.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        //color: Colors.red,
                        child: Text("${widget.listData.address}")),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: _distanceLoad == false
                              ? "..."
                              : "${getDistanceResponse.data["rows"][0]["elements"][0]["distance"]["text"]}",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.030,
                              color: Colors.black)),
                      WidgetSpan(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 4.0, right: 4.0),
                        child: Icon(
                          Icons.circle,
                          size: MediaQuery.of(context).size.width * 0.01,
                        ),
                      )),
                      TextSpan(
                          text: _distanceLoad == false
                              ? "..."
                              : "${getDistanceResponse.data["rows"][0]["elements"][0]["duration"]["text"]}",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.030,
                              color: Colors.black))
                    ])),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      "Opening Time: ${widget.listData.availableTimeStarts}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      "Closing Time: ${widget.listData.availableTimeEnds}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.03),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    widget.listData.discount.length == 0
                        ? SizedBox()
                        : Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.04,
                                width: MediaQuery.of(context).size.width / 20,
                                decoration: BoxDecoration(
                                    //color: Colors.red,
                                    image: DecorationImage(
                                        image:
                                            AssetImage("images/discount.png"))),
                              ),
                              Text(
                                "${widget.listData.discount} off on delivery"
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              )
                            ],
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
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
                    //       "200 items available",
                    //       style: TextStyle(
                    //           fontSize:
                    //               MediaQuery.of(context).size.width * 0.03),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDistance() async {
    try {
      var params = "?";
      params += "origin_lat=" +
          widget.listData.latitude +
          "&origin_lng=" +
          widget.listData.longitude;
      params += "&destination_lat=" +
          widget.latitude +
          "&destination_lng=" +
          widget.longitude;
      var url = Const.distanceApi + params;
      print("Url..." + url.toString());
      getDistanceResponse = await dio.get(url);
      print("distance..." + getDistanceResponse.data.toString());
      setState(() {
        _distanceLoad = true;
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
