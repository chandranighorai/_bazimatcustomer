import 'package:bazimat/home/ResturentModel.dart';
import 'package:bazimat/popular%20cuisin/Recomended.dart';
import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/sub%20list/SubListModel.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CuisinDetails extends StatefulWidget {
  Restaurants resturentData;
  RestaurantsSub listData;
  var distance, duration;
  CuisinDetails(
      {this.resturentData, this.listData, this.distance, this.duration});

  @override
  _CuisinDetailsState createState() => _CuisinDetailsState();
}

class _CuisinDetailsState extends State<CuisinDetails> {
  Future<RecommendedModel> _recommendedProduct;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _recommendedProduct = _getAllRecommendedProduct();
  }

  @override
  Widget build(BuildContext context) {
    print("ResturentName..." + widget.resturentData.name.toString());
    print("ResturentName..." + widget.resturentData.id.toString());

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
          Icon(
            Icons.favorite,
            color: Colors.grey,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          )
        ],
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
                      "${widget.resturentData.name}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Text(
                      "${widget.resturentData.description}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            "${widget.resturentData.address}",
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
                                      text: "${widget.resturentData.avgRating}",
                                      style: TextStyle(color: Colors.black))
                                ])),
                                Text(
                                  "${widget.resturentData.ratingCount}+ ratings",
                                  style: TextStyle(color: Colors.grey),
                                )
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
                                  "${widget.resturentData.offerprice}",
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
              Container(
                //height: 420,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    FutureBuilder(
                      initialData: null,
                      future: _recommendedProduct,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var products = snapshot.data.errors.products;
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
                                    return Recommended(
                                        productList: products[index],
                                        imageUrl: imagePath);
                                  });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
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

  Future<RecommendedModel> _getAllRecommendedProduct() async {
    try {
      var params = "?restaurant_id=" + widget.resturentData.id.toString();
      var url = Const.resturentDetails + params;
      var response = await dio.get(url);
      print("response Body... in rrecommeded" + response.data.toString());
      if (response.data["state"] == 0) {
        return RecommendedModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
