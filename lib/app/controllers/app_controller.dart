import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:victoria_game/utils/firebase_notification.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class AppController extends GetxController {
  late SecureStorage _secureStorage;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initFirebaseMessaging() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((event) {
      showNotification(event, flutterLocalNotificationsPlugin);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      showNotification(event, flutterLocalNotificationsPlugin);
    });
    FirebaseMessaging.onBackgroundMessage((message) =>
        showNotification(message, flutterLocalNotificationsPlugin));
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });

    var fmcToken = await FirebaseMessaging.instance.getToken() ?? "";

    print("FCM : $fmcToken");

    _secureStorage.writeDataToStorage(key: "fcmToken", value: fmcToken);
  }

  void initNotificationSetting() {
    var initsettingAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSetting =
        InitializationSettings(android: initsettingAndroid);

    flutterLocalNotificationsPlugin.initialize(initSetting,
        onDidReceiveNotificationResponse: onSelectNotification);
  }

  Future<dynamic> onSelectNotification(payload) async {
    Get.toNamed(payload);
  }

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  late String appVersion = packageInfo.version;

  getPackageInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo = info;
  }

  @override
  void onInit() {
    _secureStorage = SecureStorage.instance;
    initFirebaseMessaging();
    getPackageInfo();
    super.onInit();
  }
}
