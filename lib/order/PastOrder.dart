import 'package:bazimat/order/PastOrderList.dart';
import 'package:bazimat/order/pastOrderModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PastOrder extends StatefulWidget {
  const PastOrder({Key key}) : super(key: key);

  @override
  _PastOrderState createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrder> {
  Future<PostOrderModel> _pastOrder;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _pastOrder = _getAllOder();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        initialData: null,
        future: _getAllOder(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("snapData..." + snapshot.hasData.toString());
          if (snapshot.hasData) {
            var errorData = snapshot.data.errors;
            return ListView.builder(
                itemCount: errorData.length,
                itemBuilder: (BuildContext context, int index) {
                  return PastOrderList(listData: errorData[index]);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        //child: ,
      ),
    );
  }

  Future<PostOrderModel> _getAllOder() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      var response = await dio.get(Const.pastOrder,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response body..." + response.statusCode.toString());
      print("response body..." + response.data.toString());
      if (response.data["state"] == 0) {
        var data = response.data["errors"];
        print("response body..." + data.toString());
        return PostOrderModel.fromJson(response.data);
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
