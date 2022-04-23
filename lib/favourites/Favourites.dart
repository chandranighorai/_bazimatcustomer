import 'package:bazimat/favourites/FavouriteList.dart';
import 'package:bazimat/favourites/FavouriteModel.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Future<FavouriteModel> _favourite;
  var dio = Dio();
  var latitude, longitude;
  @override
  void initState() {
    super.initState();
    _favourite = _getAllFavourites();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        child: FutureBuilder(
          initialData: null,
          future: _getAllFavourites(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var resturentData = snapshot.data.errors.restaurant;
              var imagePath = snapshot.data.coverimgpath;
              print("resturentData..." + resturentData.toString());
              return ListView.builder(
                  itemCount: resturentData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FavouriteList(
                        favouriteData: resturentData[index],
                        imageUrl: imagePath,
                        latitude: latitude,
                        longitude: longitude);
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          //child: ,
        ),
      ),
    );
  }

  Future<FavouriteModel> _getAllFavourites() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      var zoneId = pref.getString("zoneId");
      latitude = pref.getString("latitude");
      longitude = pref.getString("longitude");
      print("Token..." + token.toString());
      //print(object)
      var response = await dio.get(
        Const.getWishList,
        options: Options(
            headers: {"Authorization": "Bearer $token", "zoneId": zoneId}),
      );
      print("response in favourite..." + response.data.toString());
      if (response.data["state"] == 0) {
        print("response body..." + response.data.toString());
        return FavouriteModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
