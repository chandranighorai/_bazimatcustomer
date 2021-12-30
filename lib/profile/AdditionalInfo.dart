import 'package:bazimat/profile/ZoomImage.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({Key key}) : super(key: key);

  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  var dio = Dio();
  var details, frontImage, backImage;
  bool _infoLoad;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _infoLoad = false;
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return _infoLoad == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ExpansionTile(
            title: Text("Additional Information"),
            children: [
              SingleChildScrollView(
                child: Container(
                  //height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.width * 0.02,
                      bottom: MediaQuery.of(context).size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date Of Birth",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "${details["db"]}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035),
                      ),
                      Divider(),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Govt. id for age proof(front page)"),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .02,
                            ),
                            InkWell(
                              onTap: () {
                                _imageView(frontImage);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.26,
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    image: DecorationImage(
                                        image: NetworkImage(frontImage)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.03))),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Govt. id for age proof(back page)"),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * .02,
                            ),
                            InkWell(
                              onTap: () => _imageView(backImage),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.26,
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.03)),
                                    image: DecorationImage(
                                        image: NetworkImage(backImage))),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }

  _getInfo() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var id = pref.getString("id");
      var token = pref.getString("token");
      var params = "?customerID=" + id;
      var url = Const.ageDetails + params;
      var response = await dio.get(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response data...details..." + response.data.toString());
      if (response.data["state"] == 0) {
        details = response.data["errors"];
        frontImage = response.data["imagepath"] + details["fontimg"];
        backImage = response.data["imagepath"] + details["backimg"];
        setState(() {
          _infoLoad = true;
        });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _imageView(String img) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ZoomImage(imgLink: img)));
  }
}
