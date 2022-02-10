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
  bool _pageLoad;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //cartData = '';
    _pageLoad = false;
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
      // floatingActionButton: cartData.length == 0
      //     ? SizedBox()
      //     : FloatingActionButton(
      //         onPressed: null, child: Icon(Icons.shopping_cart_rounded)),
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
                : Expanded(
                    //height: MediaQuery.of(context).size.height * 0.8,
                    //color: Colors.amber,
                    child: FutureBuilder(
                      initialData: null,
                      future: serchData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        print("SnapShot..." + snapshot.data.toString());
                        if (snapshot.hasData) {
                          var dataList = snapshot.data.errors.products;
                          var imageUrl = snapshot.data.errors.imageUrl;
                          print("DataList..." + dataList.length.toString());
                          return dataList.length == 0
                              ? Center(child: Text("No Items available"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: dataList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print("DataList..." +
                                        dataList[index].name.toString());
                                    print("DataList..." + cartData.toString());
                                    var imageData =
                                        imageUrl + dataList[index].image;
                                    var data = cartData
                                        .where((e) =>
                                            e["food_name"] ==
                                            dataList[index].name)
                                        .toList();
                                    print("Data..." + data.toString());
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                image: DecorationImage(
                                                    image:
                                                        NetworkImage(imageData),
                                                    fit: BoxFit.fill)),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(dataList[index].name),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.02),
                                                Text("\u20B9" +
                                                    dataList[index]
                                                        .price
                                                        .toString()),
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.02),
                                                data.length == 0
                                                    ? Container(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.02,
                                                            right:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    0.02,
                                                            top: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.02,
                                                            bottom:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .width *
                                                                    0.02),
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey
                                                                .withOpacity(0.2),
                                                            borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02))),
                                                        child: Text("ADD"))
                                                    : Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            12,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.02))),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                //color: Colors.blue,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    13,
                                                                child: TextButton(
                                                                    child: Text(
                                                                        "+"))),
                                                            Text(data[0]
                                                                    ["quantity"]
                                                                .toString()),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  13,
                                                              child: TextButton(
                                                                  child: Text(
                                                                "-",
                                                              )),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                    );
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
    serchData = _getSearchData(val.toString());
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
        // setState(() {
        //   _pageLoad = true;
        // });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
