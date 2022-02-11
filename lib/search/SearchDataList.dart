import 'package:bazimat/search/SerachModel.dart';
import 'package:flutter/material.dart';

class SearchDataList extends StatefulWidget {
  var imageUrl, cartdata;
  Products dataList;
  String resturentId, userId;
  SearchDataList(
      {this.imageUrl,
      this.cartdata,
      this.dataList,
      this.resturentId,
      this.userId,
      Key key})
      : super(key: key);

  @override
  _SearchDAtaListState createState() => _SearchDAtaListState();
}

class _SearchDAtaListState extends State<SearchDataList> {
  var imageData;
  int itemCount;
  bool _addEnable;
  bool _sectionLoad;
  var data = [];
  @override
  void initState() {
    super.initState();
    //itemCount = 0;
    _addEnable = false;
    // _sectionLoad = false;
    //_getItemList();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("CartDAta..." + widget.cartdata.toString());
    imageData = widget.imageUrl + widget.dataList.image;
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
                      Text(widget.dataList.name),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      Text("\u20B9" + widget.dataList.price.toString()),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02),
                      //data.length == 0
                      // _addEnable == false
                      //     ? InkWell(
                      //         onTap: () {
                      //           // _addToCArt(
                      //           //     widget.dataList,
                      //           //     widget.resturentId.toString(),
                      //           //     widget.userId.toString());
                      //         },
                      //         child: Container(
                      //             padding: EdgeInsets.only(
                      //                 left: MediaQuery.of(context).size.width * 0.02,
                      //                 right: MediaQuery.of(context).size.width * 0.02,
                      //                 top: MediaQuery.of(context).size.width * 0.02,
                      //                 bottom:
                      //                     MediaQuery.of(context).size.width * 0.02),
                      //             decoration: BoxDecoration(
                      //                 color: Colors.grey.withOpacity(0.2),
                      //                 borderRadius: BorderRadius.all(Radius.circular(
                      //                     MediaQuery.of(context).size.width * 0.02))),
                      //             child: Text("ADD")),
                      //       )
                      //     : Container(
                      //         height: MediaQuery.of(context).size.width / 12,
                      //         decoration: BoxDecoration(
                      //             border: Border.all(color: Colors.grey),
                      //             borderRadius: BorderRadius.all(Radius.circular(
                      //                 MediaQuery.of(context).size.width * 0.02))),
                      //         child: Row(
                      //           children: [
                      //             Container(
                      //                 //color: Colors.blue,
                      //                 width: MediaQuery.of(context).size.width / 13,
                      //                 child: TextButton(child: Text("+"))),
                      //             Text(itemCount.toString()),
                      //             Container(
                      //               width: MediaQuery.of(context).size.width / 13,
                      //               child: TextButton(
                      //                   child: Text(
                      //                 "-",
                      //               )),
                      //             )
                      //           ],
                      //         ),
                      //       )
                    ],
                  ),
                )
              ],
            )),
          );
  }

  // _getItemList() {
  //   print("cartData...in getItem..." + widget.cartdata.length.toString());
  //   if (widget.cartdata.toString() == "null") {
  //   } else {
  //     data = widget.cartdata
  //         .where((e) => e["food_name"] == widget.dataList.name)
  //         .toList();
  //     print("cartData... in data..." + data.length.toString());
  //     if (data.length == 0) {
  //       //setState(() {
  //       _addEnable = true;
  //       itemCount = int.parse(data[0]['quantity'].toString());
  //       _sectionLoad = true;
  //       // });
  //     } else {
  //       // setState(() {
  //       _addEnable = false;
  //       _sectionLoad = true;
  //       // });
  //     }
  //   }
  // }
}
