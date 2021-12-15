import 'package:bazimat/login/Login.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  var phone, otp;
  ResetPassword({this.phone, this.otp});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _passText, _confirmPassText;
  var dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passText = new TextEditingController();
    _confirmPassText = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginButtonColor,
        title: Text("Reset Password"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildText("Password"),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            buildText("Confirm Password"),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            TextButton(
                onPressed: () => _submit(),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.loginButtonColor)),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  buildText(String hintText) {
    return TextFormField(
      controller: hintText == "Password" ? _passText : _confirmPassText,
      decoration: InputDecoration(hintText: hintText),
    );
  }

  _submit() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var dd = preferences.getString("token");
    // print("dd..." + dd.toString());
    if (_passText.text.isEmpty || _confirmPassText.text.isEmpty) {
      showCustomToast("Field should not empty");
    } else {
      var formData = {
        "phone": widget.phone.toString(),
        "reset_token": widget.otp.toString(),
        "password": _passText.text.toString(),
        "confirm_password": _confirmPassText.text.toString()
      };
      var response =
          await dio.put(Const.resetPassword, queryParameters: formData);
      print("response data..." + response.data.toString());
      if (response.data["state"] == 1) {
        showCustomToast(response.data["errors"][0]["message"]);
      } else {
        showCustomToast(response.data["message"]);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      }
    }
  }
}
