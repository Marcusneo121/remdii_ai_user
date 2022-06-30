import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/Screens/Dashboard/Components/View%20Orders/view_orders_screen.dart';
import 'package:fyp/Screens/EczemaDiagnosis/Components/questionnaire.dart';
import 'package:fyp/Screens/MyCart/payment_screen.dart';
import 'package:fyp/Screens/Welcome/welcome_screen.dart';
import 'package:fyp/Services/local_notification_service.dart';
import 'package:fyp/constants.dart';
import 'package:fyp/testing.dart';
import 'PushNotificationService.dart';
import 'Screens/Dashboard/Components/Update Recovery Progress/update_sleep_time_screen.dart';
import 'Screens/Dashboard/Components/Update Recovery Progress/view_and_update_screen.dart';
import 'Screens/Homepage/homepage_screen.dart';

// void main() {
//   runApp(DevicePreview(builder: (context) => MyApp(), enabled: !kReleaseMode,));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // runApp(DevicePreview(builder: (context) => MyApp(), enabled: !kReleaseMode,));
  runApp(MyApp());
}

// only work when app is on background (Receive msg when app is in background, solution for on message
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   // await Firebase.initializeApp();
//   print(message.data.toString());
//   print(message.notification!.title);
//   print("Handling a background message: ${message.messageId}");
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
//   if (message.notification != null) {
//     print(message.notification!.title);
//     print(message.notification!.body);
//   }
//
//   // Create a notification for this
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // Background Message Handler
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   runApp(DevicePreview(builder: (context) => MyApp(), enabled: !kReleaseMode,));
// }

class MyApp extends StatefulWidget {
  // // This widget is the root of your application.
  // static final FirebaseMessaging _firebaseMessaging =
  //     FirebaseMessaging.instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // LocalNotificationService.initialize(context);
    // FirebaseMessaging.instance.requestPermission().then((value) {
    //   print(value);});
    // FirebaseMessaging.instance.getToken().then((token){
    //   print(token);});
    // FirebaseMessaging.instance.getAPNSToken().then((APNStoken){
    //   print(APNStoken);});

    // gives you the message on which user taps and it opened the app from terminated state
    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   final routeFromMsg = message!.data["route"];
    //   print(routeFromMsg);
    //   if(message.data != null){
    //     if(routeFromMsg == 'checked'){
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) {
    //             return ViewUpdate();
    //           },
    //         ),
    //       );
    //     }
    //   }
    //
    // });

    // foreground work
    // FirebaseMessaging.onMessage.listen((message) {
    //   if(message.notification != null){
    //     print(message.notification!.title);
    //     print(message.notification!.body);
    //   }
    //
    //   LocalNotificationService.display(message);
    // });

    // when the app is in background but opened and user taps on the notification
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   final routeFromMsg = message.data["route"];
    //   print(routeFromMsg);
    //   if(routeFromMsg == 'checked'){
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) {
    //           return ViewUpdate();
    //         },
    //       ),
    //     );
    //   }
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final pushNotificationService = PushNotificationService(MyApp._firebaseMessaging);
    // pushNotificationService.initialise();
    return MaterialApp(
      title: 'Flutter Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        // unselectedWidgetColor: buttonColor
      ),
      builder: EasyLoading.init(),
      home: WelcomeScreen(),
      // home: HomepageScreen()
      // home: TestNotifyScreen(),
      // home: UpdateSleepTimeScreen()
      // home:QuestionnaireScreen(),
    );
  }
}

// final Map<String, Widget Function(BuildContext)> routes = {
//   PDetailsScreen.routeName: (context) => PDetailsScreen(),
// };
