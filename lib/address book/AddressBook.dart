import 'package:bazimat/address%20book/HomeAddress.dart';
import 'package:bazimat/address%20book/OtherAddress.dart';
import 'package:bazimat/address%20book/WorkAddress.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({Key key}) : super(key: key);

  @override
  _AddressBookState createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.only(left: 4.0),
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Your Address",
                suffixIcon: Icon(Icons.search)),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.width * 0.02,
            bottom: MediaQuery.of(context).size.width * 0.02),
        //color: Colors.amber,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  Text(
                    "Favourite".toUpperCase(),
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                  Text(
                    "Home",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    //flex: 1,
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return HomeAddress();
                          })
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    "Work Address",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    //flex: 1,
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return WorkAddress();
                          })
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    "Other Address",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Flex(
                    direction: Axis.vertical,
                    //flex: 1,
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return OtherAddress();
                          })
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.04,
                      bottom: MediaQuery.of(context).size.width * 0.04,
                      left: MediaQuery.of(context).size.width * 0.06,
                      right: MediaQuery.of(context).size.width * 0.06),
                  decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(
                          MediaQuery.of(context).size.width * 0.10))),
                  child: Text(
                    "Select From Map".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
      // body: Container(
      //   //height: MediaQuery.of(context).size.height * 0.3,
      //   width: MediaQuery.of(context).size.width,
      //   color: Colors.amber,
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         height: MediaQuery.of(context).size.width * 0.2,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "favourite".toUpperCase(),
      //               style: TextStyle(color: Colors.grey[100]),
      //             ),
      //             SizedBox(
      //               height: MediaQuery.of(context).size.width * 0.03,
      //             ),
      //             Container(
      //               //flex: 1,
      //               height: MediaQuery.of(context).size.height * 0.3,
      //               child: ListView(
      //                 //physics: NeverScrollableScrollPhysics(),
      //                 children: [
      //                   Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         "Home",
      //                         style: TextStyle(color: Colors.grey),
      //                       ),
      //                       ListView.builder(
      //                           physics: NeverScrollableScrollPhysics(),
      //                           shrinkWrap: true,
      //                           itemCount: 2,
      //                           itemBuilder: (BuildContext context, int index) {
      //                             return Padding(
      //                               padding: const EdgeInsets.all(8.0),
      //                               child: Container(
      //                                 height:
      //                                     MediaQuery.of(context).size.height *
      //                                         0.08,
      //                                 width: MediaQuery.of(context).size.width,
      //                                 color: Colors.pinkAccent,
      //                               ),
      //                             );
      //                           })
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             // SizedBox(
      //             //   height: MediaQuery.of(context).size.width * 0.03,
      //             // ),
      //             // Container(
      //             //   child: Column(
      //             //     crossAxisAlignment: CrossAxisAlignment.start,
      //             //     children: [
      //             //       Row(
      //             //         children: [
      //             //           Text(
      //             //             "Office",
      //             //             style: TextStyle(color: Colors.grey),
      //             //           ),
      //             //           Spacer(),
      //             //           // IconButton(
      //             //           //     icon: Icon(
      //             //           //       Icons.add,
      //             //           //       color: AppColors.moreText,
      //             //           //       size: MediaQuery.of(context).size.width * 0.06,
      //             //           //     ),
      //             //           //     onPressed: null)
      //             //         ],
      //             //       ),
      //             //       Container(
      //             //         //height: MediaQuery.of(context).size.width * 0.3,
      //             //         child: ListView.builder(
      //             //             physics: NeverScrollableScrollPhysics(),
      //             //             shrinkWrap: true,
      //             //             itemCount: 1,
      //             //             itemBuilder: (BuildContext context, int index) {
      //             //               return Padding(
      //             //                 padding: const EdgeInsets.all(8.0),
      //             //                 child: Container(
      //             //                   height:
      //             //                       MediaQuery.of(context).size.height *
      //             //                           0.08,
      //             //                   width: MediaQuery.of(context).size.width,
      //             //                   color: Colors.pinkAccent,
      //             //                 ),
      //             //               );
      //             //             }),
      //             //       )
      //             //     ],
      //             //   ),
      //             // ),
      //             // SizedBox(
      //             //   height: MediaQuery.of(context).size.width * 0.03,
      //             // ),
      //             // Container(
      //             //   child: Column(
      //             //     crossAxisAlignment: CrossAxisAlignment.start,
      //             //     children: [
      //             //       Text(
      //             //         "Other Address",
      //             //         style: TextStyle(color: Colors.grey),
      //             //       ),
      //             //       Container(
      //             //         //height: MediaQuery.of(context).size.width * 0.3,
      //             //         child: ListView.builder(
      //             //             //physics: NeverScrollableScrollPhysics(),
      //             //             shrinkWrap: true,
      //             //             itemCount: 4,
      //             //             itemBuilder: (BuildContext context, int index) {
      //             //               return Padding(
      //             //                 padding: const EdgeInsets.all(8.0),
      //             //                 child: Container(
      //             //                   height:
      //             //                       MediaQuery.of(context).size.height *
      //             //                           0.08,
      //             //                   width: MediaQuery.of(context).size.width,
      //             //                   color: Colors.pinkAccent,
      //             //                 ),
      //             //               );
      //             //             }),
      //             //       )
      //             //     ],
      //             //   ),
      //             // ),
      //           ],
      //         ),
      //       ),
      //       Expanded(
      //         child: Align(
      //           alignment: FractionalOffset.bottomCenter,
      //           child: Container(
      //               padding: EdgeInsets.only(
      //                   top: MediaQuery.of(context).size.width * 0.04,
      //                   bottom: MediaQuery.of(context).size.width * 0.04,
      //                   left: MediaQuery.of(context).size.width * 0.06,
      //                   right: MediaQuery.of(context).size.width * 0.06),
      //               decoration: BoxDecoration(
      //                   color: AppColors.moreText,
      //                   borderRadius: BorderRadius.all(Radius.circular(
      //                       MediaQuery.of(context).size.width * 0.10))),
      //               child: Text(
      //                 "Select From Map".toUpperCase(),
      //                 style: TextStyle(
      //                     color: Colors.white, fontWeight: FontWeight.bold),
      //               )),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
