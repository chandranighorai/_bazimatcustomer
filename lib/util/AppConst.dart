import 'package:bazimat/util/Const.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

showCustomToast(String message, [Color mColor]) {
  mColor = Color(0x99000000);
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[100],
      textColor: Colors.black,
      fontSize: 16.0);
}

showAlertDialogWithCancel(
    BuildContext context, String message, Function onOKPressed) {
  // PackageInfo _packageInfo = PackageInfo(
  //     appName: Const.APP_NAME,
  //     packageName: "Unknown",
  //     version: "Unknown",
  //     buildNumber: "Unknown");

  var buttonStyleOk =
      TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold);
  var buttonStyleCancel =
      TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold);

  Widget okButton = TextButton(
      child: Text(
        "Ok",
        style: buttonStyleOk,
      ),
      onPressed: onOKPressed);

  Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: buttonStyleCancel,
      ),
      onPressed: () {
        Navigator.pop(context);
      });

  AlertDialog alert = AlertDialog(
    insetPadding: EdgeInsets.all(0),
    title: Text(
      Const.APP_NAME,
      style: TextStyle(
          fontSize: 16, color: Colors.black87, fontFamily: "philosopher"),
    ),
    content:
        Text(message, style: TextStyle(fontSize: 16, color: Colors.black87)),
    actions: [okButton, cancelButton],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
          child: Container(
            child: alert,
          ),
        );
      });
}
