import 'package:bazimat/popular%20cuisin/PopularCuisin.dart';
import 'package:flutter/material.dart';

class CuisinList extends StatefulWidget {
  var cuisin, cuisinPath, zoneId;
  CuisinList({this.cuisin, this.cuisinPath, this.zoneId, Key key})
      : super(key: key);

  @override
  _CuisinListState createState() => _CuisinListState();
}

class _CuisinListState extends State<CuisinList> {
  @override
  Widget build(BuildContext context) {
    print("cuisinList...+++" + widget.cuisin["image"].toString());
    var image = widget.cuisinPath + widget.cuisin["image"];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PopularCuisin(
                    name: widget.cuisin["name"].toString(),
                    id: widget.cuisin["category_id"],
                    zoneId:widget.zoneId)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.25,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.contain)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              widget.cuisin["name"].toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
