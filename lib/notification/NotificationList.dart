import 'package:bazimat/notification/NotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllNotificationList extends StatelessWidget {
  NotificationData list;
  AllNotificationList({this.list, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time = list.createdAt.split(" ");
    print("Time..." + time.toString());
    var newDate = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time[1]));
    print("Time..." + newDate.toString());
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 4.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              list.data.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(list.data.description),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              time[0] + " " + newDate,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
