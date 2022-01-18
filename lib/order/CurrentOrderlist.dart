import 'package:bazimat/order/CurrentOrderModel.dart';
import 'package:bazimat/order/OrderStatus.dart';
import 'package:flutter/material.dart';

class CurrentOrderList extends StatelessWidget {
  CurrentOrderModel orderData;
  CurrentOrderList({this.orderData, Key key}) : super(key: key);
  List list = [
    "Pending",
    "Accepted",
    "Confirmed",
    "Processing",
    "Handover",
    "Picked Up",
    "Deliver",
    "Cancel",
    "Refund Request",
    "Refund"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Food Name: ${orderData.foodId}",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 1.2,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: MediaQuery.of(context).size.width * 0.04,
                    childAspectRatio: MediaQuery.of(context).size.height /
                        MediaQuery.of(context).size.width *
                        1.2,
                  ),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderStatus(
                        orderStatus: list[index], orderData: orderData);
                  }),
              // child: GridView.count(
              //   crossAxisCount: 2,
              //   mainAxisSpacing: MediaQuery.of(context).size.width * 0.06,
              //   crossAxisSpacing: MediaQuery.of(context).size.width * 0.06,
              //   childAspectRatio: MediaQuery.of(context).size.height /
              //       MediaQuery.of(context).size.width *
              //       2,
              //   children: [
              //     Container(
              //       alignment: Alignment.center,
              //       color: Colors.amber,
              //       child: Text(
              //         "Pending",
              //         //textAlign: TextAlign.center,
              //       ),
              //     ),
              //     Container(
              //       alignment: Alignment.center,
              //       color: Colors.amber,
              //       child: Text("Accepted"),
              //     ),
              //     Container(
              //       alignment: Alignment.center,
              //       color: Colors.amber,
              //       child: Text(
              //         "Pending",
              //         //textAlign: TextAlign.center,
              //       ),
              //     ),
              //     Container(
              //       alignment: Alignment.center,
              //       color: Colors.amber,
              //       child: Text("Accepted"),
              //     )
              //   ],
              // ),
            )
          ],
        ),
      ),
    );
  }
}
