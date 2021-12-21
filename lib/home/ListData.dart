import 'package:bazimat/sub%20list/SubList.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListData extends StatefulWidget {
  var listArr, imageUrl;
  ListData({this.listArr, this.imageUrl, Key key}) : super(key: key);

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  var dio = Dio();
  @override
  Widget build(BuildContext context) {
    //print("ListArr..." + widget.listArr.image.toString());
    var fullImageUrl = widget.imageUrl + widget.listArr.image;
    return InkWell(
      onTap: () {
        print("catgoryName..." + widget.listArr.name.toString());
        print("catgoryName1..." + widget.listArr.name.toLowerCase().toString());
        if (widget.listArr.name.toLowerCase().toString() == "liquor") {
          _getCustomerInfo();
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SubList(
                      listId: widget.listArr.id,
                      listName: widget.listArr.name)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3.5,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.width * 0.02)),
                    image: DecorationImage(
                        image: NetworkImage(fullImageUrl), fit: BoxFit.fill)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                widget.listArr.name.toString(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }

  _getCustomerInfo() async {
    try {
      var pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      print("Token..." + token.toString());
      print("Token..." + Const.customerInfo.toString());
      var response = await dio.get(Const.customerInfo,
          options: Options(headers: {"Authorization": "Bearer Token " + token})
          // queryParameters: {
          //   "Authorization": {
          //     {"Bearer Token": token.toString()}
          //   }
          // },
          // options: Options(headers: {
          //   "Authorization": {"Bearer Token": token.toString()}
          // }
          // )
          );
      print("response body..." + response.data.toString());
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
