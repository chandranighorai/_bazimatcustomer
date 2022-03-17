import 'package:bazimat/add%20cuisin/AddCuisin.dart';
import 'package:bazimat/add%20cuisin/Cart.dart';
import 'package:bazimat/notification/NotificationModel.dart';
import 'package:bazimat/search/SearchDataList.dart';
import 'package:bazimat/search/SerachModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  var duration,
      distance,
      resturentLat,
      resturentLng,
      resturentId,
      resturentName,
      resturenrtAddr,
      configData,
      couponList;
  Search(
      {this.duration,
      this.distance,
      this.resturentLat,
      this.resturentLng,
      this.resturentId,
      this.resturentName,
      this.resturenrtAddr,
      this.configData,
      this.couponList,
      Key key})
      : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var dio = Dio();
  var token, zoneId, id, cartData;
  Future<SearchModel> serchData;
  bool _pageLoad, _itemLoad, _addEnable;
  int itemCount, totalCartItem = 0;
  var totalItem = [];
  TextEditingController _searchChar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //cartData = '';
    _pageLoad = true;
    _itemLoad = false;
    _addEnable = false;
    itemCount = 0;
    _searchChar = new TextEditingController();
    _getToken();
    //_cartItem();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("resturentId..." + widget.resturentId.toString());
    print("resturentId..." + widget.resturentName.toString());
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
      totalItem.clear();
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

  _cartItem(var totalList) {
    // totalItem = totalItem.(totalList);
    print("cart_data...in total List..." + totalList.toString());
    print("cart_data...in total item..." + totalItem.toString());
    if (totalItem.length == 0) {
      totalItem.add(totalList[0]);
    } else {
      var data = totalItem
          .where((element) =>
              element["cart_id"].toString() ==
              totalList[0]["cart_id"].toString())
          .toList();
      print("cart_data...in total data..." + data.toString());
      if (data.length == 0) {
        totalItem.add(totalList[0]);
      } else {
        for (int i = 0; i < totalItem.length; i++) {
          if (totalItem[i]["cart_id"].toString() ==
              data[0]["cart_id"].toString()) {
            // setState(() {
            totalItem[i]["quantity"] =
                int.parse(data[0]["quantity"].toString());
            //});
          }
        }
      }
    }
    //setState(() {
    totalCartItem = totalItem.length;
    //});
    print("cart_data...in total item0..." + totalItem.toString());
    print("cart_data...in total item0..." + totalItem.length.toString());
    print("cart_data...in total item0..." + totalCartItem.toString());
  }

  _cartNavigate() {
    print("total cart item..." + totalCartItem.toString());
    print("total cart item..." + widget.resturentId.toString());
    print("total cart item..." + widget.resturentName.toString());
    print("totalcartItem..." + totalCartItem.runtimeType.toString());
    if (totalCartItem >= 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddCuisin(
                  duration: widget.duration,
                  distance: widget.distance,
                  resturentLat: widget.resturentLat,
                  resturentLng: widget.resturentLng,
                  productList: totalItem,
                  // product: widget.productList,
                  // imageUrl: widget.imageUrl,
                  resturentName: widget.resturentName,
                  resturentId: widget.resturentId,
                  resturenrAddr: widget.resturenrtAddr,
                  //resturentPrice: resturentOfferPrice,
                  configData: widget.configData,
                  couponList: widget.couponList))).then((value) {
        print("Value...cart.." + value.toString());
        setState(() {
          cartData = value;
          _getSearchData(_searchChar.text.toString());
        });
        //_cartItem(value);
      });
    } else {
      showCustomToast("Please add item");
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


// import 'package:bazimat/notification/NotificationModel.dart';
// import 'package:bazimat/search/SearchDataList.dart';
// import 'package:bazimat/search/SerachModel.dart';
// import 'package:bazimat/util/AppConst.dart';
// import 'package:bazimat/util/Const.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Search extends StatefulWidget {
//   var resturentId;
//   Search({this.resturentId, Key key}) : super(key: key);

//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   var dio = Dio();
//   var token, zoneId, id, cartData;
//   Future<SearchModel> serchData;
//   bool _pageLoad, _itemLoad, _addEnable;
//   int itemCount;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //cartData = '';
//     _pageLoad = true;
//     _itemLoad = false;
//     _addEnable = false;
//     itemCount = 0;
//     _getToken();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("resturentId..." + widget.resturentId.toString());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         // title: Text(
//         //   "Search",
//         //   style: TextStyle(color: Colors.black),
//         // ),
//       ),
//       // floatingActionButton: _itemLoad == false
//       //     ? SizedBox()
//       //     : cartData.toString() == "null"
//       //         ? SizedBox()
//       //         : FloatingActionButton(
//       //             onPressed: null, child: Icon(Icons.shopping_cart_rounded)),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
//         //color: Colors.pinkAccent,
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.width * 0.14,
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(
//                       Radius.circular(MediaQuery.of(context).size.width * 0.8)),
//                   boxShadow: [BoxShadow(color: Colors.grey)]),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     hintText: "Search...", border: InputBorder.none),
//                 onChanged: (value) {
//                   print("Value..." + value.toString());
//                   _getItem(value.toString());
//                   //_getSearchData(value.toString());
//                 },
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.width * 0.02,
//             ),
//             _pageLoad == true
//                 ? Center(
//                     child: Text("Have not search yet"),
//                   )
//                 : _itemLoad == false
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : Expanded(
//                         //height: MediaQuery.of(context).size.height * 0.8,
//                         //color: Colors.amber,
//                         child: FutureBuilder(
//                           initialData: null,
//                           future: serchData,
//                           builder:
//                               (BuildContext context, AsyncSnapshot snapshot) {
//                             print("SnapShot..." + snapshot.data.toString());
//                             if (snapshot.hasData) {
//                               var dataList = snapshot.data.errors.products;
//                               var imageUrl = snapshot.data.errors.imageUrl;
//                               print("DataList length..." +
//                                   dataList.length.toString());
//                               return dataList.length == 0
//                                   ? Center(child: Text("No Items available"))
//                                   : ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: dataList.length,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         print("cartData...datas" +
//                                             cartData.toString());
//                                         print("cartData...datas..." +
//                                             dataList[index].toString());
//                                         return SearchDataList(
//                                             imageUrl: imageUrl,
//                                             cartdata: cartData,
//                                             dataList: dataList[index],
//                                             resturentId:
//                                                 widget.resturentId.toString(),
//                                             userId: id.toString(),
//                                             token:token);
//                                         // print("DataList..." +
//                                         //     dataList[index].name.toString());
//                                         // print("DataList..." + cartData.toString());
//                                         // var data = [];
//                                         // itemCount = 0;
//                                         // var imageData =
//                                         //     imageUrl + dataList[index].image;
//                                         // if (cartData.toString() == "null") {
//                                         // } else {
//                                         //   data = cartData
//                                         //       .where((e) =>
//                                         //           e["food_name"] ==
//                                         //           dataList[index].name)
//                                         //       .toList();
//                                         //   print("Data..." + data.toString());
//                                         //   if (data.length == 0) {
//                                         //     // setState(() {
//                                         //     itemCount = 0;
//                                         //     _addEnable = false;
//                                         //     // });
//                                         //   } else {
//                                         //     // setState(() {
//                                         //     _addEnable = true;
//                                         //     itemCount = int.parse(
//                                         //         data[0]["quantity"].toString());
//                                         //     // });
//                                         //   }
//                                         // setState(() {
//                                         //   itemCount = int.parse(
//                                         //       data[0]["quantity"].toString());
//                                         // });
//                                         // print("Data..." + itemCount.toString());
//                                         // }
//                                       });
//                             } else {
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }
//                           },
//                         ),
//                       )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<SearchModel> _getSearchData(String val) async {
//     try {
//       var params = "?restaurant_id=" +
//           widget.resturentId.toString() +
//           "&name=" +
//           val.toString();
//       var url = Const.productsearch + params;
//       var response = await dio.get(url,
//           options: Options(headers: {
//             "Authorization": "Bearer $token",
//             "zoneId": zoneId.toString()
//           }));
//       print("response data..." + response.data.toString());
//       if (response.data["state"] == 0) {
//         setState(() {
//           _itemLoad = true;
//           _pageLoad = false;
//         });
//         return SearchModel.fromJson(response.data);
//       } else {
//         showCustomToast(response.data["errors"][0]["message"]);
//       }
//     } on DioError catch (e) {
//       print(e.toString());
//     }
//   }

//   void _getToken() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     token = pref.getString("token");
//     zoneId = pref.getString("zoneId");
//     id = pref.getString("id");
//     _getCart();
//   }

//   _getItem(String val) {
//     setState(() {
//       serchData = _getSearchData(val.toString());
//     });
//   }

//   _getCart() async {
//     try {
//       var params = "?user_id=" +
//           id.toString() +
//           "&restaurant_id=" +
//           widget.resturentId.toString();
//       var url = Const.getCart + params;
//       var response = await dio.post(url,
//           options: Options(headers: {"Authorization": "Bearer $token"}));
//       print("response data in cart..." + response.data.toString());
//       if (response.data["state"] == 1) {
//         setState(() {
//           _pageLoad = true;
//         });
//       } else {
//         cartData = response.data["respData"];
//         print("response data in cart..." + cartData.toString());
//         setState(() {
//           _pageLoad = true;
//         });
//       }
//     } on DioError catch (e) {
//       print(e.toString());
//     }
//   }

//   // _addToCArt(Products dataList, String resturentId, String id) async {
//   //   print("data in CArt..." + dataList.name.toString());
//   //   print("data in CArt..." + resturentId.toString());
//   //   print("data in CArt..." + id.toString());
//   //   var params = "?user_id=" +
//   //       id +
//   //       "&food_id=" +
//   //       dataList.id.toString() +
//   //       "&food_amount=" +
//   //       dataList.price.toString() +
//   //       "&quantity=1&restaurant_id=" +
//   //       resturentId +
//   //       "&tax=" +
//   //       dataList.tax.toString();
//   //   var url = Const.addToCart + params;
//   //   var responseCart = await dio.post(url,
//   //       options: Options(headers: {"Authorization": "Bearer $token"}));
//   //   print("data in CArt..." + responseCart.data.toString());
//   //   if (responseCart.data["state"] == 0) {
//   //     setState(() {
//   //       _addEnable = true;
//   //     });
//   //     print("adEnb..." + _addEnable.toString());
//   //   }
//   // }
// }
