import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkAddress extends StatefulWidget {
  var workAddr;
  Function(String addr, String addrType, String lat, String lng) refresh;
  WorkAddress({this.workAddr, this.refresh, Key key}) : super(key: key);

  @override
  _WorkAddressState createState() => _WorkAddressState();
}

class _WorkAddressState extends State<WorkAddress> {
  @override
  Widget build(BuildContext context) {
    print("workAddr..." + widget.workAddr.toString());
    return InkWell(
      onTap: () {
        print("workAddr..." + widget.workAddr["address"].toString());
        print("workAddr..." + widget.workAddr["latitude"].toString());
        print("workAddr..." + widget.workAddr["longitude"].toString());
        _serviceAvailability(
            widget.workAddr["latitude"], widget.workAddr["longitude"]);
        Navigator.pop(context);
        widget.refresh(
            widget.workAddr["address"],
            widget.workAddr["address_type"],
            widget.workAddr["latitude"],
            widget.workAddr["longitude"]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //height: MediaQuery.of(context).size.width * 0.06,
          width: MediaQuery.of(context).size.width,
          //color: Colors.pink,
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.04,
                width: MediaQuery.of(context).size.width / 15,
                //color: Colors.blue,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("images/house.png"))),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                //color: Colors.amber,
                child: Text(
                  "${widget.workAddr["address"]}",
                  maxLines: 3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _serviceAvailability(lat, lng) async {
    var dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    print("Lat..." + lat.toString());
    print("Lat..." + lng.toString());
    try {
      var params =
          "?latitude=" + lat.toString() + "&longitude=" + lng.toString();
      var url = Const.addrServiceable + params;
      var response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response in home..." + response.data.toString());
      if (response.data["state"] == 0) {
        Navigator.pop(context);
        widget.refresh(
            widget.workAddr["address"],
            widget.workAddr["address_type"],
            widget.workAddr["latitude"],
            widget.workAddr["longitude"]);
      } else {
        showCustomToast(response.data["message"]);
      }
    } on DioError catch (e) {}
  }
}
