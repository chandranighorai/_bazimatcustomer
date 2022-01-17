import 'dart:ui';

import 'package:bazimat/order/pastOrderModel.dart';
import 'package:flutter/material.dart';

class PastOrderList extends StatefulWidget {
  PostOrderData listData;
  PastOrderList({this.listData, Key key}) : super(key: key);

  @override
  _PastOrderListState createState() => _PastOrderListState();
}

class _PastOrderListState extends State<PastOrderList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 3.0)
            ],
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width * 0.01))),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  //color: Colors.amber,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    "${widget.listData.foodName}",
                    // style: TextStyle(color: Colors.red),
                  ),
                ),
                Spacer(),
                Text(
                  "${widget.listData.orderStatus}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(
              "${widget.listData.deliveryAddress.address}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(
              "\u20B9${widget.listData.orderAmountRound}",
              style: TextStyle(color: Colors.black),
            ),
            Divider(),
            Text(
              "Qty: ${widget.listData.quantity}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              "November 2, 12:07 pm",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: MediaQuery.of(context).size.width / 2.5,
                //   padding: const EdgeInsets.all(8.0),
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(color: Colors.grey)),
                //   child: Text("Reorder".toUpperCase()),
                // ),
                // Spacer(),
                Container(
                  // width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(8.0),
                  //color: Colors.white,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child: Text("Rate food".toUpperCase()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
