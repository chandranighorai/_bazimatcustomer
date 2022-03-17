import 'package:bazimat/search/SerachModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewSearchDataList extends StatefulWidget {
  var imageUrl, cartdata;
  Products dataList;
  String resturentId, userId, token;
  Function(String data, int itemcount, String foodId, String foodPrice,
      String tax) totalItem;
  NewSearchDataList(
      {this.imageUrl,
      this.cartdata,
      this.dataList,
      this.resturentId,
      this.userId,
      this.token,
      this.totalItem,
      Key key})
      : super(key: key);

  @override
  _NewSearchDataListState createState() => _NewSearchDataListState();
}

class _NewSearchDataListState extends State<NewSearchDataList> {
  var imageData;
  int itemCount;
  bool _addEnable;
  bool _sectionLoad;
  var data = [];
  var dio = Dio();
  @override
  Widget build(BuildContext context) {
    print("CartDAta..." + widget.cartdata.toString());
    imageData = widget.imageUrl + widget.dataList.image;
    _getItemList();
    return _sectionLoad == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(imageData), fit: BoxFit.fill)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          //color: Colors.amber,
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(widget.dataList.name)),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      Text("\u20B9" + widget.dataList.price.toString()),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      //data.length == 0
                      _addEnable == false
                          ? InkWell(
                              onTap: () {
                                widget.totalItem(
                                    "add",
                                    1,
                                    widget.dataList.id.toString(),
                                    widget.dataList.price.toString(),
                                    widget.dataList.tax.toString());
                                // _addToCArt(
                                //     widget.dataList,
                                //     widget.resturentId.toString(),
                                //     widget.userId.toString());
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.02,
                                      right: MediaQuery.of(context).size.width *
                                          0.02,
                                      top: MediaQuery.of(context).size.width *
                                          0.02,
                                      bottom: MediaQuery.of(context).size.width *
                                          0.02),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              MediaQuery.of(context).size.width *
                                                  0.02))),
                                  child: Text("ADD")),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.width / 12,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.02))),
                              child: Row(
                                children: [
                                  Container(
                                      //color: Colors.blue,
                                      width: MediaQuery.of(context).size.width /
                                          13,
                                      child: TextButton(
                                          onPressed: () {
                                            //setState(() {
                                            itemCount = itemCount + 1;
                                            //});
                                            widget.totalItem(
                                                "update",
                                                itemCount,
                                                widget.dataList.id.toString(),
                                                widget.dataList.price
                                                    .toString(),
                                                widget.dataList.tax.toString());
                                            //itemAdd(widget.dataList, itemCount);
                                          },
                                          child: Text("+"))),
                                  Text(itemCount.toString()),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 13,
                                    child: TextButton(
                                        onPressed: () {
                                          //setState(() {
                                          itemCount = itemCount - 1;
                                          //});
                                          print("itemcount..." +
                                              itemCount.toString());
                                          if (itemCount < 1) {
                                            widget.totalItem(
                                                "delete",
                                                itemCount,
                                                widget.dataList.id.toString(),
                                                widget.dataList.price
                                                    .toString(),
                                                widget.dataList.tax.toString());
                                            //itemDelete(widget.dataList);
                                          } else {
                                            widget.totalItem(
                                                "update",
                                                itemCount,
                                                widget.dataList.id.toString(),
                                                widget.dataList.price
                                                    .toString(),
                                                widget.dataList.tax.toString());
                                            //itemAdd(widget.dataList, itemCount);
                                          }
                                        },
                                        child: Text(
                                          "-",
                                        )),
                                  )
                                ],
                              ),
                            )
                    ],
                  ),
                )
              ],
            )),
          );
  }

  _getItemList() {
    if (widget.cartdata.toString() == "null") {
      setState(() {
        _addEnable = false;
      });
    } else {
      data = widget.cartdata
          .where((e) => e["food_name"] == widget.dataList.name)
          .toList();
      print("_addEnable...data l ength..." + data.length.toString());
      print("_addEnable...data length..." + data.toString());
      if (data.length == 0) {
        _addEnable = false;
        _sectionLoad = true;
        print("_addEnable..." + _addEnable.toString());
        print("_addEnable..." + _sectionLoad.toString());
      } else {
        _addEnable = true;
        itemCount = int.parse(data[0]['quantity'].toString());
        _sectionLoad = true;
        //widget.totalItem(data);
      }
    }
  }

  //_addToCArt(Products dataList, String resturantId, String userId) async {}
}
