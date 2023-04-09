import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Services/database.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

class ChatScreenWithStaff extends StatefulWidget {
  final String chatWithUsername, chatWithName;
  final int chatWithUserID;
  const ChatScreenWithStaff(
      {Key? key,
      required this.chatWithUserID,
      required this.chatWithUsername,
      required this.chatWithName})
      : super(key: key);

  @override
  State<ChatScreenWithStaff> createState() => _ChatScreenWithStaffState();
}

class _ChatScreenWithStaffState extends State<ChatScreenWithStaff> {
  String chatRoomID = "", messageID = "";
  String myUsername = "", myEmail = "", myAvatarName = "";
  late int myID;
  late var messageStream;
  TextEditingController messageTextEditingController = TextEditingController();

  getMyInfoFromSharedPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    myID = pref.getInt('userID')!;
    myAvatarName =
        pref.getString('userInputEmail')!.replaceAll("@gmail.com", "");
    myUsername = pref.getString('userUsername')!;

    chatRoomID = getChatRoomIdByUsername(widget.chatWithUsername, myAvatarName);
    messageStream = DatabaseMethods().getChatRoomMessages(chatRoomID);
    setState(() {});
  }

  getChatRoomIdByUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) async {
    if (messageTextEditingController.text != "") {
      String message = messageTextEditingController.text;

      //var lastMessageTs = DateTime.now();
      // var lastMessageTs = Timestamp.now().toDate();

      // print(DateTime.now());
      // print(Timestamp.now().toDate());

      final response = await http.get(
          Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Kuala_Lumpur'));

      var jsonDecordedResponse = jsonDecode(response.body);

      print(jsonDecordedResponse);

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUsername,
        "timeSent": DateTime.parse(jsonDecordedResponse['datetime'].toString()),
      };

      if (messageID == "") {
        messageID = randomAlphaNumeric(12);
      }

      DatabaseMethods()
          .addMessage(chatRoomID, messageID, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendBy": myUsername,
          "lastMessageTimeSent":
              DateTime.parse(jsonDecordedResponse['datetime'].toString()),
        };

        DatabaseMethods().updateLastMessageSend(chatRoomID, lastMessageInfoMap);

        if (sendClicked) {
          //remove the text in the message input field
          messageTextEditingController.text = "";
          //make the message id blank
          messageID = "";
        }
      });
    }
  }

  Widget chatMessageTile(DateTime time, String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 110),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: sendByMe ? Radius.circular(20) : Radius.circular(0),
              topRight: Radius.circular(20),
              bottomRight: sendByMe ? Radius.circular(0) : Radius.circular(24),
            ),
            //color: sendByMe ? Colors.blue : Color(0xFF3E4042),
            color: sendByMe ? buttonColor : Color(0xFF3E4042),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                DateFormat('yyyy/MM/dd, hh:mm a').format(time).toString(),
                style: TextStyle(
                  color: sendByMe ? Colors.white.withOpacity(0.6) : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 80, top: 16),
                reverse: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var ds = snapshot.data?.docs[index];
                  return chatMessageTile(ds!["timeSent"].toDate(),
                      ds["message"], myUsername == ds["sendBy"]);
                },
              )
            : Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
              );
      },
    );
  }

  getAndSetMessages() async {
    setState(() async {
      messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomID);
    });
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: buildAppBar(),
  //     body: Container(
  //       margin: EdgeInsets.symmetric(horizontal: 20),
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               isSearching
  //                   ? GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           isSearching = false;
  //                           searchTextEditingController.text = "";
  //                           setState(() {});
  //                         });
  //                       },
  //                       child: Padding(
  //                         padding: EdgeInsets.only(
  //                           right: 12,
  //                         ),
  //                         child: Icon(Icons.arrow_back),
  //                       ),
  //                     )
  //                   : Container(),
  //               Expanded(
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   margin: EdgeInsets.symmetric(vertical: 16),
  //                   decoration: BoxDecoration(
  //                     border: Border.all(
  //                       color: Colors.grey,
  //                       width: 1,
  //                       style: BorderStyle.solid,
  //                     ),
  //                     borderRadius: BorderRadius.circular(14),
  //                   ),
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         child: TextField(
  //                           controller: searchTextEditingController,
  //                           decoration: InputDecoration(
  //                             border: InputBorder.none,
  //                             hintText: "username",
  //                           ),
  //                         ),
  //                       ),
  //                       GestureDetector(
  //                         onTap: () {
  //                           setState(() {
  //                             isSearching = true;
  //                           });
  //                         },
  //                         child: Icon(Icons.search),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(widget.name),
      // ),
      appBar: buildAppBar(),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type a message...",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        controller: messageTextEditingController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Icon(
                        Icons.send,
                        color: buttonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              // CircleAvatar(
              //   backgroundImage: AssetImage('assets/images/logo.png'),
              //   maxRadius: 20,
              // ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "REMDII Staff",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
