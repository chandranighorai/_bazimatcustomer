import 'dart:ui';

import 'package:bazimat/add%20cuisin/AddQuantity.dart';
import 'package:bazimat/add%20cuisin/Cart.dart';
import 'package:bazimat/coupon/Coupon.dart';
import 'package:bazimat/home/ConfigModel.dart';
import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class AddCuisin extends StatefulWidget {
  var duration,
      distance,
      imageUrl,
      resturentName,
      resturenrAddr,
      resturentPrice,
      configData;
  Products product;
  Function() couponList;
  AddCuisin(
      {this.duration,
      this.distance,
      this.imageUrl,
      this.resturentName,
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
  @override
  void initState() {
    super.initState();
    couponApplied = false;
    couponPrice = 0.0;
    _itemUpdate(widget.product.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    // print("Shipping Charge...." +
    //     widget.configData["per_km_shipping_charge"].toString());
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
                            "${widget.distance}",
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
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
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
                              Text(
                                "Bidhannagar",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                              Text(
                                "${widget.duration}",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Change".toUpperCase(),
                          style: TextStyle(
                              color: AppColors.cartPage,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.width * 0.00,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cart()));
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

  _itemUpdate(String productPrice) {
    // print("productPrice..." + productPrice.toString());
    // print("productPrice..." +
    //     widget.configData["per_km_shipping_charge"].toString());
    setState(() {
      var distanceCal = widget.distance.split(" ");
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
}
