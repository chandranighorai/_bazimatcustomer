import 'package:bazimat/order/CurrentOrderModel.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.orderStatus}",
              //textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              "$data",
              //textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  _getdata() {
    switch (widget.orderStatus) {
      case "Pending":
        {
          if (widget.orderData.pending.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = DateFormat('kk:mm a').format(dt);
          break;
        }
      case "Accepted":
        {
          if (widget.orderData.accepted.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.accepted;
          break;
        }
      case "Confirmed":
        {
          if (widget.orderData.confirmed.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.confirmed;
          break;
        }
      case "Processing":
        {
          if (widget.orderData.processing.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.processing;
          break;
        }
      case "Handover":
        {
          if (widget.orderData.handover.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.handover;
          break;
        }
      case "Picked Up":
        {
          if (widget.orderData.pickedUp.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.pickedUp;
          break;
        }
      case "Deliver":
        {
          if (widget.orderData.delivered.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.delivered;
          break;
        }
      case "Cancel":
        {
          if (widget.orderData.canceled.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.canceled;
          break;
        }
      case "Refund Request":
        {
          if (widget.orderData.refundRequested.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.refundRequested;
          break;
        }
      case "Refund":
        {
          if (widget.orderData.refunded.length == 0) {
            color = Colors.white;
          } else {
            color = Colors.amber;
          }
          dt = DateTime.parse(widget.orderData.pending);
          data = widget.orderData.refunded;
          break;
        }
    }
  }
}
