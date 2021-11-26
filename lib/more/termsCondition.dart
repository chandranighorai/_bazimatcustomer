import 'package:flutter/material.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({Key key}) : super(key: key);

  @override
  _TermsConditionState createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
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
          "Terms & Condition",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
