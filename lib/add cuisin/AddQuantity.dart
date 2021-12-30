import 'package:bazimat/popular%20cuisin/RecommendedModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class AddQuantity extends StatefulWidget {
  var imageUrl, resturentName, resturentAddr, resturentOffer;
  Products product;
  AddQuantity(
      {this.imageUrl,
      this.resturentName,
      this.resturentAddr,
      this.resturentOffer,
      this.product,
      Key key})
      : super(key: key);

  @override
  _AddQuantityState createState() => _AddQuantityState();
}

class _AddQuantityState extends State<AddQuantity> {
  int price;
  int itemCount;
  int finalPrice;
  @override
  void initState() {
    super.initState();
    price = widget.product.price;
    itemCount = 1;
    finalPrice = price * itemCount;
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.fill)),
              ),
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
          Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  //color: Colors.amber,
                  child: Text("${widget.product.name}")),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                //color: Colors.red,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (itemCount > 1) {
                          setState(() {
                            itemCount = itemCount - 1;
                            finalPrice = price * itemCount;
                          });
                        } else {
                          itemCount = 1;
                        }
                      },
                      child: Text(
                        "- ",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                            color: AppColors.addTextColor),
                      ),
                    ),
                    Text(
                      " $itemCount ",
                      style: TextStyle(color: AppColors.addTextColor),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          itemCount = itemCount + 1;
                          finalPrice = price * itemCount;
                        });
                        print("PriceItem...." + price.runtimeType.toString());
                      },
                      child: Text(
                        " + ",
                        style: TextStyle(color: AppColors.addTextColor),
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
          )
        ],
      ),
    );
  }
}
