import 'package:bazimat/chat%20support/ChatModel.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  ChatList chatList;
  Chat({this.chatList, Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            widget.chatList.message == null
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                            //alignment: Alignment.centerRight,
                            //: MediaQuery.of(context).size.width / 1.8,
                            padding: const EdgeInsets.only(
                                left: 7, right: 6, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.of(context).size.width * 0.02))),
                            child: Text(widget.chatList.message)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.12,
                        width: MediaQuery.of(context).size.width / 8,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            color: Colors.blue.withOpacity(0.2),
                            shape: BoxShape.circle),
                        child: Text("Y"),
                      ),
                    ],
                  ),
            widget.chatList.reply == null
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.12,
                          width: MediaQuery.of(context).size.width / 8,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              color: Colors.green.withOpacity(0.2),
                              shape: BoxShape.circle),
                          child: Text("A"),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Flexible(
                          child: Container(
                              padding: const EdgeInsets.only(
                                  left: 7, right: 6, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.02))),
                              child: Text(widget.chatList.reply)),
                        ),
                      ],
                    ),
                  ),
          ],
        ));
  }
}
