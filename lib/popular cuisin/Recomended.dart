import 'package:bazimat/add%20cuisin/AddCuisin.dart';
import 'package:bazimat/home/ConfigModel.dart';
import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Recommended extends StatefulWidget {
  Products productList;
  var imageUrl,
      duration,
      distance,
      resturentLat,
      resturentLng,
      resturentName,
      resturentId,
      resturentAddress,
      token,
      resturentOfferPrice;
  Function() couponList;
  var allCartData;
  Function(bool cartShow, String tax, String foodId, String foodAmt, String qty)
      viewCart;
  Recommended(
      {this.productList,
      this.imageUrl,
      this.duration,
      this.distance,
      this.resturentLat,
      this.resturentLng,
      this.resturentName,
      this.resturentId,
      this.resturentAddress,
      this.token,
      this.resturentOfferPrice,
      Key key,
      this.couponList,
      this.allCartData,
      this.viewCart});

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  var dio = Dio();
  var configData;
  bool configLoad;
  bool _dataAdded;
  int itemCount;
  bool _updateload = false;
  @override
  void initState() {
    super.initState();
    configData = false;
    _dataAdded = false;
    print("getW....");
    _getQuantity();
    //widget.viewCart.
    //_getData(widget.viewCart);
    //itemCount = 1;
    _getConfig();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("productDetails..." + widget.productList.taxType.toString());
    print("productDetails..." + widget.productList.name.toString());
    print("allCartData...in recommended..." + widget.allCartData.toString());
    print("getQuantity called...");
    var image = widget.imageUrl + widget.productList.image;
    print("Image..." + image.toString());
    print("hjhj..." + image.toString());
    print("upload..." + _updateload.toString());
    if (_updateload == false) {
      _getQuantity();
    } else {}
    return configData == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => AddCuisin(
              //             duration: widget.duration,
              //             distance: widget.distance,
              //             resturentLat: widget.resturentLat,
              //             resturentLng: widget.resturentLng,
              //             product: widget.productList,
              //             imageUrl: widget.imageUrl,
              //             resturentName: widget.resturentName,
              //             resturentId: widget.resturentId,
              //             resturenrAddr: widget.resturentAddress,
              //             resturentPrice: widget.resturentOfferPrice,
              //             configData: configData,
              //             couponList: widget.couponList)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //height: MediaQuery.of(context).size.width * 0.2,
                // width: MediaQuery.of(context).size.width / 2,
                //color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.red,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.productList.name}",
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Row(
                            children: [
                              Text(
                                "\u20B9${widget.productList.price}",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(),
                              _dataAdded == true
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.08,
                                      // padding: EdgeInsets.only(
                                      //     // left: MediaQuery.of(context).size.width *
                                      //     //     0.02,
                                      //     // right: MediaQuery.of(context)
                                      //     //         .size
                                      //     //         .width *
                                      //     //     0.04,
                                      //     top: MediaQuery.of(context)
                                      //             .size
                                      //             .width *
                                      //         0.01,
                                      //     bottom: MediaQuery.of(context)
                                      //             .size
                                      //             .width *
                                      //         0.01),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // setState(() {
                                              //   itemCount = itemCount - 1;
                                              //   _updateload = true;
                                              //   if (itemCount < 1) {
                                              //     _deleteFromCart();
                                              //     print("ItemCount..." +
                                              //         itemCount.toString());
                                              //     _dataAdded = false;
                                              //     itemCount = 1;
                                              //     widget.viewCart(
                                              //         _dataAdded,
                                              //         widget.productList.tax
                                              //             .toString(),
                                              //         widget.productList.id
                                              //             .toString(),
                                              //         widget.productList.price
                                              //             .toString(),
                                              //         itemCount.toString());
                                              //   } else {
                                              //     _updateCart();
                                              //   }
                                              // });
                                            },
                                            child: Container(
                                              //color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                              alignment: Alignment.center,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    //minimumSize: Size.zero,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0.0,
                                                            bottom: 0.0,
                                                            left: 2.0,
                                                            right: 2.0),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap),
                                                onPressed: () {
                                                  setState(() {
                                                    itemCount = itemCount - 1;
                                                    _updateload = true;
                                                    if (itemCount < 1) {
                                                      _deleteFromCart();
                                                      print("ItemCount..." +
                                                          itemCount.toString());
                                                      _dataAdded = false;
                                                      itemCount = 1;
                                                      widget.viewCart(
                                                          _dataAdded,
                                                          widget.productList.tax
                                                              .toString(),
                                                          widget.productList.id
                                                              .toString(),
                                                          widget
                                                              .productList.price
                                                              .toString(),
                                                          itemCount.toString());
                                                    } else {
                                                      _updateCart();
                                                    }
                                                  });
                                                },
                                                child: Text("-",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            alignment: Alignment.center,
                                            child: Text(
                                              itemCount.toString(),
                                              style: TextStyle(
                                                  color:
                                                      AppColors.addTextColor),
                                            ),
                                          ),
                                          // InkWell(
                                          //   onTap: () {
                                          // setState(() {
                                          //   itemCount = itemCount + 1;
                                          //   _updateload = true;
                                          //   //configData = false;
                                          //   print("Item..." +
                                          //       itemCount.toString());
                                          //   _updateCart();
                                          // });
                                          //},
                                          Container(
                                            //color: Colors.amber,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                            alignment: Alignment.center,
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                    //minimumSize: Size.zero,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0.0,
                                                            bottom: 0.0,
                                                            left: 2.0,
                                                            right: 2.0),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap),
                                                onPressed: () {
                                                  setState(() {
                                                    itemCount = itemCount + 1;
                                                    _updateload = true;
                                                    //configData = false;
                                                    print("Item..." +
                                                        itemCount.toString());
                                                    _updateCart();
                                                  });
                                                },
                                                child: Text("+")),
                                          ),
                                          //),
                                        ],
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          itemCount = 1;
                                          _dataAdded = true;
                                          widget.viewCart(
                                              _dataAdded,
                                              widget.productList.tax.toString(),
                                              widget.productList.id.toString(),
                                              widget.productList.price
                                                  .toString(),
                                              itemCount.toString());
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              top: MediaQuery.of(context).size.width *
                                                  0.01,
                                              bottom:
                                                  MediaQuery.of(context).size.width *
                                                      0.01),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(MediaQuery.of(context).size.width * 0.01))),
                                          child: Text(
                                            "ADD",
                                            style: TextStyle(
                                                color: AppColors.addTextColor),
                                          )),
                                    )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  _updateCart() async {
    try {
      var data;
      print("id..." + widget.productList.id.toString());
      print("id..." + itemCount.toString());
      //itemCount = itemCount;
      for (int i = 0; i < widget.allCartData.length; i++) {
        data = widget.allCartData
            .where((e) => e["food_id"] == widget.productList.id)
            .toList();
        print("id..." + data.toString());
      }
      var params = "?cart_id=" +
          data[0]["cart_id"].toString() +
          "&quantity=" +
          itemCount.toString();
      var url = Const.updateCart + params;
      print("URL..." + widget.token.toString());
      print("URL..." + url.toString());
      var response = await dio.post(url,
          options:
              Options(headers: {"Authorization": "Bearer ${widget.token}"}));
      print("response data..." + response.data.toString());
      if (response.data["state"] == 0) {
        showCustomToast(response.data["message"].toString());
        //setState(() {
        _updateload = false;
        //configData = true;

        //});
        // setState(() {
        //   itemCount = int.parse(response.data["respData"]["quantity"]);
        //   print("response data..." + itemCount.toString());
        // });
      }
      // setState(() {
      //   itemCount = itemCount + 1;
      // });
      // var param = "?cart_id="+8+"&quantity=3";
      // var response = await dio.post(path)
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getConfig() async {
    try {
      var response = await dio.get(Const.config);
      print("response of Config..." + response.data.toString());
      setState(() {
        configLoad = true;
      });
      configData = response.data;
      // Configmodel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  // _getData(Function(bool cartShow) viewCart) {
  //   print("cartShow..." + viewCart.toString());
  // }

  _getQuantity() {
    print("getQuantity called... in recommended");
    print("cart quantity...in recommended..." + widget.allCartData.toString());
    _dataAdded = false;
    for (int i = 0; i < widget.allCartData.length; i++) {
      if (widget.productList.id == widget.allCartData[i]["food_id"]) {
        print("Quantity..." + widget.allCartData[i]["quantity"].toString());
        setState(() {
          itemCount = widget.allCartData[i]["quantity"];
          print("itemcount in recommended..." + itemCount.toString());
          _dataAdded = true;
        });
      } else {
        // setState(() {
        //   itemCount = 0;
        //   //_dataAdded = false;
        // });
      }
      // else {
      //   setState(() {
      //     itemCount = 1;
      //     _dataAdded = false;
      //   });
      // }
    }
  }

  _deleteFromCart() async {
    try {
      var data;
      print("id...delete..." + widget.productList.id.toString());
      print("id...delete..." + itemCount.toString());
      for (int i = 0; i < widget.allCartData.length; i++) {
        data = widget.allCartData
            .where((e) => e["food_id"] == widget.productList.id)
            .toList();
        print("id...delete..." + data.toString());
      }
      var url = Const.deleteCart + "?cart_id=" + data[0]["cart_id"].toString();
      print("Url.." + url.toString());
      var response = await dio.post(url,
          options:
              Options(headers: {"Authorization": "Bearer ${widget.token}"}));
      if (response.data["state"] == 0) {
        showCustomToast(response.data["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  //_qtyDecrement() {}
}
