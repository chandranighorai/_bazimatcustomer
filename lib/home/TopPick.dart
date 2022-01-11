import 'package:bazimat/home/PopularResturentModel.dart';
import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TopPicks extends StatefulWidget {
  PopularResturentErrors topArr;
  var imgPath, latitude, longitude;
  TopPicks({this.topArr, this.imgPath, this.latitude, this.longitude, Key key})
      : super(key: key);

  @override
  _TopPicksState createState() => _TopPicksState();
}

class _TopPicksState extends State<TopPicks> {
  var dio = Dio();
  var distanceData;
  bool _distanceLoad = false;
  @override
  void initState() {
    super.initState();
    _getDistance();
  }

  @override
  Widget build(BuildContext context) {
    var image = widget.imgPath + widget.topArr.coverPhoto;
    print("top cuisin..." + widget.topArr.latitude.toString());
    return InkWell(
      onTap: () {
        print("top cuisin..." + widget.topArr.latitude.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CuisinDetails(
                    topPickList: widget.topArr,
                    resturentLat: widget.topArr.latitude.toString(),
                    resturentLng: widget.topArr.longitude.toString(),
                    distance: distanceData.data["rows"][0]["elements"][0]
                        ["distance"]["text"],
                    duration: distanceData.data["rows"][0]["elements"][0]
                        ["duration"]["text"],
                    section: "topPicks")));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width / 3.5,
          //color: Colors.red,
          //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          alignment: Alignment.center,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                //width: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.width * 0.02)),
                    image: DecorationImage(
                        image: NetworkImage(image.toString()),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                widget.topArr.name.toString(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                _distanceLoad == false
                    ? "..."
                    : distanceData.data["rows"][0]["elements"][0]["duration"]
                        ["text"],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                // maxLines: 2,
                // overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }

  _getDistance() async {
    try {
      var params = "?";
      params +=
          "origin_lat=" + widget.latitude + "&origin_lng=" + widget.longitude;
      params += "&destination_lat=" +
          widget.topArr.latitude +
          "&destination_lng=" +
          widget.topArr.longitude;
      var url = Const.distanceApi + params;
      distanceData = await dio.get(url);
      print("DistanceData..." + distanceData.data.toString());
      setState(() {
        _distanceLoad = true;
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
