import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAddress extends StatefulWidget {
  Function(String addr, String addrType, String lat, String lng) refresh;
  var homeAddr;
  HomeAddress({this.refresh, this.homeAddr, Key key}) : super(key: key);

  @override
  _HomeAddressState createState() => _HomeAddressState();
}

class _HomeAddressState extends State<HomeAddress> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("address..." + widget.homeAddr["address"]);
        print("address..." + widget.homeAddr["latitude"]);
        print("address..." + widget.homeAddr["longitude"]);
        _serviceAvailability(
            widget.homeAddr["latitude"], widget.homeAddr["longitude"]);
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
                child: Text("${widget.homeAddr["address"]}"),
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
            widget.homeAddr["address"],
            widget.homeAddr["address_type"],
            widget.homeAddr["latitude"],
            widget.homeAddr["longitude"]);
      } else {
        showCustomToast(response.data["message"]);
      }
    } on DioError catch (e) {}
  }
}
