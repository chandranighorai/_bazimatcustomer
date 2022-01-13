import 'package:bazimat/add%20cuisin/DeliveryTime.dart';
import 'package:bazimat/add%20cuisin/ThankYou.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  var totalAmount,
      resturentName,
      resturentId,
      duration,
      distance,
      address,
      addressType,
      addressLat,
      addressLng,
      token;
  Cart(
      {this.totalAmount,
      this.resturentName,
      this.resturentId,
      this.duration,
      this.distance,
      this.address,
      this.addressType,
      this.addressLat,
      this.addressLng,
      this.token,
      Key key})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

enum SingingCharacter { cash, online }

class _CartState extends State<Cart> {
  Dio dio = Dio();
  SingingCharacter _character = SingingCharacter.cash;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "Bill total : \u20B9${widget.totalAmount}".toUpperCase(),
          style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.04),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
                color: Colors.white,
                child: DeliveryTime(
                    resturentName: widget.resturentName,
                    duration: widget.duration,
                    addressType: widget.addressType,
                    address: widget.address)),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Container(
              //height: MediaQuery.of(context).size.width * 0.06,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment".toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttonColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045),
                  ),
                  //Radio(value: value, groupValue: groupValue, onChanged: onChanged)
                  ListTile(
                    title: Text("Cash On Delivery"),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.cash,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                          print("Character..." + _character.toString());
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Online"),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.online,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                          print("Character..." + _character.toString());
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: InkWell(
                  onTap: () {
                    print("Character...0.." + _character.toString());
                    _payNow();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => ThankYou()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.buttonColor,
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Pay Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _payNow() async {
    try {
      print("distance..." + widget.distance.toString());
      print("address..." + widget.address.toString());
      print("latitude..." + widget.addressLat.toString());
      print("longitude..." + widget.addressLng.toString());
      var distance = widget.distance.split(" ");
      print("longitude..." + distance[1].toString());
      var newDistance = distance[1] == "km" ? distance[0] : distance[0] / 1000;
      print("NewDistance..." + newDistance.toString());
      var paymentMethod = (_character.toString() == "SingingCharacter.cash")
          ? "cash_on_delivery"
          : "digital_payment";
      var params = "?";
      params += "order_amount" + widget.totalAmount.toString();
      params += "payment_method" +
          paymentMethod +
          "order_type" +
          "delivery" +
          "restaurant_id" +
          widget.resturentId.toString() +
          "distance" +
          newDistance.toString() +
          "address" +
          widget.address.toString() +
          "latitude" +
          widget.addressLat.toString() +
          "longitude" +
          widget.addressLng.toString();
      var url = Const.orderPlace + params;
      var response = await dio.post(
        url,
        options: Options(headers: {"Authorization": "Bearer ${widget.token}"}),
        // queryParameters: {
        //   "order_amount": widget.totalAmount,
        //   "payment_method": (_character.toString() == "SingingCharacter.cash")
        //       ? "cash_on_delivery"
        //       : "digital_payment",
        //   "order_type": "delivery",
        //   "restaurant_id": widget.resturentId,
        //   "distance": widget.distance,
        //   "address": widget.address,
        //   "latitude": widget.addressLat,
        //   "longitude": widget.addressLng,
        // }
      );
      print("response data pay..." + response.data.toString());
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
