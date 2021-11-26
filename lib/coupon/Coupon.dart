import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class Coupon extends StatefulWidget {
  const Coupon({Key key}) : super(key: key);

  @override
  _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0, bottom: 15.0),
                        //height: 250,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.02),
                                  decoration: BoxDecoration(
                                      color: AppColors.cartPage,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02))),
                                  child: Text("unicard150".toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03)),
                                ),
                                Spacer(),
                                Text(
                                  "Apply".toUpperCase(),
                                  style: TextStyle(color: AppColors.applyText),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Text("Get 50% discount using Uni Pay 1/3rd Card"),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.04,
                            ),
                            Text(
                              "Maximum discount up to \u20B9200 on orders above \u20B9400",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              "+ more".toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.moreText,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.02),
                            )
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
