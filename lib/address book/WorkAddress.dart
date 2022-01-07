import 'package:flutter/material.dart';

class WorkAddress extends StatefulWidget {
  var workAddr;
  WorkAddress({this.workAddr, Key key}) : super(key: key);

  @override
  _WorkAddressState createState() => _WorkAddressState();
}

class _WorkAddressState extends State<WorkAddress> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.06,
        width: MediaQuery.of(context).size.width,
        //color: Colors.pink,
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.04,
              width: MediaQuery.of(context).size.width / 15,
              //color: Colors.blue,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/house.png"))),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              //color: Colors.amber,
              child: Text("${widget.workAddr["address"]}"),
            )
          ],
        ),
      ),
    );
  }
}
