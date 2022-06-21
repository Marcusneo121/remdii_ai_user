// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// // import 'package:travel_app/model/push_notification.dart';
// import 'package:overlay_support/overlay_support.dart';
//
// class PushNotificationService {
//   final FirebaseMessaging _fcm;
//
//
//   PushNotificationService(this._fcm);
//
//   Future initialise() async {
//
//     // if (Platform.isIOS) {
//     //   _fcm.requestNotificationPermissions(IosNotificationSettings());
//     // }
//
//     // If you want to test the push notification locally,
//     // you need to get the token and input to the Firebase console
//     // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
//     String? token = await _fcm.getToken();
//     print("FirebaseMessaging token: $token");
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         // PushNotificationMessage notification = PushNotificationMessage(
//         //   title: message.notification!.title ?? '',
//         //   body: message.notification!.body ?? '',
//         // );
//         // print('body:' + notification.body);
//         var _notificationInfo = message.notification;
//         showSimpleNotification(
//           Text(_notificationInfo!.title!),
//           // leading: NotificationBadge(totalNotifications: _totalNotifications),
//           subtitle: Text(_notificationInfo.body!),
//           background: Colors.white,
//           duration: Duration(seconds: 2),
//         );
//       }
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//     });
//     // _fcm.configure(
//     //   onMessage: (Map<String, dynamic> message) async {
//     //     print("onMessage: $message");
//     //   },
//     //   onLaunch: (Map<String, dynamic> message) async {
//     //     print("onLaunch: $message");
//     //   },
//     //   onResume: (Map<String, dynamic> message) async {
//     //     print("onResume: $message");
//     //   },
//     // );
//   }
// }
//
//
// // import 'package:firebase_messaging/firebase_messaging.dart';
// //
// // class PushNotificationService {
// //   final FirebaseMessaging _fcm;
// //
// //   PushNotificationService(this._fcm);
// //
// //   Future initialise() async {
// //     if (Platform.isIOS) {
// //       _fcm.requestNotificationPermissions(IosNotificationSettings());
// //     }
// //
// //     // If you want to test the push notification locally,
// //     // you need to get the token and input to the Firebase console
// //     // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
// //     String? token = await _fcm.getToken();
// //     print("FirebaseMessaging token: $token");
// //
// //     _fcm.configure(
// //       onMessage: (Map<String, dynamic> message) async {
// //         print("onMessage: $message");
// //       },
// //       onLaunch: (Map<String, dynamic> message) async {
// //         print("onLaunch: $message");
// //       },
// //       onResume: (Map<String, dynamic> message) async {
// //         print("onResume: $message");
// //       },
// //     );
// //   }
// // }