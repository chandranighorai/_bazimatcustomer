import 'package:bazimat/order/CurrentOrderModel.dart';
import 'package:bazimat/order/DeliveryBoyTrack.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class OrderStatus extends StatelessWidget {
//   var orderData;
//   OrderStatus({this.orderData, Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
class OrderStatus extends StatefulWidget {
  var orderStatus;
  CurrentOrderModel orderData;
  OrderStatus({this.orderStatus, this.orderData, Key key}) : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  Color color;
  DateTime dt;
  var data;
  @override
  void initState() {
    super.initState();
    _getdata();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("widgetData..." + widget.orderData.accepted.toString());
    print("widgetData..." + widget.orderData.id.toString());
    print("widgetData..." + widget.orderData.orderStatus.toString());
    print("widgetData..." +
        widget.orderData.deliveryAddress.longitude.toString());
    print(
        "widgetData..." + widget.orderData.deliveryAddress.latitude.toString());

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.orderData.orderStatus == "rejected"
                  ? "Rejected"
                  : "${widget.orderStatus}",
              //textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            data.length == 0
                ? SizedBox()
                : Text(
                    "$data",
                    //textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }

  _getdata() {
    data = '';
    print("widget orderStatus..." + widget.orderStatus.toString());
    switch (widget.orderStatus) {
      case "Pending":
        {
          if (widget.orderData.pending.length == 0) {
            color = Colors.white;
            //data = '';
          } else {
            color = Colors.amber;
            dt = DateTime.parse(widget.orderData.pending);
            data = DateFormat('kk:mm a').format(dt);
            print("data...length" + data.toString());
          }
          break;
        }
      case "Accepted":
        {
          print("accepted..." + widget.orderData.accepted.length.toString());
          if (widget.orderData.accepted.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            setState(() {
              color = Colors.amber;
              dt = DateTime.parse(widget.orderData.accepted);
              data = DateFormat('kk:mm a').format(dt);
              print("data...length" + data.length.toString());
            });
          }

          break;
        }
      case "Confirmed":
        {
          print("Confirmed..." + widget.orderData.confirmed.length.toString());
          if (widget.orderData.confirmed.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            setState(() {
              color = Colors.amber;
              dt = DateTime.parse(widget.orderData.confirmed);
              data = DateFormat('kk:mm a').format(dt);
              print("data...length" + data.toString());
            });
          }

          break;
        }
      case "Processing":
        {
          if (widget.orderData.processing.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            setState(() {
              color = Colors.amber;
              dt = DateTime.parse(widget.orderData.processing);
              data = DateFormat('kk:mm a').format(dt);
            });
          }

          break;
        }
      case "Handover":
        {
          if (widget.orderData.handover.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            setState(() {
              color = Colors.amber;
              dt = DateTime.parse(widget.orderData.handover);
              data = DateFormat('kk:mm a').format(dt);
            });
          }

          break;
        }
      case "Picked Up":
        {
          //print("orderId..."+widget.orderData.)
          if (widget.orderData.pickedUp.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            setState(() {
              color = Colors.amber;
              dt = DateTime.parse(widget.orderData.pickedUp);
              data = DateFormat('kk:mm a').format(dt);
              print("data...length in pucked Up..." + data.toString());
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeliveryBoyTrack(
                            orderId: widget.orderData.id.toString(),
                            latitude: widget.orderData.deliveryAddress.latitude
                                .toString(),
                            longitude: widget
                                .orderData.deliveryAddress.longitude
                                .toString(),
                            totalAmount: widget.orderData.orderAmountRound)));
              });
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => DeliveryBoyTrack(
              //             orderId: widget.orderData.id.toString(),
              //             latitude: widget.orderData.deliveryAddress.latitude
              //                 .toString(),
              //             longitude: widget.orderData.deliveryAddress.longitude
              //                 .toString(),
              //             totalAmount: widget.orderData.orderAmountRound)));
            });
          }

          break;
        }
      case "Deliver":
        {
          if (widget.orderData.delivered.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            setState(() {
              color = Colors.amber;
              dt = DateTime.parse(widget.orderData.delivered);
              data = DateFormat('kk:mm a').format(dt);
            });
          }

          break;
        }
      case "Cancel":
        {
          if (widget.orderData.canceled.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            if (widget.orderData.orderStatus == "rejected") {
              setState(() {
                color = Colors.red;
                dt = DateTime.parse(widget.orderData.canceled);
                data = DateFormat('kk:mm a').format(dt);
              });
            } else {
              setState(() {
                color = Colors.amber;
                dt = DateTime.parse(widget.orderData.canceled);
                data = DateFormat('kk:mm a').format(dt);
              });
            }
          }

          break;
        }
      case "Refund Request":
        {
          if (widget.orderData.refundRequested.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            setState(() {
              color = Colors.amber;
              dt = DateTime.parse(widget.orderData.refundRequested);
              data = DateFormat('kk:mm a').format(dt);
            });
          }

          break;
        }
      case "Refund":
        {
          if (widget.orderData.refunded.length == 0) {
            setState(() {
              color = Colors.white;
            });
          } else {
            setState(() {
              color = Colors.amber;
              dt = DateTime.parse(widget.orderData.refunded);
              data = DateFormat('kk:mm a').format(dt);
            });
          }

          break;
        }
    }
  }
}
