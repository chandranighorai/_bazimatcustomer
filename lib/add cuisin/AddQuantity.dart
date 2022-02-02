import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddQuantity extends StatefulWidget {
  var
      //imageUrl,
      resturentName,
      resturentAddr,
      resturentId;
  //resturentOffer,
  //product;
  //Products product;
  Function(String itemPrice, int itemcount) refresh;
  AddQuantity(
      {
      //this.imageUrl,
      this.resturentName,
      this.resturentAddr,
      this.resturentId,
      //this.resturentOffer,
      //this.product,
      this.refresh,
      Key key})
      : super(key: key);

  @override
  _AddQuantityState createState() => _AddQuantityState();
}

class _AddQuantityState extends State<AddQuantity> {
  int price;
  int itemCount;
  double finalPrice;
  bool getCartLoad;
  var dio = Dio();
  var allCartData;
  @override
  void initState() {
    super.initState();
    _getProduct();
    getCartLoad = false;
    //price = widget.product.price;
    //itemCount = 1;
    //finalPrice = price * itemCount;
  }

  @override
  Widget build(BuildContext context) {
    // print("Product in add Quantity..." + widget.product.toString());
    // print("Product in add Quantity..." + widget.product.length.toString());
    //print("Price..." + price.runtimeType.toString());
    // var off = widget.resturentOffer.toString().split(" ");
    // print("Off..." + off[0].toString());
    // var offer = int.parse(off[0]);
    // var price = offer / 2;
    // print("offerPrice..." + price.toString());
    // print("offerPrice..." + widget.product.price.toString());
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
          bottom: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Row(
            children: [
              // Container(
              //   width: MediaQuery.of(context).size.width / 3.5,
              //   height: MediaQuery.of(context).size.height * 0.12,
              //   decoration: BoxDecoration(
              //       color: Colors.red,
              //       image: DecorationImage(
              //           image: NetworkImage(widget.imageUrl),
              //           fit: BoxFit.fill)),
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.resturentName}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    "${widget.resturentAddr}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * 0.03),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.06,
          ),
          Container(
            //height: MediaQuery.of(context).size.width * 0.4,
            width: MediaQuery.of(context).size.width,
            child: getCartLoad == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: allCartData.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("ItemCount..." +
                          allCartData[index]["quantity"].toString());
                      print("ItemCount..." +
                          allCartData[index]["food_amount"]
                              .runtimeType
                              .toString());
                      itemCount =
                          int.parse(allCartData[index]["quantity"].toString());
                      finalPrice = itemCount *
                          double.parse(
                              allCartData[index]["food_amount"].toString());
                      print("ItemCount..." + itemCount.toString());
                      print("ItemCount..." + finalPrice.toString());

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                //color: Colors.amber,
                                //child: Text("${widget.product[index]["cart_id"]}")
                              ),
                              Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                //color: Colors.red,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      // onTap: () {
                                      //   if (itemCount > 1) {
                                      //     setState(() {
                                      //       itemCount = itemCount - 1;
                                      //       //finalPrice = price * itemCount;
                                      //       widget.refresh(
                                      //           finalPrice.toString(), itemCount);
                                      //     });
                                      //   } else {
                                      //     itemCount = 1;
                                      //   }
                                      // },
                                      child: Text(
                                        "- ",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            color: AppColors.addTextColor),
                                      ),
                                    ),
                                    Text(
                                      itemCount.toString(),
                                      style: TextStyle(
                                          color: AppColors.addTextColor),
                                    ),
                                    InkWell(
                                      // onTap: () {
                                      //   setState(() {
                                      //     itemCount = itemCount + 1;
                                      //     // finalPrice = price * itemCount;
                                      //     widget.refresh(
                                      //         finalPrice.toString(), itemCount);
                                      //   });
                                      //   print("PriceItem...." +
                                      //       price.runtimeType.toString());
                                      // },
                                      child: Text(
                                        " + ",
                                        style: TextStyle(
                                            color: AppColors.addTextColor),
                                      ),
                                    )
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
                    },
                  ),
          )
        ],
      ),
    );
  }

  _getProduct() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var id = pref.getString("id");
      var token = pref.getString("token");
      var params = "?user_id=" +
          id.toString() +
          "&restaurant_id=" +
          widget.resturentId.toString();
      print("params..." + params.toString());
      var response = await dio.post(Const.getCart + params,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      allCartData = response.data["respData"];
      print("respons body...in getCart..." + response.data.toString());
      if (response.data['state'] == 1) {
        setState(() {
          //_dataAdded = false;
          getCartLoad = true;
        });
      } else {
        setState(() {
          //_dataAdded = true;
          getCartLoad = true;
        });
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
