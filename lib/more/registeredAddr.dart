import 'package:flutter/material.dart';

class RegisteredAddr extends StatefulWidget {
  const RegisteredAddr({Key key}) : super(key: key);

  @override
  _RegisteredAddrState createState() => _RegisteredAddrState();
}

class _RegisteredAddrState extends State<RegisteredAddr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Address",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
