import 'package:bazimat/chat%20support/Chat.dart';
import 'package:bazimat/chat%20support/ChatModel.dart';
import 'package:bazimat/util/AppConst.dart';
import 'package:bazimat/util/Const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatSupport extends StatefulWidget {
  const ChatSupport({Key key}) : super(key: key);

  @override
  _ChatSupportState createState() => _ChatSupportState();
}

class _ChatSupportState extends State<ChatSupport> {
  Future<ChatModel> chatList;
  var dio = Dio();
  TextEditingController _msgText;
  @override
  void initState() {
    super.initState();
    _msgText = new TextEditingController();
    chatList = _getChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Chat Support",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FutureBuilder(
                  initialData: null,
                  future: chatList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var msgList = snapshot.data.errors;
                      return ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          padding: EdgeInsets.all(0),
                          itemCount: msgList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Chat(chatList: msgList[index]);
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.width * 0.01),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          controller: _msgText,
                          decoration:
                              InputDecoration(hintText: "Write message..."),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _sendMessage();
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<ChatModel> _getChatList() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      var response = await dio.get(Const.getMessages,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response messafe..." + response.data.toString());
      if (response.data["state"] == 0) {
        return ChatModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }

  _sendMessage() async {
    try {
      print("message..." + _msgText.text.trim().toString());
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      var params = "?message=" + _msgText.text.trim();
      var url = Const.sendMessage + params;
      var response = await dio.post(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("response body..." + response.data.toString());
      if (response.data["state"] == 0) {
        showCustomToast(response.data["message"]);
        _msgText.clear();
        setState(() {
          chatList = _getChatList();
        });
      } else {
        showCustomToast(response.data["errors"][0]["message"]);
      }
    } on DioError catch (e) {
      print(e.toString());
    }
  }
}
