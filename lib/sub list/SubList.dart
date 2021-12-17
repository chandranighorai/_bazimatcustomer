import 'package:bazimat/sub%20list/SubListModel.dart';
import 'package:bazimat/sub%20list/subListItem.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SubList extends StatefulWidget {
  var listId, listName;
  SubList({this.listId, this.listName, Key key}) : super(key: key);

  @override
  _SubListState createState() => _SubListState();
}

class _SubListState extends State<SubList> {
  Future<SubListModel> _allSubList;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _allSubList = _getAllSubList();
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
        child: FutureBuilder(
            initialData: null,
            future: _allSubList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var respData = snapshot.data.errors;
                var imageUrl = snapshot.data.categoryimgpath;
                return respData.length == 0
                    ? Center(
                        child: Text("No Items Available Now"),
                      )
                    : ListView.builder(
                        itemCount: respData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SubListItem(
                              listData: respData[index],
                              listImageUrl: imageUrl);
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
    try {
      var url = Const.subCategory + widget.listId.toString();
      var response = await dio.get(url);
      print("response data..." + response.data.toString());
      if (response.data["state"] == 0) {
        return SubListModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
