import 'package:flutter/material.dart';

class ReturnCancellation extends StatefulWidget {
  const ReturnCancellation({Key key}) : super(key: key);

  @override
  _ReturnCancellationState createState() => _ReturnCancellationState();
}

class _ReturnCancellationState extends State<ReturnCancellation> {
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
          "Returns & Cancellation",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
