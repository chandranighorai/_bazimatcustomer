import 'dart:async';

import 'package:bazimat/order/CurrentOrderModel.dart';
import 'package:bazimat/order/OrderStatus.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentOrderList extends StatefulWidget {
  CurrentOrderModel orderData;
  CurrentOrderList({this.orderData, Key key}) : super(key: key);

  @override
  _CurrentOrderListState createState() => _CurrentOrderListState();
}

class _CurrentOrderListState extends State<CurrentOrderList> {
  var dio = Dio();
  var token, msg;
  //Timer timer;
  bool _cancelLoad, btnCancel;
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
  void initState() {
    super.initState();
    _cancelLoad = false;
    btnCancel = false;
    msg = "";
    _getToken();
  }

  @override
  void dispose() {
    super.dispose();
    //timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print("OrderData..." + widget.orderData.cart.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cancelLoad == true
                ? SizedBox()
                : Container(
                    //height: MediaQuery.of(context).size.width * 0.18,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.orderData.cart.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      widget.orderData.cart[index].foodName
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: MediaQuery.of(context).size.width * 0.06,
                                  // ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    child: Text("Qty: " +
                                        widget.orderData.cart[index].quantity
                                            .toString()),
                                  ),
                                  // SizedBox(
                                  //   width: MediaQuery.of(context).size.width * 0.06,
                                  // ),
                                  //Spacer(),
                                  // Text("Rs: " +
                                  //     widget.orderData.cart[index].foodAmount
                                  //         .toString()),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            btnCancel == false
                ? SizedBox()
                : Text(
                    "Total :" + widget.orderData.orderAmountRound,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
            btnCancel == true
                ? SizedBox()
                : _cancelLoad == true
                    ? Center(
                        child: Text(msg),
                      )
                    : Row(
                        children: [
                          Text(
                            "Total :" + widget.orderData.orderAmountRound,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          widget.orderData.orderStatus == "canceled"
                              ? Text(
                                  "Canceled",
                                  style: TextStyle(color: Colors.red),
                                )
                              : TextButton(
                                  onPressed: () => _orderCancel(),
                                  child: Text("Cancel Order",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      )))
                        ],
                      ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            _cancelLoad == true
                ? SizedBox()
                : Container(
                    height: MediaQuery.of(context).size.height * 1.2,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing:
                              MediaQuery.of(context).size.width * 0.04,
                          childAspectRatio: MediaQuery.of(context).size.height /
                              MediaQuery.of(context).size.width *
                              1.2,
                        ),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OrderStatus(
                              orderStatus: list[index],
                              orderData: widget.orderData);
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

  _orderCancel() async {
    try {
      var param = "?order_id=" +
          widget.orderData.id.toString() +
          "&user_id=" +
          widget.orderData.userId.toString();
      var url = Const.cancelOrder + param;
      var response = await dio.put(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("orderCancel..." + response.data.toString());
      if (response.data["state"] == 0) {
        //showCustomToast(response.data["message"]);
        msg = response.data["message"].toString();
        setState(() {
          _cancelLoad = true;
        });
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("token");
    if (widget.orderData.orderStatus == "Accepted") {
      setState(() {
        btnCancel = true;
      });
    }
    // timer = Timer(Duration(minutes: 1), () {
    //   setState(() {
    //     btnCancel = true;
    //   });
    // });
  }
}

// class CurrentOrderList extends StatelessWidget {
//   CurrentOrderModel orderData;
//   CurrentOrderList({this.orderData, Key key}) : super(key: key);
//   var dio = Dio();
//   List list = [
//     "Pending",
//     "Accepted",
//     "Confirmed",
//     "Processing",
//     "Handover",
//     "Picked Up",
//     "Deliver",
//     "Cancel",
//     "Refund Request",
//     "Refund"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     print("OrderData..." + orderData.cart.toString());
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               //height: MediaQuery.of(context).size.width * 0.18,
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: orderData.cart.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Column(
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width / 3,
//                               child: Text(
//                                 orderData.cart[index].foodName.toString(),
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             // SizedBox(
//                             //   width: MediaQuery.of(context).size.width * 0.06,
//                             // ),
//                             Container(
//                               width: MediaQuery.of(context).size.width / 3.5,
//                               child: Text("Qty: " +
//                                   orderData.cart[index].quantity.toString()),
//                             ),
//                             // SizedBox(
//                             //   width: MediaQuery.of(context).size.width * 0.06,
//                             // ),
//                             //Spacer(),
//                             Text("Rs: " +
//                                 orderData.cart[index].foodAmount.toString()),
//                           ],
//                         ),
//                       ],
//                     );
//                   }),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.width * 0.04,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Total :" + orderData.orderAmountRound,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Spacer(),
//                 TextButton(
//                     onPressed: () => _orderCancel(),
//                     child: Text("Cancel Order",
//                         style: TextStyle(
//                           color: Colors.blue,
//                         )))
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.width * 0.03,
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 1.2,
//               child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: MediaQuery.of(context).size.width * 0.04,
//                     childAspectRatio: MediaQuery.of(context).size.height /
//                         MediaQuery.of(context).size.width *
//                         1.2,
//                   ),
//                   itemCount: list.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return OrderStatus(
//                         orderStatus: list[index], orderData: orderData);
//                   }),
//               // child: GridView.count(
//               //   crossAxisCount: 2,
//               //   mainAxisSpacing: MediaQuery.of(context).size.width * 0.06,
//               //   crossAxisSpacing: MediaQuery.of(context).size.width * 0.06,
//               //   childAspectRatio: MediaQuery.of(context).size.height /
//               //       MediaQuery.of(context).size.width *
//               //       2,
//               //   children: [
//               //     Container(
//               //       alignment: Alignment.center,
//               //       color: Colors.amber,
//               //       child: Text(
//               //         "Pending",
//               //         //textAlign: TextAlign.center,
//               //       ),
//               //     ),
//               //     Container(
//               //       alignment: Alignment.center,
//               //       color: Colors.amber,
//               //       child: Text("Accepted"),
//               //     ),
//               //     Container(
//               //       alignment: Alignment.center,
//               //       color: Colors.amber,
//               //       child: Text(
//               //         "Pending",
//               //         //textAlign: TextAlign.center,
//               //       ),
//               //     ),
//               //     Container(
//               //       alignment: Alignment.center,
//               //       color: Colors.amber,
//               //       child: Text("Accepted"),
//               //     )
//               //   ],
//               // ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   _orderCancel() async {
//     try {
//       //var response = await dio.post();
//     } on DioError catch (e) {
//       print(e.toString());
//     }
//   }
// }
