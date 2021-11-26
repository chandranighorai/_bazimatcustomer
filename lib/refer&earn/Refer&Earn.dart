import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key key}) : super(key: key);

  @override
  _ReferEarnState createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
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
          "Refer & Earn",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(image: AssetImage("images/earn.png"))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Text(
              "Refer & get 50% off",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 12.0, bottom: 12.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Text(
                "Y6vl7uFjjO",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Container(
              child: Text(
                "Tap the box to copy the refferal code",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.grey),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 12.0, bottom: 12.0),
              decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.02))),
              child: Text(
                "Share".toUpperCase(),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
