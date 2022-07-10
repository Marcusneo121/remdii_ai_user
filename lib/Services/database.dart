import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      String userID, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future addMessage(String chatRoomID, String messageID,
      Map<String, dynamic> messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomID)
        .collection("chats")
        .doc(messageID)
        .set(messageInfoMap);
  }

  updateLastMessageSend(
      String chatRoomID, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomID)
        .update(lastMessageInfoMap);
  }

  createChatRoom(
      String chatRoomID, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomID)
        .get();

    if (snapshot.exists) {
      return true;
    } else {
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomID)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(String chatRoomID) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomID)
        .collection("chats")
        .orderBy("timeSent", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms(String myUsername) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageTimeSent", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(int userID) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .get();
  }
}
