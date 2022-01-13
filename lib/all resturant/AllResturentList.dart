import 'package:bazimat/home/CampaignDetailsModel.dart';
import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bazimat/home/ResturentModel.dart';

class AllResturentList extends StatefulWidget {
  Restaurants resturent;
  CampaignDetailsRestaurants resturent1;
  var coverImage, latitude, longitude;
  var section;
  Function() couponList;
  AllResturentList(
      {this.resturent,
      this.resturent1,
      this.coverImage,
      this.latitude,
      this.longitude,
      this.section,
      this.couponList,
      Key key});

  @override
  _AllResturentListState createState() => _AllResturentListState();
}

class _AllResturentListState extends State<AllResturentList> {
  var dio = Dio();
  bool _distanceLoad;
  var getDistanceResponse;
  var destinationLat, destinationLng;
  @override
  void initState() {
    super.initState();
    _distanceLoad = false;
    _getDistance();
  }

  @override
  Widget build(BuildContext context) {
    print("Image..." + widget.section.toString());
    var photoName = widget.section == "campaign"
        ? widget.resturent1.coverPhoto
        : widget.resturent.coverPhoto;
    var image = widget.coverImage + photoName;
    print("Image..." + image.toString());
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CuisinDetails(
                    resturentData:
                        widget.section == "campaign" ? null : widget.resturent,
                    campaignData:
                        widget.section == "campaign" ? widget.resturent1 : null,
                    distance: getDistanceResponse.data["rows"][0]["elements"][0]
                        ["distance"]["text"],
                    duration: getDistanceResponse.data["rows"][0]["elements"][0]
                        ["duration"]["text"],
                    resturentLat: destinationLat,
                    resturentLng: destinationLng,
                    section: widget.section,
                    couponList: widget.couponList)));
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
                          widget.section == "campaign"
                              ? "${widget.resturent1.name}"
                              : "${widget.resturent.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          widget.section == "campaign"
                              ? "${widget.resturent1.description}"
                              : "${widget.resturent.description}",
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
                                widget.section == "campaign"
                                    ? "${widget.resturent1.address}"
                                    : "${widget.resturent.address}",
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
                              text: widget.section == "campaign"
                                  ? "${widget.resturent1.avgRating}"
                                  : "${widget.resturent.avgRating}",
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
                              text: _distanceLoad == false
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
                              text: widget.section == "campaign"
                                  ? "${widget.resturent1.offerprice}"
                                  : "${widget.resturent.offerprice}",
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
          // widget.section == "campaign"
          //     ? widget.resturent1.discount == ""
          //     :
          (widget.section == "campaign"
                  ? widget.resturent1.discount == ""
                  : widget.resturent.discount == "")
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
                      widget.section == "campaign"
                          ? "${widget.resturent1.discount} off"
                          : "${widget.resturent.discount} off",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
        ],
      ),
    );
  }

  _getDistance() async {
    print("distanceload..." + _distanceLoad.toString());
    print("distanceload..." + widget.section.toString());

    try {
      destinationLat = widget.section == "campaign"
          ? widget.resturent1.latitude
          : widget.resturent.latitude;
      destinationLng = widget.section == "campaign"
          ? widget.resturent1.longitude
          : widget.resturent.longitude;
      var params = "?";
      params +=
          "origin_lat=" + destinationLat + "&origin_lng=" + destinationLng;
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
