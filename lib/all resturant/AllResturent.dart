import 'package:bazimat/all%20resturant/AllResturentList.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class AllResturant extends StatefulWidget {
  const AllResturant({Key key}) : super(key: key);

  @override
  _AllResturantState createState() => _AllResturantState();
}

class _AllResturantState extends State<AllResturant> {
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
          "All Resturent",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
          return AllResturentList();
        }),
      ),
    );
  }
}
