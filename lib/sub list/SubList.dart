import 'package:bazimat/sub%20list/SubListModel.dart';
import 'package:bazimat/sub%20list/subListItem.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SubList extends StatefulWidget {
  var listId, listName, zoneId, latitude, longitude;
  SubList(
      {this.listId,
      this.listName,
      this.zoneId,
      this.latitude,
      this.longitude,
      Key key})
      : super(key: key);

  @override
  _SubListState createState() => _SubListState();
}

class _SubListState extends State<SubList> {
  Future<SubListModel> _allSubList;
  var dio = Dio();
  bool _pageLoad;
  var message;
  @override
  void initState() {
    super.initState();
    _allSubList = _getAllSubList();
    _pageLoad = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.listName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: _pageLoad == true
            ? Center(child: Text(message))
            : FutureBuilder(
                initialData: null,
                future: _allSubList,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print("State..." + snapshot.hasData.toString());
                  if (snapshot.hasData) {
                    var respData = snapshot.data.errors.restaurants;
                    var imageUrl = snapshot.data.coverimgpath;
                    return
                        // state == 1
                        //     ? Center(
                        //         child: Text("${snapshot.data.errors}"),
                        //       )
                        //     :
                        ListView.builder(
                            itemCount: respData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SubListItem(
                                  listData: respData[index],
                                  listImageUrl: imageUrl,
                                  latitude: widget.latitude,
                                  longitude: widget.longitude);
                            });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
      ),
    );
  }

  Future<SubListModel> _getAllSubList() async {
    print("ListId..." + widget.listId.toString());
    print("ZoneId..." + widget.zoneId.toString());
    try {
      var url = Const.subCatList + "?catid=" + widget.listId.toString();
      print("subCatUrl..." + url.toString());
      var response = await dio.post(url,
          options: Options(headers: {"zoneId": widget.zoneId}));
      print(
          "response statusCode...cat List..." + response.statusCode.toString());
      //print("response data...cat List..." + response.data['state'].toString());
      print("response data...cat List..." + response.data.toString());
      if (response.data["state"] == 0) {
        return SubListModel.fromJson(response.data);
      } else {
        print(
            "response data...cat List..." + response.data['errors'].toString());
        setState(() {
          _pageLoad = true;
          message = response.data["errors"].toString();
        });
        //showCustomToast(response.data["errors"].toString());
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
