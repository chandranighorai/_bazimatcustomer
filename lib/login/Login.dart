import 'dart:io';
import 'package:bazimat/age%20document/AgeDocument.dart';
import 'package:bazimat/forget%20password/ForgetPassword.dart';
import 'package:bazimat/home/Home.dart';
import 'package:bazimat/login/Phone.dart';
import 'package:bazimat/shapes/ShapeComponent.dart';
import 'package:bazimat/sign%20up/Otp.dart';
import 'package:bazimat/sign%20up/SignUp.dart';
import 'package:bazimat/sign%20up/userPreferences.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:intl/intl_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    //'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/userinfo.profile',
  ],
);

class LogIn extends StatefulWidget {
  var type;
  LogIn({this.type, Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _phoneText, _passText;
  bool _isHidden;
  bool _buttonDisable;
  var dio = Dio();
  var userFirstname, userLastname, userEmail;
  GoogleSignInAccount _currentUser;
  String deviceToken;
  Map _userObj = {};
  Position _position;
  FirebaseMessaging _firebaseMessaging;
  //static final FacebookLogin facebookSignIn = new FacebookLogin();

  //final _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateLocation();
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((value) {
      print("firsebase Val..." + value.toString());
    });
    deviceToken = '';
    _getToken();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
        print("currentUser..." + _currentUser.toString());
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser);
      }
    });
    _googleSignIn.signInSilently();
    _isHidden = true;
    _phoneText = new TextEditingController();
    _passText = new TextEditingController();
    _buttonDisable = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _googleSignIn.signIn();
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
                    widget.type == "logIn" ? SizedBox() : buildText("Password"),
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
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.width * 0.01,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Are You a New User? "),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _loginFacebook();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width / 9,
                            decoration: BoxDecoration(
                                //color: Colors.red,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("images/facebook.png"))),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                        InkWell(
                          onTap: () {
                            _handleSignIn();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width / 9,
                            decoration: BoxDecoration(
                                //color: Colors.red,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage("images/google.png"))),
                          ),
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
      print("Mobile Text..." + widget.type.toString());

      if (widget.type == "logIn") {
        setState(() {
          _passText.text = "abcdxy";
        });
      }
      SharedPreferences pref = await SharedPreferences.getInstance();
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
        print("responseBody...login..." + response.data.toString());
        if (response.data["state"] == 1) {
          print("responseBody...login..." + response.data.toString());
          showCustomToast(response.data["errors"][0]["message"]);
          setState(() {
            _buttonDisable = false;
          });
        } else {
          if (response.data["is_phone_verified"] == 1) {
            print("responseBody...login...token..." +
                response.data["token"].toString());

            //saveUserPref(response.data["token"]);
            setState(() {
              pref.setString("token", response.data["token"].toString());
              var ttkon = pref.getString("token");
              print("responseBody...login...token..." + ttkon.toString());
            });
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

  Future<void> _handleSignIn() async {
    print("click...");
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    var arrName = user.displayName.split(" ");
    print("ArrNAme..." + arrName.toString());
    if (arrName.length > 0) {
      print(arrName[0] + "\n");
      print(arrName[arrName.length - 1]);

      if (arrName[0] != null && arrName[0] != "") {
        setState(() {
          userFirstname = arrName[0];
          print("FirstNAme..." + userFirstname.toString());
        });
      }
      if (arrName.length > 1 &&
          arrName[arrName.length - 1] != null &&
          arrName[arrName.length - 1] != "") {
        setState(() {
          userLastname = arrName[arrName.length - 1];
          print("LastNAme..." + userLastname.toString());
        });
      }
      if (user.email != null) {
        setState(() {
          userEmail = user.email;
          print("userNAme..." + userEmail.toString());
        });
      }
      _signinGoogle();
    }
  }

  _signinGoogle() async {
    try {
      var param = "?email=" + userEmail.toString();
      var url = Const.checkEmail + param;
      print("Url..." + url.toString());
      print("Url..." + userEmail.toString());
      var response = await dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $deviceToken"}));
      print("response..." + response.data.toString());
      if (response.data['state'] == 0) {
        showCustomToast(response.data["message"]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUp(
                    loginType: "social",
                    firstName: userFirstname,
                    lastName: userLastname,
                    mail: userEmail)));
        await _googleSignIn.signIn();
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("fName", userFirstname);
        pref.setString("lName", userLastname);
        pref.setString("Email", userEmail);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Phone()));

        //MaterialPageRoute(builder: (context) => Phone()), (route) => false);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _getToken() async {
    if (Platform.isIOS == TargetPlatform.iOS ||
        Platform.isMacOS == TargetPlatform.macOS) {
      String token = await FirebaseMessaging.instance.getAPNSToken();
      setState(() {
        deviceToken = token;
      });
    } else if (Platform.isAndroid) {
      FirebaseMessaging.instance.getToken().then((token) {
        print(token);
        setState(() {
          deviceToken = token;
          print("deviceToken..." + deviceToken.toString());
        });
      });
    } else {
      print(
          'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
    }
  }

  _loginFacebook() async {
    //var userObject = {};
    print("click...");
    // var token = "EAAETsnBCNEkBACJJ8lAdRWdycr8UV9klOpBOYUT4OxeRowREO0ZCw6vTCjz68bmIdUvmf2S3N5RXNZCZB5jhCPCvTNZBPmA0hWidJefj1xEZBVJnsKGynSZA1mhZCWV8Cc9twNA4152XUjIUCEQBTuZCZBxvGS6TpInva5Caqtc4tNM1trTGjvsAIz10eFZAeQwvZAxPZAjfmzYHBYZCDhVrhXlXINfmB6QxqNKcd5WcOE4epzuNWT3sKDjT3";
    // var graphResponse = await dio.get(
    //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${FacebookAuth.instance.accessToken}');
    // print("click..." + graphResponse.toString());
    // print("token..." + FacebookAuth.instance.accessToken.toString());
    // final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    // print("accessToken..." + result.status.toString());
    final facebookLogin = FacebookLogin();
    //final result = await facebookLogin.logIn(['email']);
    final result = await facebookLogin.logIn(['email']);

    print("result Status..." + result.status.toString());
    AccessToken accessToken = await FacebookAuth.instance.accessToken;
    print("accessToken..." + accessToken.toString());
    FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']).then((value) {
      print("val..." + value.toString());
      FacebookAuth.instance.getUserData().then((userData) {
        print("UserDAta..." + userData.toString());
        print("Name..." + userData['name'].toString());
        setState(() {
          _userObj = userData;
        });
      });
    });
  }

  updateLocation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      Position newPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));
      setState(() {
        _position = newPosition;
        print("Error...$_position");
        sharedPreferences.setString("latitude", _position.latitude.toString());
        sharedPreferences.setString(
            "longitude", _position.longitude.toString());
      });
    } catch (e) {
      print("Error...." + e.toString());
    }
  }
//}
}
