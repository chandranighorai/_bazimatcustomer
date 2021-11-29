import 'dart:ui';

import 'package:bazimat/shapes/CurvedBottomClipper.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipPath(
            clipper: CurvedBottomClipper(),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.65,
              decoration: BoxDecoration(
                  //color: Colors.lightGreen,
                  image: DecorationImage(
                      image: AssetImage("images/signupImage.jpg"))),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: AppColors.moreText.withOpacity(0.7)),
                  child: Center(
                      child: Text(
                    "Register".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.08),
                  )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.2,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: "Enter Mobile Number", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07),
            child: TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "Enter Your Name", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Create password", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.2,
          ),
          Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.04,
                  left: MediaQuery.of(context).size.width * 0.15,
                  right: MediaQuery.of(context).size.width * 0.15,
                  bottom: MediaQuery.of(context).size.width * 0.04),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: AppColors.moreText,
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.6))),
              child: Text(
                "Submit".toUpperCase(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already an user? "),
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
