import 'package:bazimat/order/pastOrderModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PastOrderItem extends StatefulWidget {
  Cart cartDataList;
  String userId, token;
  PastOrderItem({this.cartDataList, this.userId, this.token, Key key})
      : super(key: key);

  @override
  _PastOrderItemState createState() => _PastOrderItemState();
}

class _PastOrderItemState extends State<PastOrderItem> {
  double _selectIcon = 0.0;
  bool _reviewSubmit;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _productRating(
        widget.userId.toString(), widget.cartDataList.foodId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(
                "${widget.cartDataList.foodName}",
                // style: TextStyle(color: Colors.red),
              ),
            ),
            _reviewSubmit == true
                ? SizedBox()
                : Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    //width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    //color: Colors.red,
                    child: RatingBar(
                      initialRating: _selectIcon,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 15.0,
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
                          _giveRating(
                              _selectIcon,
                              widget.cartDataList.foodId.toString(),
                              widget.cartDataList.orderId.toString());
                        });
                      },
                    ),
                  ),
          ],
        ),
        Divider()
      ],
    );
  }

  _giveRating(double selectIcon, String foodId, String orderId) async {
    print("OrederId..." + orderId.toString());
    print("foodId..." + foodId.toString());
    try {
      var params = "?";
      params += "food_id=" +
          foodId.toString() +
          "&order_id=" +
          orderId.toString() +
          "&user_id=" +
          widget.userId.toString() +
          "&comment=" +
          "test" +
          "&rating=" +
          selectIcon.toString();
      var url = Const.rateFood + params;
      print("url submit..." + url.toString());
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

  _productRating(String userId, String foodId) async {
    try {
      print("userId..." + userId.toString());
      print("userId..." + foodId.toString());
      var params =
          "?food_id=" + foodId.toString() + "&user_id=" + userId.toString();
      var url = Const.productRate + params;
      print("userId..." + url.toString());
      var response = await dio.get(url);
      print("userId...product review..." + response.data.toString());
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
