import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class QuantityList extends StatefulWidget {
  var dataList;
  Function(dynamic data, String type) refresh;
  Function(String type, dynamic data) data;
  QuantityList({this.dataList, this.refresh, this.data, Key key})
      : super(key: key);

  @override
  _QuantityListState createState() => _QuantityListState();
}

class _QuantityListState extends State<QuantityList> {
  int itemCount;
  double finalPrice;
  double foodValue;
  List dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    itemCount = int.parse(widget.dataList["quantity"].toString());
    foodValue = double.parse(widget.dataList["food_amount"].toString());
    finalPrice =
        itemCount * double.parse(widget.dataList["food_amount"].toString());
    print("ItemCount...in quantityList..." + itemCount.toString());
    // print("ItemCount..." + foodValue.toString());
    // print("ItemCount..." + finalPrice.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 2.2,
                //color: Colors.amber,
                child: Text(widget.dataList["food_name"])),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 4.8,
              alignment: Alignment.centerLeft,
              //color: Colors.red,
              //decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      if (itemCount > 1) {
                        setState(() {
                          itemCount = itemCount - 1;
                          finalPrice = itemCount * foodValue;
                          print("Datalist...increment..." +
                              finalPrice.toString());
                          widget.dataList["quantity"] = itemCount;
                          widget.dataList["food_amount"] =
                              finalPrice.toString();
                          dataList.add(widget.dataList);
                          print(
                              "Datalist...decrement..." + dataList.toString());
                          widget.refresh(dataList, "update");
                          //finalPrice = price * itemCount;
                          //widget.refresh(finalPrice.toString(), itemCount);
                        });
                      } else {
                        setState(() {
                          dataList.clear();
                          widget.dataList["quantity"] = 0;
                          widget.dataList["food_amount"] =
                              finalPrice.toString();
                          dataList.add(widget.dataList);
                          print("Datalist...delete..." + dataList.toString());
                          widget.refresh(dataList, "delete");
                          widget.data("delete", dataList);
                        });
                        //itemCount = 1;
                      }
                    },
                    child: Text(
                      " -",
                      style: TextStyle(
                        color: AppColors.addTextColor,
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                      ),
                    ),
                  ),
                  Text(itemCount.toString()
                      //   "Qty: " + itemCount.toString(),
                      //   // " x " +
                      //   // widget.dataList["food_amount"].toString() +
                      //   // " =",
                      //   style: TextStyle(color: Colors.grey),
                      //   //style: TextStyle(color: AppColors.addTextColor),
                      ),
                  TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      print("Item Clicked..." +
                          widget.dataList['food_name'].toString());
                      print("Datalist...increment..." +
                          widget.dataList['food_amount'].toString());
                      //onTap: () {
                      setState(() {
                        dataList.clear();
                        itemCount = itemCount + 1;
                        finalPrice = itemCount * foodValue;
                        print(
                            "Datalist...increment..." + finalPrice.toString());
                        widget.dataList["quantity"] = itemCount;
                        widget.dataList["food_amount"] = finalPrice.toString();
                        //var data = {"cart_id":widget.dataList["cart_id"],"user_id":widget.dataList["user_id"],"restaurant_id":widget.dataList["restaurant_id"],"food_id":widget.dataList["food_id"],"food_name":widget.dataList["food_name"],"food_image":widget.dataList["food_image"],"quantity":itemCount}
                        dataList.add(widget.dataList);
                        print("Datalist...increment..." + dataList.toString());
                        widget.refresh(dataList, "update");
                      });
                      print(
                          "itemcount...Item Clicked..." + itemCount.toString());
                      //   print("PriceItem...." +
                      //       price.runtimeType.toString());
                      //},
                    },
                    child: Text(
                      "+ ",
                      style: TextStyle(color: AppColors.addTextColor),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
                alignment: Alignment.centerRight,
                //color: Colors.amber,
                //width: MediaQuery.of(context).size.width / 5.5,
                child: Text("\u20B9$finalPrice"))
          ],
        ),
      ),
    );
  }
}
