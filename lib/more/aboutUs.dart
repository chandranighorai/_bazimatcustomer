import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// ignore: must_be_immutable
class AboutUs extends StatefulWidget {
  var aboutUs;
  AboutUs({this.aboutUs, Key key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    print("about us..." + widget.aboutUs.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //color: Colors.amber,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          children: [
            Html(
              data: widget.aboutUs,
              // style: {
              //   "body":
              //       Style(margin: EdgeInsets.all(0), padding: EdgeInsets.all(0))
              // },
            )
          ],
        ),
      ),
    );
  }
}
