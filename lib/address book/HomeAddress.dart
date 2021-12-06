import 'package:flutter/material.dart';

class HomeAddress extends StatefulWidget {
  const HomeAddress({Key key}) : super(key: key);

  @override
  _HomeAddressState createState() => _HomeAddressState();
}

class _HomeAddressState extends State<HomeAddress> {
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
              child: Text("sds home"),
            )
          ],
        ),
      ),
    );
  }
}
