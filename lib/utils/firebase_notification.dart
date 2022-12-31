import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future showNotification(RemoteMessage message,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  RemoteNotification? notification = message.notification;
  Map<String, dynamic> notificationData = message.data;

  String screens = notificationData['n_type'].toString();
  print(screens);

  if (screens != 'direct message') {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel1',
      'High Importance Notifications',
      importance: Importance.high,
      playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    RemoteNotification? data = message.notification;
    Map<String, dynamic> notificationData = message.data;

    String screen = notificationData['title'].toString();
    print(message.data);

    AndroidNotification? android = message.notification?.android;
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                groupKey: channel.groupId,
                icon: '@mipmap/ic_launcher',
                enableVibration: true,
                importance: Importance.high,
                priority: Priority.high,
                playSound: true),
            iOS: const DarwinNotificationDetails(
                presentAlert: true, presentSound: true, presentBadge: true),
          ),
          payload: '');
    }
  } else {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications', // title
      importance: Importance.high,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    RemoteNotification? data = message.notification;
    Map<String, dynamic> notificationData = message.data;

    String screen = notificationData['title'].toString();

    AndroidNotification? android = message.notification?.android;
    if (data != null) {
      flutterLocalNotificationsPlugin.show(
          1,
          data.title,
          data.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              groupKey: channel.groupId,
              icon: '@mipmap/ic_launcher',
              enableVibration: true,
              importance: Importance.high,
              priority: Priority.high,
              playSound: true,
              styleInformation: const BigTextStyleInformation(''),
            ),
            iOS: const DarwinNotificationDetails(
                presentAlert: true, presentSound: true, presentBadge: true),
          ),
          payload: '');
    }
  }
}
