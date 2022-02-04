import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class QuantityList extends StatefulWidget {
  var dataList;
  Function(dynamic data) refresh;
  QuantityList({this.dataList, this.refresh, Key key}) : super(key: key);

  @override
  _QuantityListState createState() => _QuantityListState();
}

class _QuantityListState extends State<QuantityList> {
  int itemCount;
  double finalPrice;
  List dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    itemCount = int.parse(widget.dataList["quantity"].toString());
    finalPrice =
        itemCount * double.parse(widget.dataList["food_amount"].toString());
    print("ItemCount..." + itemCount.toString());
    print("ItemCount..." + finalPrice.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 1.8,
                //color: Colors.amber,
                child: Text(widget.dataList["food_name"])),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 4.5,
              //color: Colors.red,
              //decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     print("Item Clicked..." +
                  //         widget.dataList['food_name'].toString());
                  //     //onTap: () {
                  //     setState(() {
                  //       itemCount = itemCount + 1;
                  //       finalPrice = itemCount *
                  //           double.parse(
                  //               widget.dataList["food_amount"].toString());
                  //       dataList.add(widget.dataList);
                  //       widget.refresh(dataList);
                  //     });
                  //     print(
                  //         "itemcount...Item Clicked..." + itemCount.toString());
                  //     //   print("PriceItem...." +
                  //     //       price.runtimeType.toString());
                  //     //},
                  //   },
                  //   child: Text(
                  //     "+ ",
                  //     style: TextStyle(color: AppColors.addTextColor),
                  //   ),
                  // ),
                  Text(
                    "Qty: " + itemCount.toString(),
                    // " x " +
                    // widget.dataList["food_amount"].toString() +
                    // " =",
                    style: TextStyle(color: Colors.grey),
                    //style: TextStyle(color: AppColors.addTextColor),
                  ),
                  // InkWell(
                  //   //   if (itemCount > 1) {
                  //   //     setState(() {
                  //   //       itemCount = itemCount - 1;
                  //   //       //finalPrice = price * itemCount;
                  //   //       widget.refresh(
                  //   //           finalPrice.toString(), itemCount);
                  //   //     });
                  //   //   } else {
                  //   //     itemCount = 1;
                  //   //   }
                  //   child: Text(
                  //     " -",
                  //     style: TextStyle(
                  //       color: AppColors.addTextColor,
                  //       fontSize: MediaQuery.of(context).size.width * 0.08,
                  //     ),
                  //   ),
                  // )
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
