import 'package:flutter/material.dart';

class DeliveryTime extends StatelessWidget {
  var resturentName, duration, addressType, address;
  DeliveryTime(
      {this.resturentName,
      this.duration,
      this.addressType,
      this.address,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.13,
                    width: MediaQuery.of(context).size.width / 10,
                    decoration: BoxDecoration(
                        //color: Colors.amber,
                        image: DecorationImage(
                            image: AssetImage("images/store.png"))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$resturentName",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045)),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          // "1 Item | ETA : 37 MINS",
                          "ETA : $duration",

                          style: TextStyle(
                              color: Colors.grey,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.1,
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03),
              child: VerticalDivider(
                //width: 25,
                color: Colors.black,
                //thickness: 1,
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.13,
                    width: MediaQuery.of(context).size.width / 10,
                    decoration: BoxDecoration(
                        //color: Colors.amber,
                        image: DecorationImage(
                            image: AssetImage("images/house.png"))),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$addressType",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045)),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text("$address",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
