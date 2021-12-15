import 'package:bazimat/sign%20up/Otp.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _phoneText;
  var dio = Dio();
  bool _btnDisable;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneText = new TextEditingController();
    _btnDisable = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginButtonColor,
        title: Text("Forget Password"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _phoneText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Phone Number"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            TextButton(
                onPressed: () {
                  _btnDisable ? null : _submit();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_btnDisable
                        ? AppColors.loginButtonColor.withOpacity(0.2)
                        : AppColors.loginButtonColor)),
                child: Text(
                  "Submit".toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  _submit() async {
    print("phone...0.." + _phoneText.text.toString());
    if (_phoneText.text.isEmpty) {
      showCustomToast("Field should not empty");
    } else {
      setState(() {
        _btnDisable = true;
      });
      var formData = {"phone": _phoneText.text.trim()};
      var response = await dio.post(Const.forgetPassword, data: formData);
      print("response data..." + response.data.toString());
      if (response.data["state"] == 1) {
        showCustomToast(response.data["errors"][0]["message"]);
        setState(() {
          _btnDisable = false;
        });
      } else {
        showCustomToast(response.data["message"]);
        Navigator.push(context, MaterialPageRoute(builder: (context) => OTP(phone: _phoneText.text,forgetPass:"ForgetPassword")));
      }
    }
  }
}
