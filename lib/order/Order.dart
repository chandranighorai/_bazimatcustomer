import 'package:bazimat/order/CurrentOrder.dart';
import 'package:bazimat/order/DeliveryBoyTrack.dart';
import 'package:bazimat/order/OrderList.dart';
import 'package:bazimat/order/PastOrder.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({Key key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  //TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 2, vsync: this);
  // }

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () => {Navigator.pop(context)},
            ),
            title: InkWell(
              onTap: () {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DeliveryBoyTrack()));
              },
              child: Text(
                "Order",
                style: TextStyle(color: Colors.black),
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  //text: Text("Current Order"),
                  child: Text("Current Order",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ),
                Tab(
                  child: Text("Past Order",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                )
              ],
            ),
          ),
          body: TabBarView(children: [CurrentOrder(), PastOrder()])),
    );
  }
}
