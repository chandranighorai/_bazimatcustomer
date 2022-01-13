import 'package:flutter/material.dart';

class HomeAddress extends StatefulWidget {
  Function(String addr, String addrType, String lat, String lng) refresh;
  var homeAddr;
  HomeAddress({this.refresh, this.homeAddr, Key key}) : super(key: key);

  @override
  _HomeAddressState createState() => _HomeAddressState();
}

class _HomeAddressState extends State<HomeAddress> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.homeAddr["address"]);
        print(widget.homeAddr["latitude"]);
        print(widget.homeAddr["longitude"]);

        Navigator.pop(context);
        widget.refresh(
            widget.homeAddr["address"],
            widget.homeAddr["address_type"],
            widget.homeAddr["latitude"],
            widget.homeAddr["longitude"]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.06,
          width: MediaQuery.of(context).size.width,
          //color: Colors.pink,
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.04,
                width: MediaQuery.of(context).size.width / 15,
                //color: Colors.blue,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("images/house.png"))),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                //color: Colors.amber,
                child: Text("${widget.homeAddr["address"]}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
