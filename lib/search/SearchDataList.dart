import 'package:bazimat/search/SerachModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchDataList extends StatefulWidget {
  var imageUrl, cartdata;
  Products dataList;
  String resturentId, userId, token;
  SearchDataList(
      {this.imageUrl,
      this.cartdata,
      this.dataList,
      this.resturentId,
      this.userId,
      this.token,
      Key key})
      : super(key: key);

  @override
  _SearchDAtaListState createState() => _SearchDAtaListState();
}

class _SearchDAtaListState extends State<SearchDataList> {
  var imageData;
  int itemCount;
  bool _addEnable;
  bool _sectionLoad;
  var data = [];
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    //itemCount = 0;
    _addEnable = false;
    // _sectionLoad = false;
    //_getItemList();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("CartDAta..." + widget.cartdata.toString());
    imageData = widget.imageUrl + widget.dataList.image;
    _getItemList();
    return _sectionLoad == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(imageData), fit: BoxFit.fill)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.dataList.name),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      Text("\u20B9" + widget.dataList.price.toString()),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      //data.length == 0
                      _addEnable == false
                          ? InkWell(
                              onTap: () {
                                _addToCArt(
                                    widget.dataList,
                                    widget.resturentId.toString(),
                                    widget.userId.toString());
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                      right: MediaQuery.of(context).size.width *
                                          0.02,
                                      top: MediaQuery.of(context).size.width *
                                          0.02,
                                      bottom: MediaQuery.of(context).size.width *
                                          0.02),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MediaQuery.of(context).size.width *
                                                  0.02))),
                                  child: Text("ADD")),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.width / 12,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.02))),
                              child: Row(
                                children: [
                                  Container(
                                      //color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          13,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              itemCount = itemCount + 1;
                                            });
                                            itemAdd(widget.dataList, itemCount);
                                          },
                                          child: Text("+"))),
                                  Text(itemCount.toString()),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 13,
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            itemCount = itemCount - 1;
                                          });
                                          print("itemcount..." +
                                              itemCount.toString());
                                          if (itemCount < 1) {
                                            itemDelete(widget.dataList);
                                          } else {
                                            itemAdd(widget.dataList, itemCount);
                                          }
                                        },
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
  }

  _getItemList() {
    //print("cartData...in getItem..." + widget.cartdata.length.toString());
    if (widget.cartdata.toString() == "null") {
      setState(() {
        _addEnable = false;
      });
    } else {
      data = widget.cartdata
          .where((e) => e["food_name"] == widget.dataList.name)
          .toList();
      print("_addEnable...data length..." + data.length.toString());
      print("_addEnable...data length..." + data.toString());
      if (data.length == 0) {
        _addEnable = false;
        _sectionLoad = true;
        print("_addEnable..." + _addEnable.toString());
        print("_addEnable..." + _sectionLoad.toString());
      } else {
        _addEnable = true;
        itemCount = int.parse(data[0]['quantity'].toString());
        _sectionLoad = true;
      }
    }
  }

  _addToCArt(Products dataList, String resturentId, String userId) async {
    //print("addCArt..." + widget.cartdata.length.toString());
    if (widget.cartdata == null) {
      setState(() {
        widget.cartdata = [];
      });
    }
    try {
      var params = "?user_id=" +
          userId +
          "&food_id=" +
          widget.dataList.id.toString() +
          "&food_amount=" +
          widget.dataList.price.toString() +
          "&quantity=1" +
          "&restaurant_id=" +
          resturentId +
          "&tax=" +
          widget.dataList.tax.toString();
      var token = widget.token.toString();
      print("Params..." + params.toString());
      var url = Const.addToCart + params;
      print("url... to add toCart..." + url.toString());
      print("url... to add toCart..." + widget.token.toString());
      var cartData = await dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response body..." + cartData.statusCode.toString());
      print("response body..." + cartData.data.toString());
      if (cartData.data["state"] == 0) {
        showCustomToast(cartData.data["message"]);
        setState(() {
          widget.cartdata.add({
            "cart_id": cartData.data["respData"]["cart_id"].toString(),
            "user_id": cartData.data["respData"]["user_id"].toString(),
            "restaurant_id":
                cartData.data["respData"]["restaurant_id"].toString(),
            "food_id": cartData.data["respData"]["food_id"].toString(),
            "food_name": widget.dataList.name.toString(),
            "food_image": imageData,
            "quantity": "1",
            "food_amount": cartData.data["respData"]["food_amount"].toString(),
            "is_odered": "0",
            "added_dtime": cartData.data["respData"]["added_dtime"].toString()
          });
          _addEnable = true;
          itemCount = 1;
        });
        print("_addEnable..." + _addEnable.toString());
        print("_addEnable..." + widget.cartdata.toString());
      } else {
        showCustomToast(cartData.data["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  itemAdd(Products dataList, int itemcount) async {
    print("itemCount..." + dataList.name.toString());
    print("ItemCount..." + itemcount.toString());
    var data =
        widget.cartdata.where((e) => e["food_name"] == dataList.name).toList();
    print("ItemCount.." + data.toString());
    var params = "?cart_id=" +
        data[0]["cart_id"].toString() +
        "&quantity=" +
        itemCount.toString();
    var url = Const.updateCart + params;
    setState(() {
      data[0]["quantity"] = itemCount.toString();
    });
    var updateResponse = await dio.post(url,
        options: Options(headers: {"Authorization": "Bearer ${widget.token}"}));
    print("updateResponse..." + updateResponse.data.toString());
  }

  itemDelete(Products dataList) async {
    try {
      print("item Delete...");
      print("item Delete..." + widget.cartdata.toString());
      // print("item Delete..." +
      //     widget.cartdata[widget.cartdata.length - 1].toString());
      // print("item Delete..." +
      //     widget.cartdata[widget.cartdata.length - 1]["cart_id"].toString());
      if (widget.cartdata == null) {
        // setState(() {
        //   _addEnable = false;
        // });
      } else {
        var data = widget.cartdata
            .where((e) => e["food_name"] == dataList.name)
            .toList();
        print("data delete..." + data.toString());
        //}
        var params = "?cart_id=" + data[0]["cart_id"].toString();
        var url = Const.deleteCart + params;
        print("Url.. " + url.toString());

        var response = await dio.post(url,
            options:
                Options(headers: {"Authorization": "Bearer ${widget.token}"}));
        print("remove data..." + response.data.toString());
        if (response.data["state"] == 0) {
          showCustomToast(response.data["message"]);
          setState(() {
            _addEnable = false;
          });
        } else {
          showCustomToast(response.data["message"]);
        }
      }
      // widget.cartdata =
      //     widget.cartdata.removeWhere((e) => e["food_name"] == dataList.name);
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
