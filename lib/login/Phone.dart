import 'dart:math';

import 'package:bazimat/home/Home.dart';
import 'package:bazimat/sign%20up/Otp.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Phone extends StatefulWidget {
  const Phone({Key key}) : super(key: key);

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController _phoneText;
  var dio = Dio();
  var rNum;
  @override
  void initState() {
    super.initState();
    _phoneText = new TextEditingController();
    //_getNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Phone"), backgroundColor: AppColors.loginButtonColor),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _phoneText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter phone'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              TextButton(
                  onPressed: () {
                    if (_phoneText.text.length == 10) {
                      _sendButton();
                    } else {
                      showCustomToast("Please enter 10 digit");
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.03),
                      decoration: BoxDecoration(
                          color: AppColors.loginButtonColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                              MediaQuery.of(context).size.width * 0.06))),
                      child: Text(
                        "Send Otp".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ));
  }

  _getNumber() {
    int min = 100000;
    int max = 999999;
    var rendomNum = new Random();
    rNum = min + rendomNum.nextInt(max - min);
    print("rNum.." + rNum.toString());
  }

  _sendButton() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var formData = {"phone": _phoneText.text, "password": "abcdxy"};
    print("FormData..." + formData.toString());
    var response = await dio.post(Const.login, data: formData);
    print("responsestatusCode..." + response.statusCode.toString());
    print("responseBody...login..." + response.data.toString());
    if (response.data["state"] == 1) {
      print("responseBody...login..." + response.data.toString());

      showCustomToast(response.data["errors"][0]["message"]);
      setState(() {
        // _buttonDisable = false;
      });
    } else {
      if (response.data["is_phone_verified"] == 1) {
        print("responseBody...login..." + response.data["token"].toString());

        //saveUserPref(response.data["token"]);
        pref.setString("token", response.data["token"]);
        showCustomToast("Login Successful");
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
        //context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OTP(phone: _phoneText.text, type: "social")));
      }
    }
  }
}
