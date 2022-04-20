import 'dart:ui';
import 'package:bazimat/add%20cuisin/AddCuisin.dart';
import 'package:bazimat/order/PastOrderItem.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bazimat/order/pastOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PastOrderList extends StatefulWidget {
  PostOrderData listData;
  var token, userId;
  PastOrderList({this.listData, this.token, this.userId, Key key})
      : super(key: key);

  @override
  _PastOrderListState createState() => _PastOrderListState();
}

class _PastOrderListState extends State<PastOrderList> {
  double _selectIcon = 0.0;
  var dio = Dio();
  bool _reviewSubmit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewSubmit = true;
    //_productRating();
  }

  @override
  Widget build(BuildContext context) {
    print("listData..." + widget.listData.toString());
    print("listData..." + widget.listData.quantity.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 3.0)
            ],
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width * 0.01))),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  //color: Colors.amber,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.listData.cart.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(
                          "foodNAme..." + widget.listData.cart[index].foodName);
                      return PastOrderItem(
                          cartDataList: widget.listData.cart[index],
                          userId: widget.listData.restaurant.id.toString(),
                          token: widget.token.toString());
                    },
                  ),
                ),
                Spacer(),
                Text(
                  "${widget.listData.orderStatus}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(
              "${widget.listData.deliveryAddress.address}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(
              "\u20B9${widget.listData.orderAmountRound}",
              style: TextStyle(color: Colors.black),
            ),
            Divider(),
            // Text(
            //   "Qty: ${widget.listData.quantity}",
            //   style: TextStyle(color: Colors.grey),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              "Order Time: ${widget.listData.createdAt}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Container(
              // width: MediaQuery.of(context).size.width / 2.5,
              //padding: const EdgeInsets.all(8.0),
              //color: Colors.white,
              padding: EdgeInsets.all(0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(color: Colors.grey)),
              child: TextButton(
                  onPressed: () {
                    //_addToCart();
                    _repeatOrderData();
                  },
                  child: Text("Repeat Order".toUpperCase())),
            )
            // SizedBox(
            //   height: MediaQuery.of(context).size.width * 0.01,
            // ),
            // _reviewSubmit == true
            //     ? SizedBox()
            //     : SizedBox(
            //         height: MediaQuery.of(context).size.width * 0.02,
            //       ),
            // _reviewSubmit == true
            //     ? SizedBox()
            //     : Container(
            //         // width: MediaQuery.of(context).size.width / 2.5,
            //         padding: const EdgeInsets.all(8.0),
            //         //color: Colors.white,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             border: Border.all(color: Colors.grey)),
            //         child: Text("Rate food".toUpperCase()),
            //       )
          ],
        ),
      ),
    );
  }

  _giveRating(double selectIcon, String foodId, String orderId) async {
    print("OrederId..." + orderId.toString());
    print("foodId..." + foodId.toString());
    try {
      var params = "?";
      params += "food_id=" +
          widget.listData.foodId.toString() +
          "&order_id=" +
          widget.listData.id.toString() +
          "&comment=" +
          "test" +
          "&rating=" +
          selectIcon.toString();
      var url = Const.rateFood + params;
      var response = await dio.post(url,
          options:
              Options(headers: {"Authorization": "Bearer ${widget.token}"}));
      print("Response..." + response.data.toString());
      if (response.data["state"] == 0) {
        showCustomToast(response.data["message"]);
        setState(() {
          _reviewSubmit = true;
        });
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _repeatOrderData() async {
    try {
      print("resturentlat..." + widget.listData.restaurant.id.toString());
      print("resturentlat..." + widget.listData.restaurant.name.toString());
      print("resturentlat..." + widget.listData.restaurant.address.toString());
      print("resturentlat..." + widget.listData.restaurant.latitude.toString());
      print(
          "resturentlat..." + widget.listData.restaurant.longitude.toString());
      SharedPreferences pref = await SharedPreferences.getInstance();
      var latitude = pref.getString("latitude");
      var longitude = pref.getString("longitude");
      var zoneId = pref.getString("zoneId");
      print("resturentlat...not..." + latitude.toString());
      print("resturentlat...not..." + longitude.toString());
      var params = "?user_id=" +
          widget.userId.toString() +
          "&order_id=" +
          widget.listData.id.toString();
      var distanceParam = "?origin_lat=" +
          widget.listData.restaurant.latitude.toString() +
          "&origin_lng=" +
          widget.listData.restaurant.longitude.toString() +
          "&destination_lat=" +
          latitude.toString() +
          "&destination_lng=" +
          longitude.toString();
      var url = Const.repeatOrder + params;
      var distanceUrl = Const.distanceApi + distanceParam;
      print("url in pastOrderList..." + url.toString());
      var response = await Future.wait([
        dio.get(url,
            options: Options(headers: {
              "Authorization": "Bearer ${widget.token.toString()}"
            })),
        dio.get(distanceUrl,
            options: Options(headers: {
              "Authorization": "Bearer ${widget.token.toString()}"
            })),
        dio.get(Const.config),
        dio.get(Const.couponList,
            options: Options(headers: {
              "Authorization": "Bearer ${widget.token.toString()}",
              "zoneId": zoneId
            }))
      ]);
      print("url in pastOrderList..." + response[0].data.toString());
      print("url in pastOrderList..." + response[1].data.toString());
      print("url in pastOrderList..." + response[2].data.toString());
      print("url in pastOrderList..." + response[3].data.toString());
      var distance = response[1]
          .data['rows'][0]['elements'][0]['distance']['text']
          .toString();
      var duration = response[1]
          .data['rows'][0]['elements'][0]['duration']['text']
          .toString();
      print("url in pastOrderList..." + distance.toString());
      print("url in pastOrderList..." + duration.toString());
      if (response[0].data["state"] == 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddCuisin(
                    duration: duration,
                    distance: distance,
                    resturentLat:
                        widget.listData.restaurant.latitude.toString(),
                    resturentLng:
                        widget.listData.restaurant.longitude.toString(),
                    productList: response[0].data["respData"],
                    // product: widget.productList,
                    // imageUrl: widget.imageUrl,
                    resturentName: widget.listData.restaurant.name.toString(),
                    resturentId: widget.listData.restaurant.id.toString(),
                    resturenrAddr:
                        widget.listData.restaurant.address.toString(),
                    //resturentPrice: resturentOfferPrice,
                    configData: response[2].data,
                    orderPage: "Pastorder"
                    //couponList: response[3].data["errors"]
                    )));
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _addToCart() async {
    try {} on DioError catch (e) {
      print(e.toString());
    }
  }

  // _productRating() async {
  //   try {
  //     print("userId..." + widget.listData.userId.toString());
  //     print("userId..." + widget.listData.foodId.toString());
  //     var params = "?food_id=" +
  //         widget.listData.foodId.toString() +
  //         "&user_id=" +
  //         widget.listData.userId.toString();
  //     var url = Const.productRate + params;
  //     print("userId..." + url.toString());
  //     var response = await dio.get(url);
  //     print("userId...product review..." + response.data.toString());
  //     if (response.data["state"] == 0) {
  //       setState(() {
  //         _reviewSubmit = true;
  //       });
  //     } else {
  //       setState(() {
  //         _reviewSubmit = false;
  //       });
  //     }
  //     print("reviewSubmit..." + _reviewSubmit.toString());
  //   } on DioError catch (e) {
  //     print(e.toString());
  //   }
  // }
}
