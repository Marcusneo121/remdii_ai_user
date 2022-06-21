import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/Screens/Chat/Models/chatMessageModel.dart';
import 'package:fyp/Screens/Chat/Models/ownMessageCard.model.dart';
import 'package:fyp/Screens/Chat/constants.dart';
import 'package:http/http.dart' as http;
import 'package:linkable/linkable.dart';
import 'dart:convert' show jsonDecode, jsonEncode;


import 'Models/buttonModel.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final myController = TextEditingController();
  final _controller = ScrollController();
  var user_id = "kiew";
  List messages = [
    ChatMessage(messageContent: "Hi", messageType: "sender", img: "null"),
  ];

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
            (_) => getBotResponse(messages[0].messageContent));
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
          () => _controller.jumpTo(_controller.position.maxScrollExtent),
    );
    return Scaffold(
      appBar: AppBar(
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
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "REMDII BOT",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            controller: _controller,
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 50),
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              if (messages[index].img != "null") {
                return OwnMessageCard(
                    message: messages[index].messageContent,
                    messageType: messages[index].messageType,
                    img: messages[index].img);
              } else
                return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Linkable(
                              text: messages[index].messageContent,
                              style: TextStyle(fontSize: 15),
                            ),
                            if (messages[index].btn != null)
                              ListView.builder(
                                  itemCount: messages[index].btn.length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, position) {
                                    return Card(
                                      child: ListTile(
                                        // title: Text("hi")
                                        title: Text(messages[index]
                                            .btn[position]
                                            .title),
                                        onTap: () {
                                          setState(() => messages.add(
                                              new ChatMessage(
                                                  messageContent:
                                                  messages[index]
                                                      .btn[position]
                                                      .title,
                                                  messageType: "sender",
                                                  img: "null",
                                                  btn: null)));
                                          getBotResponse(messages[index]
                                              .btn[position]
                                              .payload);
                                        },
                                      ),
                                    );
                                  }),
                          ],
                        ),
                      ),
                    ));
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                      controller: myController,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (myController.text != "") {
                        setState(() => messages.add(new ChatMessage(
                            messageContent: myController.text,
                            messageType: "sender",
                            img: "null")));
                        getBotResponse(myController.text);
                        myController.text = "";
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please write some message",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            fontSize: 20);
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<http.Response> getBotResponse(message) async {
    print('jahhahaha');
    // var url = Uri.parse('http://192.168.0.169:5005/webhooks/rest/webhook');
    var url = Uri.parse('http://i2hub.tarc.edu.my:5005/webhooks/rest/webhook');
    // final response = await http.get('http://192.168.1.2:8000/products.json');
    // if (response.statusCode == 200) {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'sender': user_id, 'message': message}),
    );
    print('1');
    print(response.statusCode);
    final responseFormat = jsonDecode(response.body);

    // print(responseFormat);
//    final data = responseFormat["data"];
    for (var i = 0; i < responseFormat.length; i++) {
      // print(responseFormat[i]);
      String? text = ChatMessage.fromJson(responseFormat[i]).messageContent;
      String? img = ChatMessage.fromJson(responseFormat[i]).img;
      List<Buttons>? btn = ChatMessage.fromJson(responseFormat[i]).btn;
      // print(text);

      if (btn != null) {
        for (var i = 0; i < btn.length; i++) {
          String a = btn[i].toString();
          // print(a);
        }
      }

      if (text == null) {
        text = "null";
      }

      if (img == null) {
        img = "null";
      }
      final newString = text.replaceAll("</br>", "\n");
      // }
      String err = "I am facing some issues, please try again later!!!";
      setState(() => messages.add(new ChatMessage(
          messageContent: newString,
          messageType: "receiver",
          img: img,
          btn: btn)));
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
    print(response.statusCode);
    return response;
  }

  void choiceAction(String choice) {
    if (choice == Constants.ChatWithStaff) {
      // navigate to chat with staff screen.. <<<<<--------------------

      // } else if (choice == Constants.Clear) {
      //   setState(() => messages = []);
    } else if (choice == Constants.Restart) {
      // restart
      setState(() => messages = [
        ChatMessage(
            messageContent: "Hi", messageType: "sender", img: "null")
      ]);
      getBotResponse(messages[0].messageContent);
    }
  }
}
