import 'package:bazimat/home/GetDistance.dart';
import 'package:bazimat/popular%20cuisin/PopularCuisin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CuisinList extends StatefulWidget {
  var cuisin, cuisinPath, latitude, longitude, zoneId;
  CuisinList(
      {this.cuisin,
      this.cuisinPath,
      this.latitude,
      this.longitude,
      this.zoneId,
      Key key})
      : super(key: key);

  @override
  _CuisinListState createState() => _CuisinListState();
}

class _CuisinListState extends State<CuisinList> {
  @override
  void initState() {
    super.initState();
    //_getDistance();
  }

  @override
  Widget build(BuildContext context) {
    print("cuisinList.." + widget.cuisinPath.toString());
    print("cuisinList...+++" + widget.cuisin["image"].toString());
    var image = widget.cuisinPath + widget.cuisin["image"];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PopularCuisin(
                    name: widget.cuisin["name"].toString(),
                    id: widget.cuisin["category_id"],
                    latitude: widget.latitude,
                    longitude: widget.longitude,
                    zoneId: widget.zoneId)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.25,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.contain)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              widget.cuisin["name"].toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // void _getDistance() async {
  //   try {
  //     var params = "?";
  //     params += "origin_lat=" +
  //         widget.latitude +
  //         "&origin_lng=" +
  //         widget.longitude +
  //         "&destination_lat=" +
  //         widget.cuisin["latitude"].toString() +
  //         "&destination_lng=" +
  //         widget.cuisin["longitude"].toString();
  //     print("Params..." + params.toString());
  //   } on DioError catch (e) {
  //     print(e.toString());
  //   }
  // }
}
