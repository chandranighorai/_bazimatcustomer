import 'package:flutter/material.dart';

class ListData extends StatefulWidget {
  var listArr;
  ListData({this.listArr, Key key}) : super(key: key);

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  @override
  Widget build(BuildContext context) {
    print("ListArr..." + widget.listArr["pic"].toString());
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
              height: MediaQuery.of(context).size.height * 0.12,
              //width: MediaQuery.of(context).size.width / 3.5,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.02)),
                  image: DecorationImage(
                    image: AssetImage(widget.listArr["pic"].toString()),
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              widget.listArr["name"].toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
