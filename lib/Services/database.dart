import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/DB_Models/User.dart';

class DatabaseMethods {
  addUserInfoToDB(String userID, Map<String, dynamic> userInfoMap) {
    FirebaseFirestore.instance.collection("users").doc(userID).set(userInfoMap);
  }
}
