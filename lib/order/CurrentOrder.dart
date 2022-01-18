import 'dart:async';

import 'package:bazimat/order/CurrentOrderModel.dart';
import 'package:bazimat/order/CurrentOrderlist.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentOrder extends StatefulWidget {
  const CurrentOrder({Key key}) : super(key: key);

  @override
  _CurrentOrderState createState() => _CurrentOrderState();
}

class _CurrentOrderState extends State<CurrentOrder> {
  Future<CurrentOrderModel> _getOrder;
  Timer timer;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _getOrder = _currentOrder();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _getOrder = _currentOrder();
      });
    });
    return Container(
      child: FutureBuilder(
        initialData: null,
        future: _currentOrder(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("snapshotdata.." + snapshot.hasData.toString());
          if (snapshot.hasData) {
            var data = snapshot.data;
            print("data..." + data.accepted.length.toString());
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return CurrentOrderList(orderData: data);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<CurrentOrderModel> _currentOrder() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var orderId = pref.getString("OrderId");
      var token = pref.getString("token");
      print("OrderId..." + orderId.toString());
      var param = "?order_id=" + orderId;
      var url = Const.currentOrder + param;
      print("OrderId..." + url.toString());
      var response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response body in current Order..." + response.data.toString());
      return CurrentOrderModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
