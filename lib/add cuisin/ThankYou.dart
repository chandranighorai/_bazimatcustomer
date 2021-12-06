import 'package:bazimat/home/Home.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class ThankYou extends StatefulWidget {
  const ThankYou({Key key}) : super(key: key);

  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage("images/thank.png"), fit: BoxFit.fill)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(
              "Thank You",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(
              "Your Order Is On The Way",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.02))),
              child: TextButton(
                child: Text("Back To Home",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home())),
              ),
            ),
            // Expanded(
            //   child: Align(
            //     alignment: FractionalOffset.bottomCenter,
            //     child: Container(
            //         width: MediaQuery.of(context).size.width,
            //         padding: const EdgeInsets.all(8.0),
            //         color: Colors.amber,
            //         child: Text(
            //           "Back To Home",
            //           textAlign: TextAlign.center,
            //         )),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
