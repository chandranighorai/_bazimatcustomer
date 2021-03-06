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
  var token, id;
  var state = 0;
  var response;

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
      child: state == 1
          ? Center(
              child: Text(response.data["message"]),
            )
          : FutureBuilder(
              initialData: null,
              future: _getAllOder(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print("snapData..." + snapshot.hasData.toString());
                if (snapshot.hasData) {
                  var errorData = snapshot.data.errors;
                  return ListView.builder(
                      padding: EdgeInsets.all(0),
                      //reverse: true,
                      //shrinkWrap: true,
                      itemCount: errorData.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("listDAta..." + errorData[index].toString());
                        return PastOrderList(
                            listData: errorData[(errorData.length - 1) - index],
                            token: token,
                            userId: id);
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
      token = pref.getString("token");
      id = pref.getString("id");
      print("id..." + id.toString());
      var url = Const.pastOrder + "?id=" + id.toString();
      print("Url..." + url.toString());
      print("Url..." + token.toString());
      response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response body..." + response.statusCode.toString());
      print("response body..." + response.data.toString());
      if (response.data["state"] == 0) {
        var data = response.data["errors"];
        print("response body..." + data.toString());
        return PostOrderModel.fromJson(response.data);
      } else {
        //showCustomToast(response.data["message"]);
      }
      setState(() {
        state = response.data["state"];
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
