import 'package:bazimat/all%20resturant/AllResturentList.dart';
import 'package:bazimat/home/CampaignDetailsModel.dart';
import 'package:bazimat/home/ResturentModel.dart';
import 'package:bazimat/util/AppColors.dart';
import 'package:flutter/material.dart';

class AllResturant extends StatefulWidget {
  List<Restaurants> allResturentData;
  List<CampaignDetailsRestaurants> allCampaignData;
  var coverimgpath, latitude, longitude;
  var section;
  AllResturant(
      {this.allResturentData,
      this.allCampaignData,
      this.coverimgpath,
      this.latitude,
      this.longitude,
      this.section,
      Key key});

  @override
  _AllResturantState createState() => _AllResturantState();
}

class _AllResturantState extends State<AllResturant> {
  @override
  Widget build(BuildContext context) {
    print("resturentList..." + widget.section.toString());
    // print("resturentList..." + widget.allCampaignData.length.toString());
    // print("resturentList..." + widget.coverimgpath.toString());

    //print("resturentList..." + widget.allCampaignData[0].name.toString());
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
        title: Text(
          "All Resturent",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        child: ListView.builder(
            itemCount: widget.section == "campaign"
                ? widget.allCampaignData.length
                : widget.allResturentData.length,
            itemBuilder: (BuildContext context, int index) {
              return AllResturentList(
                  resturent: widget.section == "campaign"
                      ? null
                      : widget.allResturentData[index],
                  resturent1: widget.section == "campaign"
                      ? widget.allCampaignData[index]
                      : null,
                  coverImage: widget.coverimgpath,
                  latitude: widget.latitude,
                  longitude: widget.longitude,
                  section: widget.section);
            }),
      ),
    );
  }
}
