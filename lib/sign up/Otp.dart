import 'package:bazimat/home/Home.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  const OTP({Key key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
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
              decoration: InputDecoration(hintText: 'Enter Otp'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home())),
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
}
