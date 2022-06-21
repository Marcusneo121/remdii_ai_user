import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:rxdart/subjects.dart';

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  var initSetting;

  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotifyManager.init() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    _flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  initializePlatform() {
    var initSettingAndroid =
        AndroidInitializationSettings('app_notification_icon');
    var initSettingIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
              id: id, title: title, body: body, payload: payload);
          didReceiveLocalNotificationSubject.add(notification);
        });
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await _flutterLocalNotificationsPlugin!.initialize(initSetting,
        onSelectNotification: (String? payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: 'icon_notification_replace',
      // largeIcon: DrawableResourceAndroidBitmap('icon_large_notification'),
      // timeoutAfter: 5000,
      // enableLights: true,
    );
    var IOSChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: IOSChannel);
    await _flutterLocalNotificationsPlugin!.show(
      0,
      'Update Eczema Recovery Progress',
      'Please update at your Profile > View and Update.',
      platformChannel,
      payload: 'New Payload',
    );
  }

  Future<void> scheduleNotification() async {
    var scheduleNotificationDateTime = DateTime.now().add(Duration(days: 3));
    var androidChannel = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: 'icon_notification_replace',
      // largeIcon: DrawableResourceAndroidBitmap('icon_large_notification'),
      // timeoutAfter: 5000,
      // enableLights: true,
    );
    var IOSChannel = IOSNotificationDetails();
    var platformChannel =
    NotificationDetails(android: androidChannel, iOS: IOSChannel);

    await _flutterLocalNotificationsPlugin!.schedule(
      0,
      'Update Recovery Progress',
      'Please update at your Profile > View and Update.',
      scheduleNotificationDateTime,
      platformChannel,
      payload: 'New Payload',
    );
  }

  Future<void> cancelAllNotification() async {
    await _flutterLocalNotificationsPlugin!.cancelAll();
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceiveNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}
