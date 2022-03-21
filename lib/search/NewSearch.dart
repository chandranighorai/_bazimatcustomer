import 'package:bazimat/add%20cuisin/AddCuisin.dart';
import 'package:bazimat/search/NewSearchDataList.dart';
import 'package:bazimat/search/SerachModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewSearch extends StatefulWidget {
  var duration,
      distance,
      resturentId,
      resturentName,
      resturenrtAddr,
      resturentLat,
      resturentLng,
      couponList,
      configData;
  NewSearch(
      {this.duration,
      this.distance,
      this.resturentId,
      this.resturentName,
      this.resturenrtAddr,
      this.resturentLat,
      this.resturentLng,
      this.couponList,
      this.configData,
      Key key})
      : super(key: key);
  @override
  _NewSearchState createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {
  var token, zoneId, id, cartData;
  bool _pageLoad, _itemLoad;
  TextEditingController _searchChar;
  Future<SearchModel> serchData;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _pageLoad = true;
    _itemLoad = false;
    _getToken();
    _searchChar = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Cuis))
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _cartNavigate();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //     padding:
              //         EdgeInsets.all(MediaQuery.of(context).size.width * 0.001),
              //     decoration: BoxDecoration(
              //         color: Colors.red,
              //         borderRadius: BorderRadius.all(Radius.circular(
              //             MediaQuery.of(context).size.width * 0.02))),
              //     // child: Text(
              //     //   totalCartItem.toString(),
              //     //   style: TextStyle(fontSize: 12),
              //     // )
              //     ),
              Icon(Icons.shopping_cart_rounded),
            ],
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
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
                controller: _searchChar,
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
                    // child: Text("Have not search yet"),
                    child: Text(""),
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
                                        return NewSearchDataList(
                                            imageUrl: imageUrl,
                                            cartdata: cartData,
                                            dataList: dataList[index],
                                            resturentId:
                                                widget.resturentId.toString(),
                                            userId: id.toString(),
                                            token: token,
                                            totalItem: _cartItem);
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

  _getItem(String serchingData) {
    print("searchData..." + serchingData.toString());
    setState(() {
      serchData = _getSearchData(serchingData.toString());
    });
  }

  _cartItem(
      String val, int itemcount, String foodId, String foodPrice, String tax) {
    print("Val..." + val.toString());
    print("Val..." + itemcount.toString());
    print("Val..." + foodId.toString());
    print("Val..." + foodPrice.toString());
    print("Val..." + tax.toString());
    if (val == "add") {
      _addToCart(foodId, foodPrice, tax);
    } else if (val == "update") {
      _updateCart(itemcount, foodId);
    } else {
      _deleteCart(foodId);
    }
  }

  Future<SearchModel> _getSearchData(String data) async {
    try {
      var params = "?restaurant_id=" +
          widget.resturentId.toString() +
          "&name=" +
          data.toString();
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
        // cartData = response.data["respData"];
        // print("response data in cart..." + cartData.toString());
        //cartData.clear();
        setState(() {
          cartData = response.data["respData"];
          print("response data in cart..." + cartData.toString());
          //serchData = _getSearchData(_searchChar.text.toString());
          _pageLoad = true;
        });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _addToCart(String foodId, String foodPrice, String tax) async {
    try {
      print("id..." + foodId.toString());
      print("id..." + foodPrice.toString());
      print("id..." + tax.toString());

      var params = "?user_id=" +
          id.toString() +
          "&food_id=" +
          foodId.toString() +
          "&food_amount=" +
          foodPrice.toString() +
          "&quantity=1" +
          "&restaurant_id=" +
          widget.resturentId.toString() +
          "&tax=" +
          tax.toString();
      //var token = widget.token.toString();
      print("Params..." + params.toString());
      var url = Const.addToCart + params;
      var responseData = await dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("Params..." + responseData.data.toString());
      if (responseData.data["state"] == 0) {
        showCustomToast(responseData.data["message"]);
        setState(() {
          //_pageLoad = true;
          _itemLoad = false;
          _getCart();
          serchData = _getSearchData(_searchChar.text.toString());
        });
        // setState(() {
        //   widget.cartdata.add({
        //     "cart_id": cartData.data["respData"]["cart_id"].toString(),
        //     "user_id": cartData.data["respData"]["user_id"].toString(),
        //     "restaurant_id":
        //         cartData.data["respData"]["restaurant_id"].toString(),
        //     "food_id": cartData.data["respData"]["food_id"].toString(),
        //     "food_name": widget.dataList.name.toString(),
        //     "food_image": imageData,
        //     "quantity": "1",
        //     "tax": double.parse(cartData.data["respData"]["tax"].toString())
        //         .toString(),
        //     "food_amount": double.parse(
        //             cartData.data["respData"]["food_amount"].toString())
        //         .toString(),
        //     "is_odered": "0",
        //     "added_dtime": cartData.data["respData"]["added_dtime"].toString()
        //   });
        //   _addEnable = true;
        //   itemCount = 1;
        // });
        // print("_addEnable..." + _addEnable.toString());
        // print("_addEnable..." + widget.cartdata.toString());
      } else {
        showCustomToast(responseData.data["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _updateCart(int itemcount, String foodId) async {
    try {
      var data =
          cartData.where((e) => e["food_id"].toString() == foodId).toList();
      print("Data..." + data.toString());
      var params = "?cart_id=" +
          data[0]["cart_id"].toString() +
          "&quantity=" +
          itemcount.toString();
      var url = Const.updateCart + params;
      var updateResponse = await dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("updateResponse..." + updateResponse.data.toString());
      setState(() {
        _itemLoad = false;
        _getCart();
        serchData = _getSearchData(_searchChar.text.toString());
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _deleteCart(String foodId) async {
    try {
      var data =
          cartData.where((e) => e["food_id"].toString() == foodId).toList();
      print("Data..." + data.toString());
      var params = "?cart_id=" + data[0]["cart_id"].toString();
      var url = Const.deleteCart + params;
      print("Url.. " + url.toString());
      var response = await dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("remove data..." + response.data.toString());
      if (response.data["state"] == 0) {
        showCustomToast(response.data["message"]);
        setState(() {
          _itemLoad = false;
          cartData.clear();
          _getCart();
          serchData = _getSearchData(_searchChar.text.toString());
        });
      } else {
        showCustomToast(response.data["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _cartNavigate() {
    print("cardDAta..." + cartData.toString());
    if (cartData.length == 0) {
      showCustomToast("cart is empty");
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddCuisin(
                  duration: widget.duration,
                  distance: widget.distance,
                  resturentLat: widget.resturentLat,
                  resturentLng: widget.resturentLng,
                  productList: cartData,
                  // product: widget.productList,
                  // imageUrl: widget.imageUrl,
                  resturentName: widget.resturentName,
                  resturentId: widget.resturentId,
                  resturenrAddr: widget.resturenrtAddr,
                  //resturentPrice: resturentOfferPrice,
                  configData: widget.configData,
                  couponList: widget.couponList))).then((value) {
        _itemLoad = false;
        _getCart();
        serchData = _getSearchData(_searchChar.text.toString());
      });
    }
  }
}
