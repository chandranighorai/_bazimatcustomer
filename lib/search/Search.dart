import 'package:bazimat/notification/NotificationModel.dart';
import 'package:bazimat/search/SearchDataList.dart';
import 'package:bazimat/search/SerachModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  var resturentId;
  Search({this.resturentId, Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var dio = Dio();
  var token, zoneId, id, cartData;
  Future<SearchModel> serchData;
  bool _pageLoad, _itemLoad, _addEnable;
  int itemCount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //cartData = '';
    _pageLoad = true;
    _itemLoad = false;
    _addEnable = false;
    itemCount = 0;
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    print("resturentId..." + widget.resturentId.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        // title: Text(
        //   "Search",
        //   style: TextStyle(color: Colors.black),
        // ),
      ),
      // floatingActionButton: _itemLoad == false
      //     ? SizedBox()
      //     : cartData.toString() == "null"
      //         ? SizedBox()
      //         : FloatingActionButton(
      //             onPressed: null, child: Icon(Icons.shopping_cart_rounded)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        //color: Colors.pinkAccent,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.14,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(MediaQuery.of(context).size.width * 0.8)),
                  boxShadow: [BoxShadow(color: Colors.grey)]),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Search...", border: InputBorder.none),
                onChanged: (value) {
                  print("Value..." + value.toString());
                  _getItem(value.toString());
                  //_getSearchData(value.toString());
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            _pageLoad == true
                ? Center(
                    child: Text("Have not search yet"),
                  )
                : _itemLoad == false
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        //height: MediaQuery.of(context).size.height * 0.8,
                        //color: Colors.amber,
                        child: FutureBuilder(
                          initialData: null,
                          future: serchData,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            print("SnapShot..." + snapshot.data.toString());
                            if (snapshot.hasData) {
                              var dataList = snapshot.data.errors.products;
                              var imageUrl = snapshot.data.errors.imageUrl;
                              print("DataList length..." +
                                  dataList.length.toString());
                              return dataList.length == 0
                                  ? Center(child: Text("No Items available"))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: dataList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        print("cartData...datas" +
                                            cartData.toString());
                                        print("cartData...datas..." +
                                            dataList[index].toString());
                                        return SearchDataList(
                                            imageUrl: imageUrl,
                                            cartdata: cartData,
                                            dataList: dataList[index],
                                            resturentId:
                                                widget.resturentId.toString(),
                                            userId: id.toString(),
                                            token:token);
                                        // print("DataList..." +
                                        //     dataList[index].name.toString());
                                        // print("DataList..." + cartData.toString());
                                        // var data = [];
                                        // itemCount = 0;
                                        // var imageData =
                                        //     imageUrl + dataList[index].image;
                                        // if (cartData.toString() == "null") {
                                        // } else {
                                        //   data = cartData
                                        //       .where((e) =>
                                        //           e["food_name"] ==
                                        //           dataList[index].name)
                                        //       .toList();
                                        //   print("Data..." + data.toString());
                                        //   if (data.length == 0) {
                                        //     // setState(() {
                                        //     itemCount = 0;
                                        //     _addEnable = false;
                                        //     // });
                                        //   } else {
                                        //     // setState(() {
                                        //     _addEnable = true;
                                        //     itemCount = int.parse(
                                        //         data[0]["quantity"].toString());
                                        //     // });
                                        //   }
                                        // setState(() {
                                        //   itemCount = int.parse(
                                        //       data[0]["quantity"].toString());
                                        // });
                                        // print("Data..." + itemCount.toString());
                                        // }
                                      });
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      )
          ],
        ),
      ),
    );
  }

  Future<SearchModel> _getSearchData(String val) async {
    try {
      var params = "?restaurant_id=" +
          widget.resturentId.toString() +
          "&name=" +
          val.toString();
      var url = Const.productsearch + params;
      var response = await dio.get(url,
          options: Options(headers: {
            "Authorization": "Bearer $token",
            "zoneId": zoneId.toString()
          }));
      print("response data..." + response.data.toString());
      if (response.data["state"] == 0) {
        setState(() {
          _itemLoad = true;
          _pageLoad = false;
        });
        return SearchModel.fromJson(response.data);
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  void _getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    zoneId = pref.getString("zoneId");
    id = pref.getString("id");
    _getCart();
  }

  _getItem(String val) {
    setState(() {
      serchData = _getSearchData(val.toString());
    });
  }

  _getCart() async {
    try {
      var params = "?user_id=" +
          id.toString() +
          "&restaurant_id=" +
          widget.resturentId.toString();
      var url = Const.getCart + params;
      var response = await dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response data in cart..." + response.data.toString());
      if (response.data["state"] == 1) {
        setState(() {
          _pageLoad = true;
        });
      } else {
        cartData = response.data["respData"];
        print("response data in cart..." + cartData.toString());
        setState(() {
          _pageLoad = true;
        });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  // _addToCArt(Products dataList, String resturentId, String id) async {
  //   print("data in CArt..." + dataList.name.toString());
  //   print("data in CArt..." + resturentId.toString());
  //   print("data in CArt..." + id.toString());
  //   var params = "?user_id=" +
  //       id +
  //       "&food_id=" +
  //       dataList.id.toString() +
  //       "&food_amount=" +
  //       dataList.price.toString() +
  //       "&quantity=1&restaurant_id=" +
  //       resturentId +
  //       "&tax=" +
  //       dataList.tax.toString();
  //   var url = Const.addToCart + params;
  //   var responseCart = await dio.post(url,
  //       options: Options(headers: {"Authorization": "Bearer $token"}));
  //   print("data in CArt..." + responseCart.data.toString());
  //   if (responseCart.data["state"] == 0) {
  //     setState(() {
  //       _addEnable = true;
  //     });
  //     print("adEnb..." + _addEnable.toString());
  //   }
  // }
}
