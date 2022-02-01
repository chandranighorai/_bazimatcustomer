import 'package:bazimat/add%20cuisin/AddCuisin.dart';
import 'package:bazimat/favourites/FavouriteModel.dart';
import 'package:bazimat/home/CampaignDetailsModel.dart';
import 'package:bazimat/home/PopularResturentModel.dart';
import 'package:bazimat/home/ResturentModel.dart';
import 'package:bazimat/popular%20cuisin/GetCartModel.dart';
import 'package:bazimat/popular%20cuisin/Recomended.dart';
import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/popular%20cuisin/PopularCuisinResturentModel.dart';
import 'package:bazimat/sub%20list/SubListModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CuisinDetails extends StatefulWidget {
  Restaurants resturentData;
  RestaurantsSub listData;
  RestaurantsCuisin cuisinList;
  PopularResturentErrors topPickList;
  CampaignDetailsRestaurants campaignData;
  FavRestaurant favResturentData;
  var resturentLat, resturentLng, distance, duration;
  String section;
  Function() couponList;
  CuisinDetails(
      {this.resturentData,
      this.listData,
      this.cuisinList,
      this.topPickList,
      this.campaignData,
      this.favResturentData,
      this.resturentLat,
      this.resturentLng,
      this.distance,
      this.duration,
      this.section,
      this.couponList});

  @override
  _CuisinDetailsState createState() => _CuisinDetailsState();
}

class _CuisinDetailsState extends State<CuisinDetails> {
  Future<RecommendedModel> _recommendedProduct;
  var dio = Dio();
  var dataId, zoneId;
  var token, id;
  bool _resturentLike;
  bool _dataAdded;
  var configData;
  bool configLoad, getCartLoad;
  var allCartData;
  var resturentId,
      resturentName,
      resturentDesc,
      resturentAddr,
      resturentAvgRating,
      resturentRatingCount,
      resturentOfferPrice;
  @override
  void initState() {
    super.initState();
    if (widget.section == "cuisin") {
      resturentId = widget.cuisinList.id;
      resturentName = widget.cuisinList.name;
      resturentDesc = widget.cuisinList.description;
      resturentAddr = widget.cuisinList.address;
      resturentAvgRating = widget.cuisinList.avgRating;
      resturentRatingCount = widget.cuisinList.ratingCount;
      resturentOfferPrice = widget.cuisinList.offerprice;
    } else if (widget.section == "list") {
      resturentId = widget.listData.id;
      resturentName = widget.listData.name;
      resturentDesc = widget.listData.description;
      resturentAddr = widget.listData.address;
      resturentAvgRating = widget.listData.avgRating;
      resturentRatingCount = widget.listData.ratingCount;
      resturentOfferPrice = widget.listData.offerprice;
    } else if (widget.section == "topPicks") {
      resturentId = widget.topPickList.id;
      resturentName = widget.topPickList.name;
      resturentDesc = widget.topPickList.description;
      resturentAddr = widget.topPickList.address;
      resturentAvgRating = widget.topPickList.avgRating;
      resturentRatingCount = widget.topPickList.ratingCount;
      resturentOfferPrice = widget.topPickList.offerprice;
    } else if (widget.section == "campaign") {
      resturentId = widget.campaignData.id;
      resturentName = widget.campaignData.name;
      resturentDesc = widget.campaignData.description;
      resturentAddr = widget.campaignData.address;
      resturentAvgRating = widget.campaignData.avgRating;
      resturentRatingCount = widget.campaignData.ratingCount;
      resturentOfferPrice = widget.campaignData.offerprice;
    } else if (widget.section == "favourite") {
      resturentId = widget.favResturentData.id;
      resturentName = widget.favResturentData.name;
      resturentDesc = widget.favResturentData.description;
      resturentAddr = widget.favResturentData.address;
      resturentAvgRating = widget.favResturentData.avgRating;
      resturentRatingCount = widget.favResturentData.ratingCount;
      resturentOfferPrice = widget.favResturentData.offerprice;
    } else {
      resturentId = widget.resturentData.id;
      resturentName = widget.resturentData.name;
      resturentDesc = widget.resturentData.description;
      resturentAddr = widget.resturentData.address;
      resturentAvgRating = widget.resturentData.avgRating;
      resturentRatingCount = widget.resturentData.ratingCount;
      resturentOfferPrice = widget.resturentData.offerprice;
    }
    // ? "${widget.cuisinList.name}"
    // : widget.section == "list"
    //     ? "${widget.listData.name}"
    //     : widget.section == "topPicks"
    //         ? "${widget.topPickList.name}"
    //         : widget.section == "campaign"
    //             ? "${widget.campaignData.name}"
    //             : "${widget.resturentData.name}",
    _resturentLike = false;
    _recommendedProduct = _getAllRecommendedProduct();
    _dataAdded = false;
    configData = false;
    getCartLoad = false;
    _getConfig();
    _getCartShow();
    //_viewCartShow(_dataAdded);
  }

  @override
  Widget build(BuildContext context) {
    // print("ResturentName..." + widget.resturentData.name.toString());
    // print("ResturentName..." + widget.resturentData.id.toString());
    print("resturentId..." + resturentId.toString());
    print("section..." + widget.section.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          _resturentLike == true
              ? IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _favRemove();
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _favSelected();
                  },
                ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          // Icon(
          //   Icons.search,
          //   color: Colors.grey,
          // ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          )
        ],
      ),
      bottomSheet: _dataAdded == false
          ? SizedBox()
          : InkWell(
              onTap: () {
                //   Navigator.push(
                // context,
                // MaterialPageRoute(
                //     builder: (context) => AddCuisin(
                //         duration: widget.duration,
                //         distance: widget.distance,
                //         resturentLat:widget.resturentLat,
                //         resturentLng:widget.resturentLng,
                //         product: widget.productList,
                //         imageUrl: widget.imageUrl,
                //         resturentName: resturentName,
                //         resturentId:resturentId,
                //         resturenrAddr: resturentAddr,
                //         resturentPrice: resturentOfferPrice,
                //         configData: configData,
                //         couponList: widget.couponList)
                //         ));
              },
              child: Container(
                height: MediaQuery.of(context).size.width * 0.06,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text("View Cart"),
              ),
            ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(
          //     left: MediaQuery.of(context).size.width * 0.04,
          //     right: MediaQuery.of(context).size.width * 0.04),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04),
                //padding: EdgeIns,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      resturentName.toString(),
                      // widget.section == "cuisin"
                      //     ? "${widget.cuisinList.name}"
                      //     : widget.section == "list"
                      //         ? "${widget.listData.name}"
                      //         : widget.section == "topPicks"
                      //             ? "${widget.topPickList.name}"
                      //             : widget.section == "campaign"
                      //                 ? "${widget.campaignData.name}"
                      //                 : "${widget.resturentData.name}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Text(
                      resturentDesc.toString(),
                      // widget.section == "cuisin"
                      //     ? "${widget.cuisinList.description}"
                      //     : widget.section == "list"
                      //         ? "${widget.listData.description}"
                      //         : widget.section == "topPicks"
                      //             ? "${widget.topPickList.description}"
                      //             : widget.section == "campaign"
                      //                 ? "${widget.campaignData.description}"
                      //                 : "${widget.resturentData.description}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            resturentAddr.toString(),
                            // widget.section == "cuisin"
                            //     ? "${widget.cuisinList.address}"
                            //     : widget.section == "list"
                            //         ? "${widget.listData.address}"
                            //         : widget.section == "topPicks"
                            //             ? "${widget.topPickList.address}"
                            //             : widget.section == "campaign"
                            //                 ? "${widget.campaignData.address}"
                            //                 : "${widget.resturentData.address}",
                            style: TextStyle(color: Colors.grey),
                          ),
                          VerticalDivider(
                            thickness: 1,
                          ),
                          Text(
                            "${widget.distance}",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Divider(),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3.3,
                            //height: 200,
                            //color: Colors.amber,
                            child: Column(
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                    Icons.star,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
                                  )),
                                  TextSpan(
                                      text: resturentAvgRating.toString(),
                                      // widget.section == "cuisin"
                                      //     ? "${widget.cuisinList.avgRating}"
                                      //     : widget.section == "list"
                                      //         ? "${widget.listData.avgRating}"
                                      //         : widget.section == "topPicks"
                                      //             ? "${widget.topPickList.avgRating}"
                                      //             : widget.section == "campaign"
                                      //                 ? "${widget.campaignData.avgRating}"
                                      //                 : "${widget.resturentData.avgRating}",
                                      style: TextStyle(color: Colors.black))
                                ])),
                                Text("Rating")
                                // Text(
                                //   resturentRatingCount.toString() + "ratings",
                                //   // widget.section == "cuisin"
                                //   //     ? "${widget.cuisinList.ratingCount}+ ratings"
                                //   //     : widget.section == "list"
                                //   //         ? "${widget.listData.ratingCount}+ raintgs"
                                //   //         : widget.section == "topPicks"
                                //   //             ? "${widget.topPickList.ratingCount}+ raintgs"
                                //   //             : widget.section == "campaign"
                                //   //                 ? "${widget.campaignData.ratingCount}+ raintgs"
                                //   //                 : "${widget.resturentData.ratingCount}+ raintgs",
                                //   style: TextStyle(color: Colors.grey),
                                // )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3.3,
                            //height: 200,
                            //color: Colors.white,
                            child: Column(
                              children: [
                                Text("${widget.duration}"),
                                Text(
                                  "Delivery Time",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3.3,
                            //height: 200,
                            //color: Colors.amber,
                            child: Column(
                              children: [
                                Text(
                                  resturentOfferPrice.toString(),
                                  // widget.section == "cuisin"
                                  //     ? "${widget.cuisinList.offerprice}"
                                  //     : widget.section == "list"
                                  //         ? "${widget.listData.offerprice}"
                                  //         : widget.section == "topPicks"
                                  //             ? "${widget.topPickList.offerprice}"
                                  //             : widget.section == "campaign"
                                  //                 ? "${widget.campaignData.offerprice}"
                                  //                 : "${widget.resturentData.offerprice}",
                                  textAlign: TextAlign.center,
                                ),
                                // Text(
                                //   "For Two",
                                //   style: TextStyle(color: Colors.grey),
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Divider(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.04,
                          width: MediaQuery.of(context).size.width * 0.04,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "images/discount.png".toString()),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                            "60% off upto \u20B9125 + Flat \u20B930 cashback with Paytm | Use code WELCOMEBACK",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.04,
                          width: MediaQuery.of(context).size.width * 0.04,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "images/discount.png".toString()),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                            "20% off upto \u20B9150 | Use code TRYNEW",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.width * 0.04,
                  bottom: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Text(
                  "Recommended",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              getCartLoad == false
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      //height: 420,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          FutureBuilder(
                            initialData: null,
                            future: _recommendedProduct,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                var products = snapshot.data.errors.products;
                                print("recommended product..." +
                                    products[0].toString());
                                var imagePath = snapshot.data.proimgpath;
                                return products.length == 0
                                    ? Center(
                                        child: Text("No Iteams available now"),
                                      )
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: products.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio:
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        0.55)),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print("recommended product..." +
                                              products[index].toString());
                                          print("recommended product..." +
                                              widget.resturentLat.toString());
                                          return Recommended(
                                              productList: products[index],
                                              imageUrl: imagePath,
                                              duration: widget.duration,
                                              distance: widget.distance,
                                              resturentLat: widget.resturentLat,
                                              resturentLng: widget.resturentLng,
                                              resturentName: resturentName,
                                              resturentId: resturentId,
                                              resturentAddress: resturentAddr,
                                              token: token,
                                              resturentOfferPrice:
                                                  resturentOfferPrice,
                                              couponList: widget.couponList,
                                              allCartData: allCartData,
                                              viewCart: _viewCartShow);
                                        });
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<RecommendedModel> _getAllRecommendedProduct() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString("token");
      zoneId = pref.getString("zoneId");
      print("Token..." + token.toString());
      print("Token..." + zoneId.toString());

      if (widget.section == "cuisin") {
        dataId = widget.cuisinList.id.toString();
      } else if (widget.section == "list") {
        dataId = widget.listData.id.toString();
      } else if (widget.section == "topPicks") {
        dataId = widget.topPickList.id.toString();
      } else if (widget.section == "campaign") {
        dataId = widget.campaignData.id.toString();
      } else if (widget.section == "favourite") {
        dataId = widget.favResturentData.id.toString();
      } else {
        dataId = widget.resturentData.id.toString();
      }
      var params = "?restaurant_id=" + dataId;
      var url = Const.resturentDetails + params;
      print("Url..." + url.toString());
      print("Url..." + Const.getWishList.toString());
      var response = await Future.wait([
        dio.get(url),
        dio.get(
          Const.getWishList,
          options: Options(
              headers: {"Authorization": "Bearer $token", "zoneId": zoneId}),
        )
      ]);
      print("response Body... in rrecommeded" + response[0].data.toString());
      if (response[1].data["state"] == 0) {
        var resturentdetails = response[1].data["errors"]["restaurant"];
        print("resturentdetails..." + resturentdetails.toString());
        var data =
            resturentdetails.where((e) => e["name"] == resturentName).toList();
        print("resturentDetails in data ..." + data.toString());
        if (data.length == 0) {
          setState(() {
            _resturentLike = false;
          });
        } else {
          setState(() {
            _resturentLike = true;
          });
        }
      }
      if (response[0].data["state"] == 0) {
        return RecommendedModel.fromJson(response[0].data);
      } else {
        showCustomToast(response[0].data["errors"][0]["message"]);
      }
      //print("response Body... in rrecommeded0" + response[1].data.toString());
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _favSelected() async {
    try {
      print("Token..." + dataId.toString());

      var response = await dio.post(Const.wishListAdd,
          options: Options(headers: {"Authorization": "Bearer $token"}),
          queryParameters: {"restaurant_id": dataId.toString()});
      print("response data in favourite..." + response.data.toString());
      if (response.data["state"] == 0) {
        showCustomToast(response.data["message"]);
        setState(() {
          _resturentLike = !_resturentLike;
        });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _favRemove() async {
    try {
      var response = await dio.delete(Const.removeWishList,
          options: Options(headers: {"Authorization": "Bearer $token"}),
          queryParameters: {"restaurant_id": dataId});
      print("response of remove button..." + response.data.toString());
      if (response.data["state"] == 0) {
        showCustomToast(response.data["message"]);
        setState(() {
          _resturentLike = false;
        });
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _viewCartShow(
      bool dataAdded, String foodId, String foodAmt, String qty) async {
    print("dataAdded..." + dataAdded.toString());
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // var id = pref.getString("id");
    // print("Id of cart..." + id.toString());
    if (dataAdded == true) {
      var param = "?user_id=" +
          id.toString() +
          "&food_id=" +
          foodId +
          "&food_amount=" +
          foodAmt +
          "&quantity=" +
          qty +
          "&restaurant_id=" +
          resturentId.toString();
      var url = Const.addToCart + param;
      print("Url..." + url.toString());
      var response = await dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response data in add Cart..." + response.data.toString());
      return GetCartModel.fromJson(response.data);
    } else {}
    setState(() {
      _dataAdded = dataAdded;
    });
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

  _getCartShow() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      id = pref.getString("id");
      var params = "?user_id=" +
          id.toString() +
          "&restaurant_id=" +
          resturentId.toString();
      print("params..." + params.toString());
      var response = await dio.post(Const.getCart + params,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      allCartData = response.data["respData"];
      print("respons body...in getCart..." + response.data.toString());
      if (response.data['state'] == 1) {
        setState(() {
          _dataAdded = false;
          getCartLoad = true;
        });
      } else {
        setState(() {
          _dataAdded = true;
          getCartLoad = true;
        });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
