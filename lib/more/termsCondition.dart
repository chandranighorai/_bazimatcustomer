import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsCondition extends StatefulWidget {
  var terms;
  TermsCondition({this.terms, Key key}) : super(key: key);

  @override
  _TermsConditionState createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  @override
  Widget build(BuildContext context) {
    print("ret...." + widget.terms.toString());
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
          "Terms & Condition",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          children: [
            Html(data: widget.terms),
            TextButton(
                onPressed: () => _readMore(),
                child: Text("Read More",
                    style: TextStyle(
                      color: Colors.blue,
                    )))
          ],
        ),
      ),
    );
  }

  _readMore() async {
    const launchUrl = "http://bazimat.in/terms-and-conditions";
    print(launchUrl.toString());
    await launch(launchUrl);
  }
}
