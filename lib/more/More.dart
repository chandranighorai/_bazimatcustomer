import 'package:bazimat/more/aboutUs.dart';
import 'package:bazimat/more/registeredAddr.dart';
import 'package:bazimat/more/privacyPolicy.dart';
import 'package:bazimat/more/returnCancellation.dart';
import 'package:bazimat/more/termsCondition.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  var aboutUs, privacy, terms;
  More({this.aboutUs, this.privacy, this.terms, Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    print("about..." + widget.aboutUs.toString());
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
          "More",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    "About Us",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AboutUs(aboutUs: widget.aboutUs))),
                )),
            // Container(
            //     padding: const EdgeInsets.all(0.0),
            //     alignment: Alignment.centerLeft,
            //     child: TextButton(
            //       child: Text(
            //         "Returns & Cancellation",
            //         style: TextStyle(color: Colors.black),
            //       ),
            //       onPressed: () => Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => ReturnCancellation())),
            //     )),
            Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy())),
                )),
            // Container(
            //     padding: const EdgeInsets.all(0.0),
            //     alignment: Alignment.centerLeft,
            //     child: TextButton(
            //       child: Text(
            //         "Registered Address",
            //         style: TextStyle(color: Colors.black),
            //       ),
            //       onPressed: () => Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => RegisteredAddr())),
            //     )),
            Container(
                padding: const EdgeInsets.all(0.0),
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsCondition())),
                )),
          ],
        ),
      ),
    );
  }
}
