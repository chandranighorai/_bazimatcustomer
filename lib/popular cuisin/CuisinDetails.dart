import 'package:bazimat/popular%20cuisin/Recomended.dart';
import 'package:flutter/material.dart';

class CuisinDetails extends StatefulWidget {
  const CuisinDetails({Key key}) : super(key: key);

  @override
  _CuisinDetailsState createState() => _CuisinDetailsState();
}

class _CuisinDetailsState extends State<CuisinDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Icon(
            Icons.favorite,
            color: Colors.grey,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(
          //     left: MediaQuery.of(context).size.width * 0.04,
          //     right: MediaQuery.of(context).size.width * 0.04),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04),
                //padding: EdgeIns,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "So Southy",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Text(
                      "South Indian, Jain, Dessert, Beverages",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text(
                            "Bidhannagar",
                            style: TextStyle(color: Colors.grey),
                          ),
                          VerticalDivider(
                            thickness: 1,
                          ),
                          Text(
                            "2.2 kms",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Divider(),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3.3,
                            //height: 200,
                            //color: Colors.amber,
                            child: Column(
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                    Icons.star,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
                                  )),
                                  TextSpan(
                                      text: "4.0",
                                      style: TextStyle(color: Colors.black))
                                ])),
                                Text(
                                  "100+ ratings",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3.3,
                            //height: 200,
                            //color: Colors.white,
                            child: Column(
                              children: [
                                Text("42 mins"),
                                Text(
                                  "Delivery Time",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3.3,
                            //height: 200,
                            //color: Colors.amber,
                            child: Column(
                              children: [
                                Text("\u20B9300"),
                                Text(
                                  "For Two",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Divider(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.04,
                          width: MediaQuery.of(context).size.width * 0.04,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "images/discount.png".toString()),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                            "60% off upto \u20B9125 + Flat \u20B930 cashback with Paytm | Use code WELCOMEBACK",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.04,
                          width: MediaQuery.of(context).size.width * 0.04,
                          decoration: BoxDecoration(
                              //color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "images/discount.png".toString()),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                            "20% off upto \u20B9150 | Use code TRYNEW",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.width * 0.04,
                  bottom: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Text(
                  "Recommended",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                //height: 420,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (MediaQuery.of(context).size.width /
                              MediaQuery.of(context).size.height /
                              0.55)),
                      itemBuilder: (BuildContext context, int index) {
                        return Recommended();
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
