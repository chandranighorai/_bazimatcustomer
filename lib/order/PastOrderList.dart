import 'dart:ui';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bazimat/order/pastOrderModel.dart';
import 'package:flutter/material.dart';

class PastOrderList extends StatefulWidget {
  PostOrderData listData;
  var token;
  PastOrderList({this.listData, this.token, Key key}) : super(key: key);

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
    _reviewSubmit = false;
    _productRating();
  }

  @override
  Widget build(BuildContext context) {
    print("listData..." + widget.listData.toString());
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
                  child: Text(
                    "${widget.listData.foodName}",
                    // style: TextStyle(color: Colors.red),
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
            Text(
              "Qty: ${widget.listData.quantity}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              "Order Time: ${widget.listData.createdAt}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            _reviewSubmit == true
                ? SizedBox()
                : Container(
                    height: MediaQuery.of(context).size.width * 0.08,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: RatingBar(
                      initialRating: _selectIcon,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 30.0,
                      ratingWidget: RatingWidget(
                          empty: Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                          full: Icon(
                            Icons.star,
                            color: Colors.amber,
                          )),
                      onRatingUpdate: (rating) {
                        print("Rating..." + rating.toString());
                        setState(() {
                          _selectIcon = rating;
                          print("Rating..." + _selectIcon.toString());
                          _giveRating(_selectIcon);
                        });
                      },
                    ),
                  ),
            _reviewSubmit == true
                ? SizedBox()
                : SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
            _reviewSubmit == true
                ? SizedBox()
                : Container(
                    // width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(8.0),
                    //color: Colors.white,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Text("Rate food".toUpperCase()),
                  )
          ],
        ),
      ),
    );
  }

  _giveRating(double selectIcon) async {
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

  _productRating() async {
    try {
      print("userId..." + widget.listData.userId.toString());
      print("userId..." + widget.listData.foodId.toString());

      var params = "?food_id=" +
          widget.listData.foodId.toString() +
          "&user_id=" +
          widget.listData.userId.toString();
      var url = Const.productRate + params;
      print("userId..." + url.toString());
      var response = await dio.get(url);
      print("userId..." + response.data.toString());
      if (response.data["state"] == 0) {
        setState(() {
          _reviewSubmit = true;
        });
      } else {
        setState(() {
          _reviewSubmit = false;
        });
      }
      print("reviewSubmit..." + _reviewSubmit.toString());
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
