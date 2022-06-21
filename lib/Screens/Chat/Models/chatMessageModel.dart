// ignore: file_names
import 'package:fyp/Screens/Chat/Models/buttonModel.dart';

class ChatMessage {
  String? messageContent;
  String messageType;
  String? img;
  List<Buttons>? btn;
  ChatMessage(
      {this.messageContent, required this.messageType, this.img, this.btn});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    // String image = "";
    String text = "";
    // if (json['image'] == Null) {
    //   image = "null";
    // } else {
    //   image = json['image'];
    // }
    // ;
    if (json['text'] == null) {
      text = "null";
    } else {
      text = json['text'];
    }
    ;
    // String text = json['text'];
    String newString = text.replaceAll("</br>", "\n");
    newString = newString.replaceAll("<br/>", "\n");

    List<Buttons> butn = [];
    List firstBtn = [];
    if (json['buttons'] != null) {
      firstBtn = json['buttons'];
      for (var i = 0; i < firstBtn.length; i++) {
        String a = firstBtn[i].toString();
        butn = firstBtn.map((i) => Buttons.fromJson(i)).toList();
      }
    }

    return ChatMessage(
        messageContent: newString,
        messageType: "sender",
        img: json['image'],
        btn: butn);
  }
}
