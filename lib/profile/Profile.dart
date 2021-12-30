import 'package:bazimat/age%20document/AgeDocument.dart';
import 'package:bazimat/profile/AdditionalInfo.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  var fullName, email, phone, firstLetter, ageStatus;
  Profile(
      {this.fullName,
      this.email,
      this.phone,
      this.firstLetter,
      this.ageStatus,
      Key key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameText;
  @override
  void initState() {
    super.initState();
    _nameText = new TextEditingController();
    _nameText.text = widget.fullName;
  }

  @override
  Widget build(BuildContext context) {
    print("ageStatus..." + widget.ageStatus.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => _updateProfile(),
        ),
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.width * 0.22,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[200], shape: BoxShape.circle),
                      child: Text(
                        "${widget.firstLetter}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.07),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextFormField(
                      controller: _nameText,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                          border: InputBorder.none),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      "${widget.email}",
                      style: TextStyle(
                          //color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Text(
                      "Phone Number",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      "+91 ${widget.phone}",
                      style: TextStyle(
                          //color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              widget.ageStatus == "2"
                  ? Center(
                      child: Text(
                        "Age Documents are under reviewed",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : widget.ageStatus == "0"
                      ? Center(
                          child: TextButton(
                          child: Text("Upload Age Documents"),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AgeDocument())),
                        ))
                      : AdditionalInfo()
            ],
          ),
        ),
      ),
    );
  }

  _updateProfile() {
    return Navigator.of(context).pop({
      "fullName": _nameText.text.trim().length == 0
          ? widget.fullName
          : _nameText.text.trim()
    });
  }
}
