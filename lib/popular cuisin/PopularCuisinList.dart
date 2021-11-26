import 'package:bazimat/popular%20cuisin/CuisinDetails.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class PopularCuisinList extends StatefulWidget {
  var cuisinList;
  PopularCuisinList({this.cuisinList, Key key}) : super(key: key);

  @override
  _PopularCuisinListState createState() => _PopularCuisinListState();
}

class _PopularCuisinListState extends State<PopularCuisinList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CuisinDetails()));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 20.0, left: 8.0, right: 8.0),
            child: Container(
              //height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.12), blurRadius: 6.0)
                  ],
                  //border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.02))),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                MediaQuery.of(context).size.width * 0.02),
                            bottomLeft: Radius.circular(
                                MediaQuery.of(context).size.width * 0.02)),
                        color: Colors.grey[300],
                        image: DecorationImage(
                            image:
                                AssetImage(widget.cuisinList["pic"].toString()),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cuisinList["name"].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 3.0, right: 2.5),
                            child: Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: MediaQuery.of(context).size.width * 0.03,
                            ),
                          )),
                          TextSpan(
                              text: '3.9',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.03)),
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
                            child: Icon(
                              Icons.circle,
                              color: Colors.grey,
                              size: MediaQuery.of(context).size.width * 0.01,
                            ),
                          )),
                          TextSpan(
                              text: '44 mins',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.03)),
                          WidgetSpan(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
                            child: Icon(
                              Icons.circle,
                              color: Colors.grey,
                              size: MediaQuery.of(context).size.width * 0.01,
                            ),
                          )),
                          TextSpan(
                              text: '\u20B9300 for two',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.03)),
                        ])),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Pizza, Italic Food",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.width * 0.29,
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width / 1.5,
              bottom: MediaQuery.of(context).size.width * 0.03,
              child: Container(
                //height: MediaQuery.of(context).size.width * 0.2,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.width * 0.02))),
                child: Text(
                  "60% off",
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
