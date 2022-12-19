import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
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
    getPackageInfo();
    super.onInit();
  }
}
