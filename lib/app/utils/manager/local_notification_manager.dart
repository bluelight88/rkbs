import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final class LocalNotificationManager {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static bool isInitialized = false;

  static void initialize(BuildContext context) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          iOS: DarwinInitializationSettings(),
        );
    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notification) async {
        Map<String, dynamic> messageData = jsonDecode(
          notification.payload.toString(),
        );
        navigate(context, messageData);
      },
    );
    isInitialized = true;
  }

  static void displayMessage(RemoteMessage message) async {
    debugPrint(message.data.toString());
    try {
      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'moh_provider_channel', // id
          'High Importance Notifications', // title
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
          presentBadge: true,
        ),
      );
      await _notificationsPlugin.show(
        id,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static void navigate(BuildContext context, Map<String, dynamic> messageData) {
    /// put you custom navigation here
    debugPrint('Navigate started');
  }
}
