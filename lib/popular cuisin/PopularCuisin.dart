import 'package:bazimat/popular%20cuisin/PopularCuisinList.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class PopularCuisin extends StatefulWidget {
  var name;
  PopularCuisin({this.name, Key key}) : super(key: key);

  @override
  _PopularCuisinState createState() => _PopularCuisinState();
}

class _PopularCuisinState extends State<PopularCuisin> {
  var cuisin = [
    {"pic": "images/pizza.jpg", "name": "Gusto Pizza"},
    {"pic": "images/pizza.jpg", "name": "Domino's Pizza"},
    {"pic": "images/pizza.jpg", "name": "Oven Story Fries"},
    {"pic": "images/pizza.jpg", "name": "Pizza Hut"},
    {"pic": "images/pizza.jpg", "name": "La Pino's Pizza"},
    {"pic": "images/pizza.jpg", "name": "Indus Fries"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[200],
        child: ListView.builder(
            itemCount: cuisin.length,
            itemBuilder: (BuildContext context, int index) {
              return PopularCuisinList(cuisinList: cuisin[index]);
            }),
      ),
    );
  }
}
