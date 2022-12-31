import 'package:permission_handler/permission_handler.dart';

abstract class PermissionServices {
  Future<void> requestOpenAppSettings() async {
    var openSetting = await openAppSettings();
  }

  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.storage.request();
  }

  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  Future<PermissionStatus> requestGaleryPermission() async {
    return await Permission.storage.request();
  }

  Future<Map<Permission, PermissionStatus>>
      requestCameraGaleryPermission() async {
    return await [
      Permission.camera,
      Permission.storage,
    ].request();
  }

  Future<Map<Permission, PermissionStatus>>
      requestAllRequiredPermission() async {
    return await [
      Permission.camera,
      Permission.storage,
      Permission.location,
    ].request();
  }
}
