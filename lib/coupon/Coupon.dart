import 'package:bazimat/coupon/CouponList.dart';
import 'package:bazimat/home/CouponModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Coupon extends StatefulWidget {
  double payPrice;
  // CouponListErrors data;
  // Function() couponList;
  Coupon({
    this.payPrice,
    Key key,
  }) : super(key: key);

  @override
  _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  Future<CouponModel> _getAllCoupon;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _getAllCoupon = _getCouponList();
  }

  @override
  Widget build(BuildContext context) {
    //print("datatList..." + widget.couponList.runtimeType.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Apply Coupons",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02),
                      //color: Colors.red,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Enter Coupon Code',
                            border: InputBorder.none),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: null,
                        child: Text(
                          "Apply".toUpperCase(),
                          style: TextStyle(color: AppColors.applyText),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: Text(
                "Available coupons".toUpperCase(),
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              initialData: null,
              future: _getAllCoupon,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var couponList = snapshot.data.errors;
                  return ListView.builder(
                      itemCount: couponList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CouponList(
                            couponList: couponList[index],
                            payPrice: widget.payPrice);
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  Future<CouponModel> _getCouponList() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      var zoneId = pref.getString("zoneId");
      var response = await dio.get(Const.couponList,
          options: Options(
              headers: {"Authorization": "Bearer $token", "zoneId": zoneId}));
      print("response Body in Coupon List..." + zoneId.toString());
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
}
