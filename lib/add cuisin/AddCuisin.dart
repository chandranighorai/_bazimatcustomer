import 'package:bazimat/add%20cuisin/AddQuantity.dart';
import 'package:bazimat/add%20cuisin/Cart.dart';
import 'package:bazimat/address%20book/AddAddress.dart';
import 'package:bazimat/coupon/Coupon.dart';
import 'package:bazimat/home/ConfigModel.dart';
import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:bazimat/util/Const.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCuisin extends StatefulWidget {
  var duration,
      distance,
      resturentLat,
      resturentLng,
      imageUrl,
      resturentName,
      resturentId,
      resturenrAddr,
      resturentPrice,
      configData;
  Products product;
  Function() couponList;
  AddCuisin(
      {this.duration,
      this.distance,
      this.resturentLat,
      this.resturentLng,
      this.imageUrl,
      this.resturentName,
      this.resturentId,
      this.resturenrAddr,
      this.resturentPrice,
      this.configData,
      this.product,
      Key key,
      this.couponList})
      : super(key: key);

  @override
  _AddCuisinState createState() => _AddCuisinState();
}

class _AddCuisinState extends State<AddCuisin> {
  Configmodel data;
  double deliveryCharge;
  double itemPrice;
  double payPrice;
  double taxPrice;
  bool couponApplied;
  double couponPrice;
  int itemCount;
  var addressList;
  bool addressLoad, _distanceLoad;
  var duration, distance, addressLat, addressLng, token;
  var dio = Dio();
  String addr, restLat, restLng, addressType;
  @override
  void initState() {
    super.initState();
    couponApplied = false;
    addressLoad = false;
    couponPrice = 0.0;
    itemCount = 1;
    duration = widget.duration;
    distance = widget.distance;
    restLat = widget.resturentLat;
    restLng = widget.resturentLng;
    _getAddress();
    _itemUpdate(widget.product.price.toString(), itemCount);
  }

  @override
  Widget build(BuildContext context) {
    // print("Shipping Charge...." +
    //     widget.configData["per_km_shipping_charge"].toString());
    print("ResturentLat...." + widget.resturentLat.toString());
    var image = widget.imageUrl + widget.product.image;

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
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
          // padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
          child: Column(
            children: [
              AddQuantity(
                  imageUrl: image,
                  resturentName: widget.resturentName,
                  resturentAddr: widget.resturenrAddr,
                  resturentOffer: widget.resturentPrice,
                  product: widget.product,
                  refresh: _itemUpdate),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                //height: MediaQuery.of(context).size.width * 0.12,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.02,
                ),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width / 20,
                      decoration: BoxDecoration(
                          //color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage("images/discount-black.png"))),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text("Apply coupon".toUpperCase()),
                    Spacer(),
                    IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Coupon(payPrice: payPrice)))
                                .then((value) {
                              print(value.toString());
                              setState(() {
                                couponApplied = value["cuponApplied"];
                                couponPrice =
                                    double.parse(value["price"].toString());
                                payPrice =
                                    (itemPrice + deliveryCharge + taxPrice) -
                                        couponPrice;
                              });
                            }))
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                //height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02,
                  top: MediaQuery.of(context).size.width * 0.06,
                  bottom: MediaQuery.of(context).size.width * 0.06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bill Details",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.06,
                    ),
                    Row(
                      children: [
                        Text("Item Total"),
                        Spacer(),
                        Text("\u20B9$itemPrice")
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            "Delivery Fee",
                            style: TextStyle(color: AppColors.cartPage),
                          ),
                          VerticalDivider(
                              thickness: 1, color: AppColors.cartPage),
                          Text(
                            _distanceLoad == false ? "..." : "$distance",
                            style: TextStyle(color: AppColors.cartPage),
                          ),
                          Spacer(),
                          Text("\u20B9$deliveryCharge")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Divider(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    // Row(
                    //   children: [
                    //     Text("Delivery Tip"),
                    //     Spacer(),
                    //     Text(
                    //       "Add Tip",
                    //       style: TextStyle(
                    //           color: AppColors.cartPage,
                    //           fontSize:
                    //               MediaQuery.of(context).size.width * 0.03),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.03,
                    // ),
                    Row(
                      children: [
                        Text("Taxes and Charges"),
                        Spacer(),
                        Text(
                          "\u20B9$taxPrice",
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    couponApplied == false ? SizedBox() : Divider(),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.02,
                    // ),
                    couponApplied == false
                        ? SizedBox()
                        : Row(
                            children: [
                              Text("Coupon Applied"),
                              Spacer(),
                              Text(
                                "\u20B9$couponPrice",
                              )
                            ],
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Divider(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Row(
                      children: [
                        Text("To Pay"),
                        Spacer(),
                        Text("\u20B9$payPrice")
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 12,
                      height: MediaQuery.of(context).size.width * 0.08,
                      decoration: BoxDecoration(
                          //color: Colors.red,
                          image: DecorationImage(
                              image: AssetImage("images/paper.png"),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        "Please ensure your address and order details are correct. A cancellation fee will be applicable post 1 minute of placing your order.",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.08),
              Stack(
                children: [
                  Container(
                    //height: 20,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.02),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width * 0.18,
                          //color: Colors.red,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Icon(
                            Icons.location_on_outlined,
                            size: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.6,
                          //color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deliver to",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                              addressLoad == false
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : addressList.length == 0
                                      ? SizedBox()
                                      : Text(
                                          addr,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                              Text(
                                _distanceLoad == false ? "..." : "$duration",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        addressLoad == false
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : addressList.length == 0
                                ? InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             AddAddress()));
                                    },
                                    child: Text(
                                      "Add Address".toUpperCase(),
                                      style: TextStyle(
                                          color: AppColors.cartPage,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                      // )
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddAddress(
                                                  refresh:
                                                      _getChangeAddress))).then(
                                          (value) {
                                        print("Value..." +
                                            value["addressType"].toString());
                                        // print("resturentLat...Value..." +
                                        //     widget.resturentLat.toString());
                                        setState(() {
                                          addr = value["address"];
                                          addressType = value["addressType"];
                                          addressLat = value["latitude"];
                                          addressLat = value["longitude"];
                                          _distanceLoad = false;

                                          _getDistance(
                                              value["latitude"],
                                              value["longitude"],
                                              widget.resturentLat,
                                              widget.resturentLng);
                                        });
                                        print("VAlue.." + value.toString());
                                      });
                                    },
                                    child: Text(
                                      "Change".toUpperCase(),
                                      style: TextStyle(
                                          color: AppColors.cartPage,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03),
                                    ),
                                  )
                      ],
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.width * 0.02,
                      left: MediaQuery.of(context).size.width * 0.15,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.06,
                        width: MediaQuery.of(context).size.width * 0.06,
                        decoration: BoxDecoration(
                            //color: Colors.amber,
                            image: DecorationImage(
                                image: AssetImage("images/check.png"))),
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width / 2.2,
                      //color: Colors.amber,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\u20B9$payPrice",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.width * 0.01,
                          // ),
                          // Text(
                          //   "view detailed bill".toUpperCase(),
                          //   style: TextStyle(
                          //       color: AppColors.cartPage,
                          //       fontSize:
                          //           MediaQuery.of(context).size.width * 0.03),
                          // )
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cart(
                                    totalAmount: payPrice,
                                    resturentName: widget.resturentName,
                                    resturentId: widget.resturentId,
                                    duration: duration,
                                    distance: distance,
                                    address: addr,
                                    addressType: addressType,
                                    addressLat: addressLat,
                                    addressLng: addressLng,
                                    token: token,
                                    quantity: itemCount,
                                    foodID: widget.product.id)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: MediaQuery.of(context).size.width * 0.12,
                        alignment: Alignment.center,
                        color: AppColors.cartPage,
                        child: Text(
                          "Proceed To Pay",
                          style: TextStyle(color: Colors.white),
                          //textAlign: TextAlign.center,
                        ),
                      ),
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

  _itemUpdate(String productPrice, int itemcount) {
    print("productPrice..." + itemcount.toString());
    // print("productPrice..." +
    //     widget.configData["per_km_shipping_charge"].toString());
    setState(() {
      itemCount = itemcount;
      var distanceCal = distance.split(" ");
      // print("deliveryCharge..." + distanceCal.toString());
      deliveryCharge = widget.configData["per_km_shipping_charge"] *
          double.parse(distanceCal[0]);
      //print("deliveryCharge..." + deliveryCharge.toString());
      itemPrice = double.parse(productPrice);
      // print("itemPrice...." + itemPrice.toString());
      taxPrice = double.parse(widget.product.tax.toString());
      // print("taxPrice...." + taxPrice.toString());
      // print("taxPrice...." + deliveryCharge.toString());
      payPrice = (itemPrice + deliveryCharge + taxPrice) - couponPrice;
      //print("payPrice...." + payPrice.toString());
    });
  }

  _getAddress() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString("token");
      print("token..." + token.toString());
      var response = await dio.get(
        Const.addressList,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print("response body..." + response.data.toString());
      if (response.data["state"] == 0) {
        addressList = response.data["error"];
        print("addresslength..." + addressList.length.toString());
        setState(() {
          addr = addressList[0]["address"];
          addressType = addressList[0]["address_type"];
          addressLat = addressList[0]["latitude"];
          addressLng = addressList[0]["longitude"];
          addressLoad = true;
        });
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
      //addressList = response.data[""]
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getChangeAddress(String adr, String addrType, String lat, String lng) {
    print("address..." + addr.toString());
    print("address..." + lat.toString());
    print("address..." + lng.toString());
    print("address..." + addrType.toString());
    print("res_latitude..." + widget.resturentLat.toString());
    print("res_longitude..." + widget.resturentLng.toString());

    setState(() {
      addr = adr;
      addressType = addrType;
      _getDistance(lat, lng, widget.resturentLat.toString(),
          widget.resturentLng.toString());
    });
  }

  _getDistance(String lat, String lng, String resLat, String resLng) async {
    try {
      print("latitude..." + lat.toString());
      print("latitude..." + lng.toString());
      print("res_latitude..." + resLat.toString());
      print("res_longitude..." + resLng.toString());

      //  destinationLat = widget.section == "campaign"
      //     ? widget.resturent1.latitude
      //     : widget.resturent.latitude;
      // destinationLng = widget.section == "campaign"
      //     ? widget.resturent1.longitude
      //     : widget.resturent.longitude;
      var params = "?";
      params += "origin_lat=" + restLat + "&origin_lng=" + restLng;
      params += "&destination_lat=" + lat + "&destination_lng=" + lng;
      var url = Const.distanceApi + params;
      print("url..." + url.toString());
      var getDistanceResponse = await dio.get(url);
      print(
          "response statusCode..." + getDistanceResponse.statusCode.toString());
      print("response data...in getDistance..." +
          getDistanceResponse.data.toString());
      print("hjhj..." +
          getDistanceResponse.data["rows"][0]["elements"][0]["distance"]["text"]
              .toString());
      setState(() {
        _distanceLoad = true;
        distance = getDistanceResponse.data["rows"][0]["elements"][0]
                ["distance"]["text"]
            .toString();
        duration = getDistanceResponse.data["rows"][0]["elements"][0]
                ["duration"]["text"]
            .toString();
        _itemUpdate(widget.product.price.toString(), itemCount);
      });
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
