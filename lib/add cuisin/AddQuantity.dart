import 'dart:async';

import 'package:bazimat/add%20cuisin/AddCuisin.dart';
import 'package:bazimat/add%20cuisin/QuantityList.dart';
import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/popular%20cuisin/Recomended.dart';
import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddQuantity extends StatefulWidget {
  var
      //imageUrl,
      resturentName,
      resturentAddr,
      resturentId;
  //resturentOffer,
  //product;
  //Products product;
  Function(dynamic productList, String type) refresh;
  AddQuantity(
      {
      //this.imageUrl,
      this.resturentName,
      this.resturentAddr,
      this.resturentId,
      //this.resturentOffer,
      //this.product,
      this.refresh,
      Key key})
      : super(key: key);

  @override
  _AddQuantityState createState() => _AddQuantityState();
}

class _AddQuantityState extends State<AddQuantity> {
  int price;

  bool getCartLoad;
  var dio = Dio();
  var allCartData;
  var timer;
  @override
  void initState() {
    super.initState();
    _getProduct();
    getCartLoad = false;
    String type = "";
    //int dataLength;
    dynamic data;
    listLoad(type, data);
    //price = widget.product.price;
    //itemCount = 1;
    //finalPrice = price * itemCount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("Product in add Quantity..." + widget.product.toString());
    // print("Product in add Quantity..." + widget.product.length.toString());
    //print("Price..." + price.runtimeType.toString());
    // var off = widget.resturentOffer.toString().split(" ");
    // print("Off..." + off[0].toString());
    // var offer = int.parse(off[0]);
    // var price = offer / 2;
    // print("offerPrice..." + price.toString());
    // print("offerPrice..." + widget.product.price.toString());
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
          bottom: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Row(
            children: [
              getCartLoad == false
                  ? Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: MediaQuery.of(context).size.height * 0.12,
                      color: Colors.grey.withOpacity(0.2),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(allCartData[0]["food_image"]),
                              fit: BoxFit.fill)),
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.resturentName}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Text(
                      "${widget.resturentAddr}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width * 0.03),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.06,
          ),
          Container(
            //height: MediaQuery.of(context).size.width * 0.4,
            width: MediaQuery.of(context).size.width,
            child: getCartLoad == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                :
                // allCartData.length == 0
                //     ? Center(
                //         child: Text("No Item"),
                //       )
                //     :
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allCartData.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("All CArt DAta length..." +
                          allCartData.length.toString());
                      // print("ItemCount..." +
                      //     allCartData[index]["quantity"].toString());
                      // print("ItemCount..." +
                      //     allCartData[index]["food_amount"]
                      //         .runtimeType
                      //         .toString());
                      return QuantityList(
                          dataList: allCartData[index],
                          refresh: widget.refresh,
                          data: listLoad);
                    },
                  ),
          )
        ],
      ),
    );
  }

  _getProduct() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var id = pref.getString("id");
      var token = pref.getString("token");
      var params = "?user_id=" +
          id.toString() +
          "&restaurant_id=" +
          widget.resturentId.toString();
      print("params..." + params.toString());
      var response = await dio.post(Const.getCart + params,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      setState(() {
        allCartData = response.data["respData"];
      });
      print("respons body...in getCart..." + response.data.toString());
      if (response.data['state'] == 1) {
        setState(() {
          //_dataAdded = false;
          //getCartLoad = true;
          showCustomToast(response.data['message']);
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => Recommended()));
        });
      } else {
        setState(() {
          //_dataAdded = true;
          getCartLoad = true;
        });
        timer.cancel();
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  listLoad(String type, dynamic data) {
    print("Type in addQuantity..." + type.toString());
    print("Type in addQuantity..." + data.toString());
    print("Type in addQuantity..." + allCartData.toString());
    if (type == "delete") {
      setState(() {
        getCartLoad = false;
        //_getProduct();
        allCartData = allCartData
            .where(
                (e) => e["cart_id"].toString() != data[0]["cart_id"].toString())
            .toList();
        print("Type in addQuantity..." + allCartData.length.toString());
        //print("Type in addQuantity..." + allCartData.toString());
        //getCartLoad = true;
        print("getCartLoad..." + getCartLoad.toString());
        print("getCartLoad..." + allCartData.toString());
        if (allCartData.length == 0) {
          getCartLoad = false;
          //   print("hii...");
          //   // Navigator.pushNamedAndRemoveUntil(
          //   //     context, MaterialPageRoute(builder: (context) => Recommended()));
          //   // Navigator.pushAndRemoveUntil(
          //   //     context,
          //   //     MaterialPageRoute(builder: (context) => CuisinDetails()),
          //   //     (route) => false);
        } else {
          //getCartLoad = true;
          getCartLoad = false;
          timer = Duration(seconds: 3);
          Timer.periodic(timer, (Timer t) {
            _getProduct();
          });
        }
      });
    }
  }
}
