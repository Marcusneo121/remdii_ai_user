// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:fyp/Screens/Dashboard/view_and_update_screen.dart';
//
// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   static void initialize(BuildContext context) {
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//             iOS: IOSInitializationSettings(
//               requestSoundPermission: false,
//               requestBadgePermission: false,
//               requestAlertPermission: false,
//             ));
//
//     _notificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? route) async {
//       if (route != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return ViewUpdate();
//             },
//           ),
//         );
//       }
//     });
//   }
//
//   static void display(RemoteMessage message) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       final NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           "remdii",
//           "remdii_channel",
//           // "this is remdii channel",
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: IOSNotificationDetails(),
//       );
//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data["route"],
//       );
//     } on Exception catch (e) {
//       print(e);
//     }
//   }
// }
