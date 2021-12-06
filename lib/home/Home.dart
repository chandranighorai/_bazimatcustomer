import 'package:bazimat/all%20resturant/AllResturent.dart';
import 'package:bazimat/home/Couponlist.dart';
import 'package:bazimat/home/Cuisin.dart';
import 'package:bazimat/home/ListData.dart';
import 'package:bazimat/navigation/Navigation.dart';
import 'package:bazimat/home/Resturent.dart';
import 'package:bazimat/home/TopPick.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffFoldState = GlobalKey<ScaffoldState>();
  final bannerList = [
    "images/banner.jpg",
    "images/banner2.jpg",
    "images/banner3.png"
  ];
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                        fontSize: MediaQuery.of(context).size.width * 0.05),
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
              carouselSlider(),
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
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllResturant())),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  CarouselSlider carouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true, viewportFraction: 1.0, enlargeCenterPage: true),
      items: bannerList
          .map((items) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.width * 0.02)),
                    image: DecorationImage(
                        image: AssetImage(items), fit: BoxFit.fill)),
              ))
          .toList(),
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
}
