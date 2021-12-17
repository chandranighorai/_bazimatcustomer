import 'package:bazimat/sub%20list/SubListModel.dart';
import 'package:flutter/material.dart';

class SubListItem extends StatefulWidget {
  Errors listData;
  var listImageUrl;
  SubListItem({this.listData, this.listImageUrl, Key key}) : super(key: key);

  @override
  _SubListItemState createState() => _SubListItemState();
}

class _SubListItemState extends State<SubListItem> {
  @override
  Widget build(BuildContext context) {
    var imageUrl = widget.listImageUrl + widget.listData.image;
    print("imageUrl..." + imageUrl.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height * 0.16,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(image: NetworkImage(imageUrl))),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.listData.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.045),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text("SaltLake, Sector v"),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.01,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "1kms",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.030,
                            color: Colors.black)),
                    WidgetSpan(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 5.0, left: 4.0, right: 4.0),
                      child: Icon(
                        Icons.circle,
                        size: MediaQuery.of(context).size.width * 0.01,
                      ),
                    )),
                    TextSpan(
                        text: "30-45 mins",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.030,
                            color: Colors.black))
                  ])),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.04,
                        width: MediaQuery.of(context).size.width / 20,
                        decoration: BoxDecoration(
                            //color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage("images/discount.png"))),
                      ),
                      Text(
                        "50% off on delivery".toUpperCase(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.04,
                        width: MediaQuery.of(context).size.width / 20,
                        decoration: BoxDecoration(
                            //color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage("images/discount.png"))),
                      ),
                      Text(
                        "200 items available",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03),
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
