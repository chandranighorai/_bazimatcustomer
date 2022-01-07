import 'package:bazimat/add%20cuisin/AddCuisin.dart';
import 'package:bazimat/home/ConfigModel.dart';
import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Recommended extends StatefulWidget {
  Products productList;
  var imageUrl,
      duration,
      distance,
      resturentName,
      resturentAddress,
      resturentOfferPrice;
  Function() couponList;
  Recommended(
      {this.productList,
      this.imageUrl,
      this.duration,
      this.distance,
      this.resturentName,
      this.resturentAddress,
      this.resturentOfferPrice,
      Key key,
      this.couponList});

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  var dio = Dio();
  var configData;
  bool configLoad;
  @override
  void initState() {
    super.initState();
    configData = false;
    _getConfig();
  }

  @override
  Widget build(BuildContext context) {
    print("productDetails..." + widget.productList.taxType.toString());
    print("productDetails..." + widget.productList.name.toString());

    var image = widget.imageUrl + widget.productList.image;
    print("Image..." + image.toString());
    print("hjhj..." + image.toString());

    return 
    configData == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : 
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCuisin(
                          duration: widget.duration,
                          distance: widget.distance,
                          product: widget.productList,
                          imageUrl: widget.imageUrl,
                          resturentName: widget.resturentName,
                          resturenrAddr: widget.resturentAddress,
                          resturentPrice: widget.resturentOfferPrice,
                          configData: configData,
                          couponList: widget.couponList)));
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
                              Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.04,
                                      right: MediaQuery.of(context).size.width *
                                          0.04,
                                      top: MediaQuery.of(context).size.width *
                                          0.01,
                                      bottom:
                                          MediaQuery.of(context).size.width *
                                              0.01),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01))),
                                  child: Text(
                                    "ADD",
                                    style: TextStyle(
                                        color: AppColors.addTextColor),
                                  ))
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
}
