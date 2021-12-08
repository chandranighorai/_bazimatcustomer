import 'dart:ui';

import 'package:bazimat/login/Login.dart';
import 'package:bazimat/shapes/CurvedBottomClipper.dart';
import 'package:bazimat/sign%20up/Otp.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _firstName, _lastName, _email, _phone, _password;
  @override
  void initState() {
    super.initState();
    _firstName = new TextEditingController();
    _lastName = new TextEditingController();
    _email = new TextEditingController();
    _phone = new TextEditingController();
    _password = new TextEditingController();
  }

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
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07),
            child: TextFormField(
              controller: _firstName,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "First Name", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07),
            child: TextFormField(
              controller: _lastName,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "Last Name", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07),
            child: TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Email Id", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07),
            child: TextFormField(
              controller: _phone,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Mobile Number", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07),
            child: TextFormField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password", border: InputBorder.none),
            ),
          ),
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
    if (_firstName.text.isEmpty ||
        _lastName.text.isEmpty ||
        _email.text.isEmpty ||
        _phone.text.isEmpty ||
        _password.text.isEmpty) {
      showCustomToast("Field should not empty");
    }
  }
}
