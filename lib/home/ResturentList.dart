import 'package:bazimat/home/GetDistance.dart';
import 'package:bazimat/home/ResturentModel.dart';
import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class ResturentList extends StatefulWidget {
  Restaurants resturentData;
  var coverImage;
  Elements getDistane;
  ResturentList(
      {this.resturentData, this.coverImage, this.getDistane, Key key});

  @override
  _ResturentListState createState() => _ResturentListState();
}

class _ResturentListState extends State<ResturentList> {
  @override
  Widget build(BuildContext context) {
    var image = widget.coverImage + widget.resturentData.coverPhoto;
    print("distanceList..." + widget.getDistane.toString());
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CuisinDetails(
                    resturentData: widget.resturentData,
                    resturentLat: widget.resturentData.latitude,
                    resturentLng: widget.resturentData.longitude)));
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
                                "2.2 kms",
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
                              text: "42 mins",
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
                              text: "\u20B9300 for two",
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
          widget.resturentData.discount == null
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
                      "60% off",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
        ],
      ),
    );
  }
}
