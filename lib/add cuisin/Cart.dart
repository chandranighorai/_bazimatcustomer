import 'package:bazimat/add%20cuisin/DeliveryTime.dart';
import 'package:bazimat/add%20cuisin/ThankYou.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

enum SingingCharacter { cash, online }

class _CartState extends State<Cart> {
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
          "Bill total : \u20B9340".toUpperCase(),
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
            Container(color: Colors.white, child: DeliveryTime()),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ThankYou()));
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
}
