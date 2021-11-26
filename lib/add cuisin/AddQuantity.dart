import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class AddQuantity extends StatefulWidget {
  const AddQuantity({Key key}) : super(key: key);

  @override
  _AddQuantityState createState() => _AddQuantityState();
}

class _AddQuantityState extends State<AddQuantity> {
  @override
  Widget build(BuildContext context) {
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
                        image: AssetImage("images/recommended.jpg"),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "So Southy",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    "Bidhannagar",
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
                  child: Text("Rava Masala Dosa No Onion No Garlic")),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                //color: Colors.red,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "- ",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          color: AppColors.addTextColor),
                    ),
                    Text(
                      " 1 ",
                      style: TextStyle(color: AppColors.addTextColor),
                    ),
                    Text(
                      " + ",
                      style: TextStyle(color: AppColors.addTextColor),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                  alignment: Alignment.centerRight,
                  //color: Colors.amber,
                  //width: MediaQuery.of(context).size.width / 5.5,
                  child: Text("\u20B9300"))
            ],
          )
        ],
      ),
    );
  }
}
