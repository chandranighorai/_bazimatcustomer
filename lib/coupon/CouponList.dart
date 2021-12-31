import 'package:bazimat/home/CouponModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class CouponList extends StatefulWidget {
  CouponListErrors couponList;
  double payPrice;
  CouponList({this.couponList, this.payPrice, Key key}) : super(key: key);

  @override
  _CouponListState createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 15.0),
      //height: 250,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                decoration: BoxDecoration(
                    color: AppColors.cartPage,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.width * 0.02))),
                child: Text("${widget.couponList.code}".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.03)),
              ),
              Spacer(),
              widget.payPrice >=
                      double.parse(widget.couponList.minPurchase.toString())
                  ? InkWell(
                      onTap: () {
                        var price;
                        if (widget.couponList.discountType == "percent") {
                          price =
                              (widget.payPrice * widget.couponList.discount) /
                                  100;
                        } else {
                          price = widget.couponList.discount;
                        }
                        print("Price..." + price.toString());
                        Navigator.of(context)
                            .pop({"price": price, "cuponApplied": true});
                      },
                      child: Text(
                        "Apply".toUpperCase(),
                        style: TextStyle(color: AppColors.applyText),
                      ),
                    )
                  : Text(
                      "Apply".toUpperCase(),
                      style: TextStyle(
                          color: AppColors.applyText.withOpacity(0.2)),
                    )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Text(
              "Get ${widget.couponList.discount}${(widget.couponList.discountType == "percent") ? "%" : "/-"} discount"),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.04,
          ),
          Text(
            "Maximum discount up to \u20B9${widget.couponList.maxDiscount} on orders above \u20B9${widget.couponList.minPurchase}",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: Colors.grey),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.width * 0.02,
          // ),
          // Text(
          //   "+ more".toUpperCase(),
          //   style: TextStyle(
          //       color: AppColors.moreText,
          //       fontSize: MediaQuery.of(context).size.width * 0.02),
          // )
        ],
      ),
    );
  }
}
