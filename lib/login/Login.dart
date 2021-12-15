import 'package:bazimat/age%20document/AgeDocument.dart';
import 'package:bazimat/forget%20password/ForgetPassword.dart';
import 'package:bazimat/home/Home.dart';
import 'package:bazimat/shapes/ShapeComponent.dart';
import 'package:bazimat/sign%20up/Otp.dart';
import 'package:bazimat/sign%20up/userPreferences.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _phoneText, _passText;
  bool _isHidden;
  bool _buttonDisable;
  var dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isHidden = true;
    _phoneText = new TextEditingController();
    _passText = new TextEditingController();
    _buttonDisable = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey[50],
            image: DecorationImage(
                image: AssetImage("images/login.png"), fit: BoxFit.fill)),
        // child: Stack(
        //   children: [
        //     ShapeComponent(context, Const.shapeHeight),
        //     ],
        // ),
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.02,
                //right: MediaQuery.of(context).size.width * 0.07,
                child: Row(
                  children: [
                    // IconButton(
                    //     icon: Icon(
                    //       Icons.arrow_back_ios,
                    //       color: Colors.white,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     }),
                    Text(
                      "Login".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    )
                  ],
                )),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.8,
              left: MediaQuery.of(context).size.width * 0.06,
              right: MediaQuery.of(context).size.width * 0.06,
              //bottom: MediaQuery.of(context).size.height / 2.5,
              child: Container(
                child: Column(
                  children: [
                    buildText("Mobile Number"),
                    buildText("Password"),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Container(
                    //     color: Colors.white,
                    //     padding: EdgeInsets.only(
                    //         left: MediaQuery.of(context).size.width * 0.03,
                    //         right: MediaQuery.of(context).size.width * 0.03),
                    //     child: TextFormField(
                    //       keyboardType: TextInputType.number,
                    //       decoration: InputDecoration(
                    //           hintText: "Password", border: InputBorder.none),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
                      },
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("Forget Password?")),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    InkWell(
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => AgeDocument()));
                      // },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            // padding: EdgeInsets.all(
                            //     MediaQuery.of(context).size.width * 0.04),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: _buttonDisable
                                    ? AppColors.loginButtonColor
                                        .withOpacity(0.2)
                                    : AppColors.loginButtonColor,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.of(context).size.width * 0.06))),
                            child: _buttonDisable
                                ? TextButton(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                    ),
                                    onPressed: null,
                                  )
                                : TextButton(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                    ),
                                    onPressed: _login,
                                  )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width / 9,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("images/facebook.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width / 9,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("images/google.png"))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )

            // SizedBox(
            //   height: MediaQuery.of(context).size.width * 0.01,
            // ),
          ],
        ),
      ),
    );
  }

  buildText(String hintText) {
    print("HintText..." + hintText.toString());
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03),
        child: TextFormField(
          controller: hintText == "Mobile Number" ? _phoneText : _passText,
          keyboardType: hintText == "Mobile Number"
              ? TextInputType.number
              : TextInputType.text,
          obscureText: hintText == "Password" ? _isHidden : false,
          decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: hintText == "Password"
                  ? IconButton(
                      icon: _isHidden
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: _onToggleButton)
                  : null),
        ),
      ),
    );
  }

  void _onToggleButton() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _login() async {
    try {
      print("Mobile Text..." + _phoneText.text.toString());
      print("Mobile Text..." + _passText.text.toString());
      if (_phoneText.text.isEmpty || _passText.text.isEmpty) {
        showCustomToast("Field should not empty");
      } else if (_phoneText.text.length != 10) {
        showCustomToast("Give 10 digit phone number");
      } else {
        setState(() {
          _buttonDisable = true;
        });
        var formData = {"phone": _phoneText.text, "password": _passText.text};
        print("FormData..." + formData.toString());
        var response = await dio.post(Const.login, data: formData);
        print("responsestatusCode..." + response.statusCode.toString());
        print("responseBody..." + response.data.toString());
        if (response.data["state"] == 1) {
          showCustomToast(response.data["errors"][0]["message"]);
          setState(() {
            _buttonDisable = false;
          });
        } else {
          if (response.data["is_phone_verified"] == 1) {
            saveUserPref(response.data["token"]);
            showCustomToast("Login Successful");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false);
            //context, MaterialPageRoute(builder: (context) => Home()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OTP(phone: _phoneText.text)));
          }
        }
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
