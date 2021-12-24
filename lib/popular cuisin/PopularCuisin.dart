import 'package:bazimat/popular%20cuisin/PopularCuisinList.dart';
import 'package:bazimat/popular%20cuisin/PopularCuisinResturentModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PopularCuisin extends StatefulWidget {
  var name, id, zoneId;
  PopularCuisin({this.name, this.id, this.zoneId, Key key}) : super(key: key);

  @override
  _PopularCuisinState createState() => _PopularCuisinState();
}

class _PopularCuisinState extends State<PopularCuisin> {
  var cuisin = [
    {"pic": "images/pizza.jpg", "name": "Gusto Pizza"},
    {"pic": "images/pizza.jpg", "name": "Domino's Pizza"},
    {"pic": "images/pizza.jpg", "name": "Oven Story Fries"},
    {"pic": "images/pizza.jpg", "name": "Pizza Hut"},
    {"pic": "images/pizza.jpg", "name": "La Pino's Pizza"},
    {"pic": "images/pizza.jpg", "name": "Indus Fries"}
  ];
  Future<PopularCuisinResturentModel> _resturentList;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _resturentList = _getAllResturentList();
  }

  @override
  Widget build(BuildContext context) {
    print("id..." + widget.id.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200],
        child: FutureBuilder(
          initialData: null,
          future: _resturentList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var resturentList = snapshot.data.errors.restaurants;
              var imagePath = snapshot.data.coverimgpath;
              return ListView.builder(
                  itemCount: resturentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PopularCuisinList(
                        cuisinList: resturentList[index], image: imagePath);
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<PopularCuisinResturentModel> _getAllResturentList() async {
    try {
      var params = "?catid=" + widget.id.toString();
      var url = Const.popularCuisinResturentList + params;
      var response = await dio.post(url,
          options: Options(headers: {"zoneId": widget.zoneId}));
      print("response body in resturentList..." + response.data.toString());
      if (response.data["state"] == 0) {
        return PopularCuisinResturentModel.fromJson(response.data);
      } else {
        showCustomToast(response.data["errors"][0]["message"].toString());
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
