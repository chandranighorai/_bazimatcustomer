import 'package:bazimat/address%20book/AddressBook.dart';
import 'package:bazimat/favourites/Favourites.dart';
import 'package:bazimat/login/Login.dart';
import 'package:bazimat/more/More.dart';
import 'package:bazimat/notification/Notification.dart';
import 'package:bazimat/order/Order.dart';
import 'package:bazimat/profile/Profile.dart';
import 'package:bazimat/refer&earn/Refer&Earn.dart';
import 'package:bazimat/sign%20up/SignUp.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  //CustomerInfoError data;
  String fullName, phone, firstLetter, email, ageStatus;
  var dio = Dio();
  var response;
  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  @override
  Widget build(BuildContext context) {
    //print("fname..." + data.fName);
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
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Colors.grey[50], shape: BoxShape.circle),
                    child: Text(
                      "$firstLetter".toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.08),
                      // size: MediaQuery.of(context).size.width * 0.2,
                      // color: Colors.grey,
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
                        width: MediaQuery.of(context).size.width / 3.2,
                        //color: Colors.amber,
                        child: Text(
                          "$fullName",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "$phone",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    color: Colors.white,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                fullName: fullName,
                                email: email,
                                phone: phone,
                                firstLetter: firstLetter,
                                ageStatus: ageStatus))).then((value) {
                      print("Value of name..." + value.toString());
                      setState(() {
                        fullName = value["fullName"];
                      });
                    }),
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressBook()));
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
                                  image: AssetImage("images/chat.png"))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Chat Support"),
                      ],
                    ),
                  ),
                  // ListTile(
                  //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  //   title: Row(
                  //     children: [
                  //       Container(
                  //         height: MediaQuery.of(context).size.width * 0.05,
                  //         width: MediaQuery.of(context).size.width * 0.05,
                  //         decoration: BoxDecoration(
                  //             //color: Colors.red,
                  //             image: DecorationImage(
                  //                 image: AssetImage("images/sound.png"))),
                  //       ),
                  //       SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.04,
                  //       ),
                  //       Text("Announcements"),
                  //     ],
                  //   ),
                  // ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => More(
                                    aboutUs: response.data["about_us"],
                                    privacy: response.data["privacy_policy"],
                                    terms:
                                        response.data["terms_and_conditions"],
                                  )));
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
                              Icons.logout,
                              color: AppColors.iconColor,
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Text("Logout"),
                      ],
                    ),
                    onTap: () {
                      _logout(context);
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

  void _logout(BuildContext context) {
    print("logout...");
    showAlertDialogWithCancel(context, "Are you sure?", () async {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogIn()));
    });
  }

  _getDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var firstName = pref.getString("fName");
    var lastName = pref.getString("lName");

    setState(() {
      firstLetter = firstName.substring(0, 1);
      phone = pref.getString("Phone");
      email = pref.getString("Email");
      ageStatus = pref.getString("ageStatus");
      fullName = firstName + " " + lastName;
    });
    _getConfigData();
  }

  _getConfigData() async {
    try {
      response = await dio.get(Const.config);
      print("response of config..." +
          response.data["terms_and_conditions"].toString());
      // if(response.data["state"]==0)
      // {

      // }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
