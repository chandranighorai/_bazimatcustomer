import 'package:bazimat/home/Home.dart';
import 'package:bazimat/login/Login.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  var phone;
  OTP({this.phone});

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController _otpText;
  var dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _otpText = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginButtonColor,
        elevation: 0,
        title: Text(
          "OTP",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _otpText,
              decoration: InputDecoration(hintText: 'Enter Otp'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            TextButton(
                onPressed: () {
                  _sendButton();
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
      ),
    );
  }

  void _sendButton() async {
    print("phone" + widget.phone.toString());
    print("otp" + _otpText.text.toString());

    try {
      print("otpText..." + _otpText.text.toString());
      if (_otpText.text.isEmpty) {
        showCustomToast("Field should not empty");
      }
      // else if (_otpText.text == "123456") {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => LogIn()));
      // }
      else {
        var formData = {"phone": widget.phone, "otp": _otpText.text.toString()};
        var responseOtp = await dio.post(Const.verifyPhone, data: formData);
        print("responseData...." + responseOtp.data.toString());
        if (responseOtp.data["state"] == 1) {
          showCustomToast(responseOtp.data["errors"][0]["message"]);
        } else {
          showCustomToast(responseOtp.data["message"]);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogIn()));
        }
        //showCustomToast("Otp is incorrect");
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
