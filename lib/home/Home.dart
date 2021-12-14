import 'package:bazimat/all%20resturant/AllResturent.dart';
import 'package:bazimat/home/Couponlist.dart';
import 'package:bazimat/home/Cuisin.dart';
import 'package:bazimat/home/ListData.dart';
import 'package:bazimat/home/OfferModel.dart';
import 'package:bazimat/navigation/Navigation.dart';
import 'package:bazimat/home/Resturent.dart';
import 'package:bazimat/home/TopPick.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffFoldState = GlobalKey<ScaffoldState>();
  var dio = Dio();
  bool _serviceAvailable;
  var zone;
  bool _bannerLoad;

  List<String> bannerList = [];
  final offerList = [
    "images/banner1.png",
    "images/banner2.jpg",
    "images/banner3.png"
  ];
  var listArr = [
    {"pic": "images/list1.png", "name": "Groceries by Instamart"},
    {"pic": "images/list2.png", "name": "Anything Delivered"},
    {"pic": "images/list3.png", "name": "Wine Shop"},
    {"pic": "images/list4.png", "name": "Freash meat & sea food"},
    {"pic": "images/list1.png", "name": "Groceries by Instamart"},
    {"pic": "images/list2.png", "name": "Anything Delivered"},
    {"pic": "images/list3.png", "name": "Wine Shop"},
    {"pic": "images/list4.png", "name": "Freash meat & sea food"}
  ];
  var topArr = [
    {"pic": "images/arsalan.jpg", "name": "Arsalan", "time": "30 mins"},
    {"pic": "images/naturals.jpg", "name": "Naturals", "time": "15 mins"},
    {"pic": "images/cookie.jpg", "name": "Cookie Jar", "time": "22 mins"},
    {"pic": "images/wow.jpg", "name": "Wow Momo", "time": "40 mins"},
    {"pic": "images/arsalan.jpg", "name": "Arsalan", "time": "30 mins"},
    {"pic": "images/naturals.jpg", "name": "Naturals", "time": "15 mins"},
    {"pic": "images/cookie.jpg", "name": "Cookie Jar", "time": "22 mins"},
    {"pic": "images/wow.jpg", "name": "Wow Momo", "time": "40 mins"},
  ];
  var cuisin = [
    {"pic": "images/pasta.jpg", "name": "Pasta"},
    {"pic": "images/pizza.jpg", "name": "Pizza"},
    {"pic": "images/fries.jpg", "name": "French Fries"},
    {"pic": "images/pasta.jpg", "name": "Pasta"},
    {"pic": "images/pizza.jpg", "name": "Pizza"},
    {"pic": "images/fries.jpg", "name": "French Fries"}
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _serviceAvailable = true;
    _bannerLoad = false;
    _getZoneId();
  }

  @override
  Widget build(BuildContext context) {
    return _serviceAvailable
        ? Scaffold(
            key: scaffFoldState,
            drawer: Navigation(),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => scaffFoldState.currentState.openDrawer(),
                icon: Icon(Icons.menu),
                color: AppColors.buttonColor,
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              title: Container(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.buttonColor,
                        ),
                        Text(
                          "ndita".toUpperCase(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),
                      ],
                    ),
                    Container(
                      //width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        "SDF Building, GP Block, Sector v",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width * 0.03),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                //height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03,
                    bottom: MediaQuery.of(context).size.width * 0.02),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bannerLoad == false
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : carouselSlider(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.42,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: ListView.builder(
                          //padding: EdgeInsets.only(left: 0, right: 0),
                          scrollDirection: Axis.horizontal,
                          itemCount: listArr.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ListData(listArr: listArr[index]);
                          }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      "Top Picks For You",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.45,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: ListView.builder(
                          //padding: EdgeInsets.only(left: 0, right: 0),
                          scrollDirection: Axis.horizontal,
                          itemCount: topArr.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return TopPicks(topArr: topArr[index]);
                          }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                        height: MediaQuery.of(context).size.width * 0.35,
                        width: MediaQuery.of(context).size.width,
                        child: offerSlider1()),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Text(
                      "Coupons For You",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.27,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: offerList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CouponList(couponL: offerList[index]);
                          }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Text(
                      "Popular Cuisines Around You",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.38,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: cuisin.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CuisinList(cuisin: cuisin[index]);
                          }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Text(
                      "All Resturants Nearby",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      "Discover unique tastes near you",
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width * 0.03),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                      //height: MediaQuery.of(context).size.width * 0.75,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Resturent();
                          }),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.02,
                    // ),
                    Container(
                      alignment: Alignment.center,
                      // padding:
                      //     EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                      //width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MediaQuery.of(context).size.width * 50))),
                      child: TextButton(
                        child: Text("See All Resturants".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllResturant())),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: Text(zone.data["message"]),
            ),
          );
  }

  CarouselSlider carouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true, viewportFraction: 1.0, enlargeCenterPage: true),
      items: bannerList.map((items) {
        print("Items..." + items.toString());
        Container(
          decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width * 0.02)),
              image: DecorationImage(
                  image: NetworkImage(items), fit: BoxFit.fill)),
          // child: CachedNetworkImage(
          //   Placeholder:(context,url)=> CircularProgressIndicator(),imageUrl:items
          // ),
        );
      }).toList(),
    );
  }

  CarouselSlider offerSlider1() {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: false, viewportFraction: 1.0),
      items: offerList
          .map((item) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(item), fit: BoxFit.fill)),
              ))
          .toList(),
    );
  }

  _getZoneId() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var response = preferences.getString("token");
      var latitude = preferences.getString("latitude");
      var longitude = preferences.getString("longitude");
      print("Latitude..." + preferences.getString("latitude"));
      print("Longitude..." + preferences.getString("longitude"));
      print("Token..." + response.toString());
      //var getZone = "?lat=" + latitude + "&lng=" + longitude;
      var getZone =
          "?lat=" + "22.584990444621944" + "&lng=" + "88.4202935801241";
      print("FullUrl.." + Const.zoneId + getZone);
      var zoneUrl = Const.zoneId + getZone;
      zone = await dio.get(zoneUrl);
      print("ZoneBody..." + zone.data.toString());
      if (zone.data["state"] == 1) {
        // showCustomToast(zone.data["message"]);
        setState(() {
          _serviceAvailable = !_serviceAvailable;
        });
      } else {
        _getBanner(zone.data["zone_id"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getBanner(int zoneId) async {
    print("Zoneid..." + zoneId.toString());
    try {
      //var formData = {"zoneId": "2"};
      var bannerResponse = await dio.get(Const.banner,
          options: Options(headers: {"zoneId": zoneId}));
      print("banner Data..." + bannerResponse.data.toString());
      if (bannerResponse.data["state"] == 0) {
        var banners = bannerResponse.data["banners"];
        for (int i = 0; i < banners.length; i++) {
          print("bannerImage...1.." +
              bannerResponse.data["bannerimgpath"].toString());
          var bannerImage =
              bannerResponse.data["bannerimgpath"] + banners[i]["image"];
          print("bannerImage..." + bannerImage.toString());
          // var dd = bannerImage.toString().replaceAll("https", "http");
          // print("DD..." + dd.toString());
          setState(() {
            bannerList.add(bannerImage.toString());
          });
        }
        print("bannerList..." + bannerList.toString());
        setState(() {
          _bannerLoad = true;
        });
        return OffersModel.fromJson(bannerResponse.data);
      } else {
        showCustomToast("No Banner");
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
