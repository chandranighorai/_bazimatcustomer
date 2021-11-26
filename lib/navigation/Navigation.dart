import 'package:bazimat/favourites/Favourites.dart';
import 'package:bazimat/more/More.dart';
import 'package:bazimat/notification/Notification.dart';
import 'package:bazimat/order/Order.dart';
import 'package:bazimat/refer&earn/Refer&Earn.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width,
              color: AppColors.buttonColor,
              child: DrawerHeader(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.grey[50], shape: BoxShape.circle),
                    child: Icon(
                      Icons.person,
                      size: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        //color: Colors.amber,
                        child: Text(
                          "User",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "9876543210",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  )
                ],
              )),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("images/list.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Orders"),
                      ],
                    ),
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Order()))
                    },
                  ),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("images/share.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Refer & Earn"),
                      ],
                    ),
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ReferEarn()))
                    },
                  ),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("images/bell.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Notifications"),
                      ],
                    ),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationList()))
                    },
                  ),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.iconColor,
                            size: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Favourites"),
                      ],
                    ),
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Favourites()))
                    },
                  ),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("images/pin.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Address Book"),
                      ],
                    ),
                  ),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("images/chat.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Chat Support"),
                      ],
                    ),
                  ),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("images/sound.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Announcements"),
                      ],
                    ),
                  ),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("images/qr-code.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Scan QR Code"),
                      ],
                    ),
                  ),
                  ListTile(
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    title: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("images/notes.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("More"),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => More()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
