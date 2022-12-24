import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

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

    print('User granted permission: ${settings.authorizationStatus}');
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
    initFirebaseMessaging();
    getPackageInfo();
    super.onInit();
  }
}
