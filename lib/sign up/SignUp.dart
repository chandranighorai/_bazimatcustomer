import 'dart:convert';
import 'dart:ui';

import 'package:bazimat/login/Login.dart';
import 'package:bazimat/shapes/CurvedBottomClipper.dart';
import 'package:bazimat/sign%20up/Otp.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

class SignUp extends StatefulWidget {
  var loginType;
  String firstName, lastName, mail;
  SignUp({this.loginType, this.firstName, this.lastName, this.mail, Key key})
      : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _firstName, _lastName, _email, _phone, _password;
  FirebaseMessaging _firebaseMessaging;
  bool _isHidden;
  var typeLog;
  var dio = Dio();
  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((value) {
      print("firsebase value..." + value.toString());
    });
    _firstName = new TextEditingController();
    _lastName = new TextEditingController();
    _email = new TextEditingController();
    _phone = new TextEditingController();
    _password = new TextEditingController();
    _isHidden = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("logType..." + widget.loginType.toString());
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipPath(
            clipper: CurvedBottomClipper(),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.60,
              decoration: BoxDecoration(
                  //color: Colors.lightGreen,
                  image: DecorationImage(
                      image: AssetImage("images/signupImage.jpg"),
                      fit: BoxFit.cover)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.loginButtonColor.withOpacity(0.7)),
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
          buildText(
              widget.loginType == "social" ? widget.firstName : "First Name"),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          buildText(
              widget.loginType == "social" ? widget.lastName : "Last Name"),
          // Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.only(
          //       left: MediaQuery.of(context).size.width * 0.07,
          //       right: MediaQuery.of(context).size.width * 0.07),
          //   child: TextFormField(
          //     controller: _lastName,
          //     keyboardType: TextInputType.name,
          //     decoration: InputDecoration(
          //         hintText: "Last Name", border: InputBorder.none),
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          buildText(widget.loginType == "social" ? widget.mail : "Email Id"),
          // Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.only(
          //       left: MediaQuery.of(context).size.width * 0.07,
          //       right: MediaQuery.of(context).size.width * 0.07),
          //   child: TextFormField(
          //     controller: _email,
          //     keyboardType: TextInputType.emailAddress,
          //     decoration: InputDecoration(
          //         hintText: "Email Id", border: InputBorder.none),
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          buildText(
              widget.loginType == "social" ? "Mobile Number" : "Mobile Number"),

          // Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.only(
          //       left: MediaQuery.of(context).size.width * 0.07,
          //       right: MediaQuery.of(context).size.width * 0.07),
          //   child: TextFormField(
          //     controller: _phone,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //         hintText: "Mobile Number", border: InputBorder.none),
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          widget.loginType == null
              ? buildText(
                  widget.loginType == "social" ? "Password" : "Password")
              : SizedBox(),
          // Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.only(
          //       left: MediaQuery.of(context).size.width * 0.07,
          //       right: MediaQuery.of(context).size.width * 0.07),
          //   child: TextFormField(
          //     controller: _password,
          //     obscureText: true,
          //     decoration: InputDecoration(
          //         hintText: "Password", border: InputBorder.none),
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: AppColors.loginButtonColor,
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.6))),
              child: TextButton(
                child: Text(
                  "Submit".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () => _submit(),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already an user? "),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogIn()));
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  _submit() async {
    try {
      // print("phone..." + _phone.text.length.runtimeType.toString());
      print("phone..." + widget.loginType.toString());
      if (widget.loginType == "social") {
        setState(() {
          _firstName.text = widget.firstName.toString();
          _lastName.text = widget.lastName.toString();
          _email.text = widget.mail.toString();
          _password.text = "abcdxy";
          typeLog = "logIn";
        });
      }
      print("phone..." + _phone.text.length.runtimeType.toString());
      print("phone..." + _firstName.text.toString());
      print("phone..." + _lastName.text.toString());
      print("phone..." + _email.text.toString());
      print("phone..." + _phone.text.toString());
      print("phone..." + _password.text.toString());

      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (_firstName.text.isEmpty ||
          _lastName.text.isEmpty ||
          _email.text.isEmpty ||
          _phone.text.isEmpty ||
          _password.text.isEmpty) {
        showCustomToast("Field should not empty");
      } else if (!regExp.hasMatch(_email.text.toString())) {
        showCustomToast("Give proper email id");
      } else if (_phone.text.length != 10) {
        showCustomToast("Give 10 digit mobile number");
      } else {
        var formData = {
          "f_name": _firstName.text,
          "l_name": _lastName.text,
          "email": _email.text,
          "phone": _phone.text,
          "password": _password.text,
        };
        print("FormData..." + formData.toString());
        print("FormData..." + Uri.parse(Const.registration).toString());
        var response = await dio.post(Const.registration, data: formData);

        // print("response statusCode..." + response.statusCode.toString());
        // print("response body..." + response.data.toString());
        // print("state..." + response.data["state"].toString());
        // print("state..." + response.data["errors"][0]["message"].toString());

        if (response.data["state"] == 0) {
          print("phone..." + typeLog.toString());
          showCustomToast("Registration successfully");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OTP(phone: _phone.text.trim(), type: typeLog)));
        } else {
          print("response body..." + response.data["errors"].toString());
          showCustomToast(response.data["errors"][0]["message"].toString());
        }
      }
    } on DioError catch (e) {
      print(e.response.toString());
    }
  }

  buildText(String hintText) {
    print("HintText..." + hintText.toString());
    print("HintText..." + _firstName.toString());

    // _firstName = widget.firstName;
    // _lastName = widget.lastName;
    // _email = widget.mail;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07),
      child: TextFormField(
        controller: (hintText == "First Name" || hintText == widget.firstName)
            ? _firstName
            : (hintText == "Last Name" || hintText == widget.lastName)
                ? _lastName
                : (hintText == "Email Id" || hintText == widget.mail)
                    ? _email
                    : hintText == "Mobile Number"
                        ? _phone
                        : _password,
        obscureText: hintText == "Password" ? _isHidden : false,
        keyboardType: hintText == "Mobile Number"
            ? TextInputType.number
            : hintText == "Email Id"
                ? TextInputType.emailAddress
                : hintText == "Email Id"
                    ? TextInputType.visiblePassword
                    : TextInputType.name,
        decoration: InputDecoration(
            enabled: (hintText == "Mobile Number" ||
                    hintText == "Password" ||
                    hintText == "First Name" ||
                    hintText == "Last Name" ||
                    hintText == "Email Id")
                ? true
                : false,
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: hintText == "Password"
                ? IconButton(
                    icon: _isHidden
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: _toggleVisibility)
                : null),
        onChanged: (value) {
          print("value..." + value.toString());
        },
      ),
    );
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
