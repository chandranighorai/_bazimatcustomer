import 'package:bazimat/notification/NotificationModel.dart';
import 'package:flutter/material.dart';

class AllNotificationList extends StatelessWidget {
  NotificationData list;
  AllNotificationList({this.list, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              list.createdAt,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.02),
            )
          ],
        ),
      ),
    );
  }
}
