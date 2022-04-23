import 'package:bazimat/all%20resturant/AllResturent.dart';
import 'package:bazimat/all%20resturant/AllResturentList.dart';
import 'package:bazimat/home/CampaignBannerModel.dart';
import 'package:bazimat/home/CampaignDetailsModel.dart';
import 'package:bazimat/home/CategoryModel.dart';
import 'package:bazimat/home/ConfigModel.dart';
import 'package:bazimat/home/CouponModel.dart';
import 'package:bazimat/home/Couponlist.dart';
import 'package:bazimat/home/Cuisin.dart';
import 'package:bazimat/home/ListData.dart';
import 'package:bazimat/home/OfferModel.dart';
import 'package:bazimat/home/PopularResturentModel.dart';
import 'package:bazimat/home/ResturentModel.dart';
import 'package:bazimat/login/Login.dart';
import 'package:bazimat/navigation/Navigation.dart';
import 'package:bazimat/home/Resturent.dart';
import 'package:bazimat/home/TopPick.dart';
import 'package:bazimat/sign%20up/userPreferences.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:carousel_slider/carousel_slider.dart';
//import 'package:carousel_slider/carousel_options.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_pro/carousel_pro.dart';

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
  int zoneId;
  bool _bannerLoad;
  var _shortAddress, _longAddress, latitude, longitude;
  var _resturentData;
  var resturentList;
  bool _resturentLoad;
  var popularList, cuisinImagePath;
  bool _popularLoad;
  bool _campaignLoad;
  bool _topPicksLoad;
  var _popularList;
  List<CampaignDetailsRestaurants> _campaignDetailsList;

  //final bannerList1 = ["images/banner1.png", "images/banner1.png"];
  Future<CategoryModel> _allCategory;
  Future<ResturentModel> _resturentList;
  Future<PopularResturentModel> _popularResturent;
  List<Banners> bannerList;
  List<CampaignBannerErrors> campaignList;
  Future<CouponModel> _getCouponList;
  var _coverImage, token;
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
    bannerList = [];
    campaignList = [];
    _campaignDetailsList = [];
    _serviceAvailable = true;
    _bannerLoad = false;
    _resturentLoad = false;
    _popularLoad = false;
    _campaignLoad = false;
    _topPicksLoad = false;
    _getZoneId();
    _allCategory = _getCategoryList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
              title: _bannerLoad
                  ? Container(
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
                                "$_shortAddress".toUpperCase(),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                            ],
                          ),
                          Container(
                            //width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              "$_longAddress",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.02),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      "...",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
            ),
            body: (_bannerLoad == false &&
                    _topPicksLoad == false &&
                    _campaignLoad == false &&
                    _popularLoad == false &&
                    _resturentLoad == false)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
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
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.45,
                                  width: MediaQuery.of(context).size.width,
                                  child: carouselSliderBanner()),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.42,
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.amber,
                            child: FutureBuilder(
                              initialData: null,
                              future: _allCategory,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                print("Snapshot..." +
                                    snapshot.hasData.toString());
                                if (snapshot.hasData) {
                                  var categories = snapshot.data.errors;
                                  var imagePath = snapshot.data.categoryimgpath;
                                  print(
                                      "Categories...." + categories.toString());
                                  print("imagepath..." +
                                      snapshot.data.categoryimgpath);
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: categories.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        print("categories index..." +
                                            categories[index].toString());
                                        return ListData(
                                            listArr: categories[index],
                                            imageUrl: imagePath,
                                            zoneIdVal: zoneId,
                                            latitude: latitude,
                                            longitude: longitude);
                                      });
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.02,
                          ),
                          _topPicksLoad == true
                              ? _popularList.length == 0
                                  ? SizedBox()
                                  : Text(
                                      "Top Picks For You",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                    )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04,
                          ),
                          _topPicksLoad == true
                              ? _popularList.length == 0
                                  ? SizedBox()
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.45,
                                      width: MediaQuery.of(context).size.width,
                                      //color: Colors.amber,
                                      child: FutureBuilder(
                                        initialData: null,
                                        future: _popularResturent,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          print("snapshot...in popular..." +
                                              snapshot.hasData.toString());
                                          if (snapshot.hasData) {
                                            var dataList = snapshot.data.errors;
                                            print("DAtaList..." +
                                                dataList.toString());
                                            var imagePath =
                                                snapshot.data.coverimgpath;
                                            print("Datalist..." +
                                                dataList.toString());
                                            return ListView.builder(
                                                //padding: EdgeInsets.only(left: 0, right: 0),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: dataList.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return TopPicks(
                                                    topArr: dataList[index],
                                                    imgPath: imagePath,
                                                    latitude: latitude,
                                                    longitude: longitude,
                                                  );
                                                });
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.width * 0.02,
                          // ),
                          // Container(
                          //     height: MediaQuery.of(context).size.width * 0.35,
                          //     width: MediaQuery.of(context).size.width,
                          //     child: _campaignLoad == false
                          //         ? Center(
                          //             child: CircularProgressIndicator(),
                          //           )
                          //         : offerSlider1()),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04,
                          ),
                          token == null
                              ? SizedBox()
                              : Text(
                                  "Coupons For You",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                ),
                          token == null
                              ? SizedBox()
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                          token == null
                              ? SizedBox()
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.27,
                                  width: MediaQuery.of(context).size.width,
                                  //color: Colors.amber,
                                  child: FutureBuilder(
                                    initialData: null,
                                    future: _getCouponList,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        var couponListData =
                                            snapshot.data.errors;
                                        var couponImage =
                                            snapshot.data.coverimg;
                                        print("Coupon in Future..." +
                                            couponListData.toString());
                                        return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: couponListData.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return CouponList(
                                                  couponL:
                                                      couponListData[index],
                                                  couponImage: couponImage);
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Text(
                            "Popular Cuisines Around You",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.38,
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.amber,
                            child: _popularLoad == false
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: popularList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CuisinList(
                                          cuisin: popularList[index],
                                          cuisinPath: cuisinImagePath,
                                          latitude: latitude,
                                          longitude: longitude,
                                          zoneId: zoneId);
                                    }),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Text(
                            "All Resturants Nearby",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text(
                            "Discover unique tastes near you",
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Container(
                            //height: MediaQuery.of(context).size.width * 0.75,
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.amber,
                            child: FutureBuilder(
                              initialData: null,
                              future: _resturentList,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                print("snapshot... in resturent..." +
                                    snapshot.hasData.toString());
                                if (snapshot.hasData) {
                                  _resturentData =
                                      snapshot.data.errors.restaurants;
                                  _coverImage = snapshot.data.coverimgpath;
                                  print("ResturentData...in future..." +
                                      _resturentData.toString());
                                  // print("ResturentData...in future...all..." +
                                  //     _allResturent.toString());
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 2,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Resturent(
                                            resturentData:
                                                _resturentData[index],
                                            coverimgpath: _coverImage,
                                            latitude: latitude,
                                            longitude: longitude);
                                      });
                                } else {
                                  // _resturentData = snapshot.data.errors.restaurants;
                                  // print("resturent...." + _resturentData.toString());
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                              //child: ,
                            ),
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.width * 0.02,
                          // ),
                          // _bannerLoad == false
                          //     ? Center(
                          //         child: CircularProgressIndicator(),
                          //       )
                          //     : resturentList.length > 1
                          //         ?
                          _resturentLoad == false
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : resturentList.length > 1
                                  ? Container(
                                      alignment: Alignment.center,
                                      // padding:
                                      //     EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                      //width: MediaQuery.of(context).size.width / 1.5,
                                      decoration: BoxDecoration(
                                          color: AppColors.buttonColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      50))),
                                      child: TextButton(
                                        child: Text(
                                            "See All Resturants".toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AllResturant(
                                                      allResturentData:
                                                          _resturentData,
                                                      coverimgpath: _coverImage,
                                                      latitude: latitude,
                                                      longitude: longitude,
                                                      section: "Home",
                                                      //couponList:_getAllCoupon
                                                    ))),
                                      ),
                                    )
                                  : SizedBox()
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
  // CarouselSlider carouselSlider1() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       autoPlay: true,
  //       reverse: true,
  //       viewportFraction: 1.0,
  //       enlargeCenterPage: true,
  //       //enlargeStrategy: CenterPageEnlargeStrategy.height,
  //       //aspectRatio: 16 / 9,
  //       //height: 350,
  //     ),
  //     items: bannerList1.map((items) {
  //       print("Items..." + items.toString());
  //       Container(
  //         //height: 120, width: 120,
  //         // height: MediaQuery.of(context).size.width * 0.3,
  //         // width: MediaQuery.of(context).size.width,
  //         decoration: BoxDecoration(
  //           color: Colors.amber,
  //           // borderRadius: BorderRadius.all(
  //           //     Radius.circular(MediaQuery.of(context).size.width * 0.02)),
  //           // image: DecorationImage(
  //           //     image: AssetImage(items.toString()), fit: BoxFit.fill)
  //         ),
  //         //child: GestureDetector(child: Image.network(items.image)),
  //         // child: CachedNetworkImage(
  //         //   Placeholder:(context,url)=> CircularProgressIndicator(),imageUrl:items
  //         // ),
  //       );
  //     }).toList(),
  //   );
  // }

  offerSlider1() {
    return Carousel(
      showIndicator: false,
      autoplay: true,
      images: List.generate(campaignList.length, (index) {
        return InkWell(
          onTap: () {
            print("Id..." + campaignList[index].id.toString());
            _getCampaignResturent(campaignList[index].id.toString());
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(campaignList[index].image),
                    fit: BoxFit.fill)),
          ),
        );
      }).toList(),
      //options: CarouselOptions(autoPlay: false, viewportFraction: 1.0),
      // items: offerList
      //     .map((item) => Container(
      //           decoration: BoxDecoration(
      //               image: DecorationImage(
      //                   image: AssetImage(item), fit: BoxFit.fill)),
      //         ))
      //     .toList(),
    );
  }

  _getZoneId() async {
    try {
      print("serviceable..." + _serviceAvailable.toString());
      SharedPreferences preferences = await SharedPreferences.getInstance();
      token = preferences.getString("token");
      var fcmToken = preferences.getString("FcmToken");
      var userId = preferences.getString("id");
      print("token..." + token.toString());
      latitude = preferences.getString("latitude");
      longitude = preferences.getString("longitude");
      print("Latitude...in home..." + latitude.toString());
      print("Longitude...in home..." + longitude.toString());
      // print("Token..." + response.toString());
      //var getZone = "?lat=" + latitude + "&lng=" + longitude;
      var getZone =
          //"?lat=" + latitude.toString() + "&lng=" + longitude.toString();
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
        zoneId = zone.data["zone_id"];
        print("ZoneId.... in home..." + zoneId.toString());
        _getBanner();
        _getCampaignBanner();
        _getCustomerInfo();
        //_getCustomerUpdateFcm(token, userId);
        _getCustomerUpdateFcm(fcmToken, token, userId);
        //_getConfigDetails();
        _getCouponList = _getAllCoupon();
        _popularCuisin();
        _popularResturent = _getAllPopularResturent();
        _resturentList = _getResturentList();
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getBanner() async {
    print("Zoneid..." + zoneId.toString());
    try {
      //var formData = {"zoneId": "2"};
      var latLng = "?lat=" + "22.5697569" + "&lng=" + "88.4320485";
      var geoLocation = Const.geoLocation + latLng;
      print("GeoLocation..." + geoLocation.toString());
      var bannerResponse = await Future.wait([
        dio.get(Const.banner, options: Options(headers: {"zoneId": zoneId})),
        dio.get(geoLocation.toString())
      ]);
      // print("banner Data..." + bannerResponse[0].data.toString());
      // print("banner Data..." + bannerResponse[1].data.toString());
      // print("Address..." +
      //     bannerResponse[1].data["results"][0]["formatted_address"].toString());
      var addr =
          bannerResponse[1].data["results"][0]["formatted_address"].toString();
      _shortAddress = addr.toString().substring(0, addr.indexOf(","));
      print("_shortAddr..." + _shortAddress.toString());
      _longAddress =
          addr.toString().substring(addr.indexOf(", ") + 1).toString();
      print("newString..." + _longAddress.toString());

      // _shortAddress = _longAddress;
      // print("_longAddr..." + _shortAddress.toString());
      // _shortAddress = _longAddress.removeAt(0);
      // print("_longAddr..." + _shortAddress.toString());
      // print("_shortAddr..." + _longAddress.toString());
      if (bannerResponse[0].data["state"] == 0) {
        var banners = bannerResponse[0].data["banners"];
        for (int i = 0; i < banners.length; i++) {
          Banners banner = new Banners();
          banner.id = banners[i]["id"];
          banner.title = banners[i]["title"];
          banner.image =
              bannerResponse[0].data["bannerimgpath"] + banners[i]["image"];
          banner.type = banners[i]["type"];
          bannerList.add(banner);
        }
        print("bannerList..." + bannerList.toString());
        setState(() {
          _bannerLoad = true;
        });
        //return OffersModel.fromJson(bannerResponse.data);
      } else {
        showCustomToast("No Banner");
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  carouselSliderBanner() {
    return Carousel(
        showIndicator: false,
        autoplay: true,
        images: List.generate(bannerList.length, (index) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(bannerList[index].image.toString()),
                    fit: BoxFit.fill)),
          );
        }));
  }

  Future<CategoryModel> _getCategoryList() async {
    try {
      var response = await dio.get(Const.category);
      print("response body..." + response.data.toString());
      if (response.data["state"] == 0) {
        var error = response.data["errors"];
        print("Errors..." + error.length.toString());
        return CategoryModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  Future<ResturentModel> _getResturentList() async {
    print("zoneId intur resent List in..." + zoneId.toString());
    try {
      var response = await dio.get(Const.allResturent,
          options: Options(headers: {"zoneId": zoneId}));
      print("response statusCode..." + response.statusCode.toString());
      print("response body in resturent List..." + response.data.toString());
      if (response.data["state"] == 0) {
        resturentList = response.data["errors"]["restaurants"];
        print("00..." + resturentList.length.toString());
        setState(() {
          _resturentLoad = true;
        });
        return ResturentModel.fromJson(response.data);
      }
      // _getDistance(response.data["errors"]["restaurants"][0]["latitude"],
      //     response.data["errors"]["restaurants"][0]["longitude"]);
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _popularCuisin() async {
    try {
      var response = await dio.get(Const.popularCuisin,
          options: Options(headers: {"zoneId": zoneId}));
      print("Responsebody... in popular" + response.data.toString());
      if (response.data["state"] == 0) {
        popularList = response.data["errors"]["products"];
        print("Popular cuisin..." + popularList.toString());
        cuisinImagePath = response.data["proimgpath"];
        setState(() {
          _popularLoad = true;
        });
      } else {
        showCustomToast(response.data["errors"][0]["message"].toString());
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  Future<PopularResturentModel> _getAllPopularResturent() async {
    try {
      var response = await dio.get(Const.popularResturent,
          options: Options(headers: {"zoneId": zoneId}));
      print("popular resturent in Home..." + response.data.toString());
      if (response.data["state"] == 0) {
        _popularList = response.data["errors"];
        print("popularList..." + _popularList.toString());
        setState(() {
          _topPicksLoad = true;
        });
        return PopularResturentModel.fromJson(response.data);
      } else {
        showCustomToast(response.data["errors"][0]["message"].toString());
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getCampaignBanner() async {
    try {
      var response = await dio.get(Const.campaignBasic,
          options: Options(headers: {"zoneId": zoneId}));
      print("response statusCode..." + response.statusCode.toString());
      print("response Campaign body..." + response.data.toString());
      if (response.data["state"] == 0) {
        var campaignBanner = response.data["errors"];
        var imgUrl = response.data["campaign_image_url"];
        for (int j = 0; j < campaignBanner.length; j++) {
          CampaignBannerErrors camgBanner = new CampaignBannerErrors();
          camgBanner.id = response.data["errors"][j]["id"];
          camgBanner.title = response.data["errors"][j]["title"];
          camgBanner.image = imgUrl + response.data["errors"][j]["image"];
          campaignList.add(camgBanner);
        }
        setState(() {
          _campaignLoad = true;
        });
        print("CampaignList..." + campaignList.toString());
      } else {
        showCustomToast(response.data["errors"][0]["message"].toString());
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getCampaignResturent(String id) async {
    try {
      _campaignDetailsList.clear();
      var params = "?basic_campaign_id=" + id;
      var url = Const.campaignDetails + params;
      var response =
          await dio.get(url, options: Options(headers: {"zoneId": zoneId}));
      if (response.data["state"] == 0) {
        var resturent = response.data["errors"]["restaurants"];
        var imagePath = response.data["restaurant_cover_imge"];
        for (int i = 0; i < resturent.length; i++) {
          CampaignDetailsRestaurants campainDetails =
              new CampaignDetailsRestaurants();
          campainDetails.id = resturent[i]["id"];
          campainDetails.name = resturent[i]["name"];
          campainDetails.phone = resturent[i]["phone"];
          campainDetails.email = resturent[i]["email"];
          campainDetails.logo = resturent[i]["logo"];
          campainDetails.latitude = resturent[i]["latitude"];
          campainDetails.longitude = resturent[i]["longitude"];
          campainDetails.address = resturent[i]["address"];
          campainDetails.coverPhoto = resturent[i]["cover_photo"];
          campainDetails.description = resturent[i]["description"];
          campainDetails.offerprice = resturent[i]["offerprice"];
          campainDetails.discount = resturent[i]["discount"];
          campainDetails.avgRating = resturent[i]["avg_rating"];
          campainDetails.ratingCount = resturent[i]["rating_count"];
          _campaignDetailsList.add(campainDetails);
        }
        print("campaignDetails..." + _campaignDetailsList.toString());
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => AllResturant(
        //             allCampaignData: _campaignDetailsList,
        //             coverimgpath: imagePath,
        //             latitude: latitude,
        //             longitude: longitude,
        //section: "campaign")));
      } else {
        showCustomToast(response.data["errors"][0]["message"].toString());
      }
      print("campaignDetails..." + response.data.toString());
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getCustomerInfo() async {
    try {
      var pref = await SharedPreferences.getInstance();
      var name = pref.getString("fName");
      var token = pref.getString("token");
      print("Token..." + token.toString());
      print("Token..." + name.toString());
      print("Token..." + Const.customerInfo.toString());
      var response = await dio.get(Const.customerInfo,
          options: Options(headers: {
            "Content-Type": "application/json",
            //'Accept': 'application/json',
            "Authorization": "Bearer $token"
          })
          // queryParameters: {
          //   "Authorization": {
          //     {"Bearer Token": token.toString()}
          //   }
          // },
          // options: Options(headers: {
          //   "Authorization": {"Bearer Token": token.toString()}
          // }
          // )
          );
      print("Token..." + response.data["error"]["agestatus"].toString());
      print("age data...." + response.data.toString());
      if (response.data["state"] == 0) {
        saveUserPref(
            token,
            response.data["error"]["id"].toString(),
            response.data["error"]["f_name"],
            response.data["error"]["l_name"],
            response.data["error"]["phone"],
            response.data["error"]["email"],
            response.data["error"]["agestatus"].toString(),
            zoneId.toString());
        // pref.setString("Id", response.data["error"]["id"]);
        // pref.setString("FName", response.data["error"]["f_name"]);
        // pref.setString("LName", response.data["error"]["l_name"]);
        // pref.setString("Phone", response.data["error"]["phone"]);
        // pref.setString("Phone", response.data["error"]["phone"]);
        //return CustomerInfoError.fromJson(response.data);
      }
      print("response body...in customerInfo..." + response.data.toString());
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  Future<CouponModel> _getAllCoupon() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      var response = await dio.get(Const.couponList,
          options: Options(
              headers: {"Authorization": "Bearer $token", "zoneId": zoneId}));
      print("response Body in Coupon List..." + response.data.toString());
      if (response.data["state"] == 0) {
        return CouponModel.fromJson(response.data);
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getCustomerUpdateFcm(String fcmToken, String token, String userId) async {
    try {
      print("Url in customer Fcm..." + fcmToken.toString());
      print("Url in customer Fcm..." + token.toString());
      var param =
          "?user_id=" + userId.toString() + "&fcm_token=" + fcmToken.toString();
      var url = Const.updateCustomerFcm + param;
      print("Url in customer Fcm..." + url.toString());
      var response = await dio.put(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response data..." + response.data.toString());
      if (response.data["state"] == 0) {
        //showCustomToast(response.data["message"].toString());
        print("response data..." + response.data.toString());
      } else {
        showCustomToast(response.data["errors"][0]["message"].toString());
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  // _getConfigDetails() async {
  //   try {
  //     var response = await dio.get(Const.config);
  //     print("response of Config..." + response.data.toString());
  //     return Configmodel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     print(e.toString());
  //   }
  // }

  //void _getCouponList() {}

  // _getDistance(String lat, String lng) async {
  //   try {
  //     var params = "?";
  //     params += "origin_lat=" + latitude + "&origin_lng=" + longitude;
  //     params += "&destination_lat=" + lat + "&destination_lng=" + lng;
  //     var url = Const.distanceApi + params;
  //     print("url..." + url.toString());
  //   } on DioError catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<bool> _onBackPressed() {
  //   showAlertDialogWithCancel(context, "Are you sure?", () async {
  //     Navigator.pop(context);
  //   });
  // }
}
