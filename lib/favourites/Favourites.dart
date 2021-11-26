import 'package:bazimat/favourites/FavouriteList.dart';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
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
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text(
          "Favourites",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return FavouriteList();
            }),
      ),
    );
  }
}
