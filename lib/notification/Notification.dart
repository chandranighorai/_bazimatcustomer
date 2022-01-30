import 'package:bazimat/notification/NotificationList.dart';
import 'package:bazimat/notification/NotificationModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key key, list}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  var dio = Dio();
  Future<NotificationModel> _allNotificationList;
  @override
  void initState() {
    super.initState();
    _allNotificationList = _getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          initialData: null,
          future: _getNotificationList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var dataList = snapshot.data.notificationData;
              print("dataList..." + dataList.toString());
              return dataList.length == 0
                  ? Center(child: Text("No Notification yet"))
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AllNotificationList(list: dataList[index]);
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

  Future<NotificationModel> _getNotificationList() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userId = pref.getString("id");
      var token = pref.getString("token");
      print("token..." + userId.toString());
      print("token..." + token.toString());
      var param = "?user_id=" + userId.toString();
      var url = Const.notificationList + param;
      print("Url..." + url.toString());
      var response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response data..." + response.data.toString());
      if (response.data["state"] == 0) {
        return NotificationModel.fromJson(response.data);
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
