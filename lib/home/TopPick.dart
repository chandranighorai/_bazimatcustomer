import 'package:flutter/material.dart';

class TopPicks extends StatefulWidget {
  var topArr;
  TopPicks({this.topArr, Key key}) : super(key: key);

  @override
  _TopPicksState createState() => _TopPicksState();
}

class _TopPicksState extends State<TopPicks> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width / 3.5,
        //color: Colors.red,
        //padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        alignment: Alignment.center,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              //width: MediaQuery.of(context).size.width / 3.5,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.02)),
                  image: DecorationImage(
                      image: AssetImage(widget.topArr["pic"].toString()),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              widget.topArr["name"].toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(
              widget.topArr["time"].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width * 0.03),
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
