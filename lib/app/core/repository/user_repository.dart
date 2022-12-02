import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/app/core/network/response/auth/sign_in_res.dart';
import 'package:victoria_game/app/core/services/permission_services.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';

class UserRepository extends NetworkServices with PermissionServices {
  UserRepository();
  final storage = const FlutterSecureStorage();

  UserRepository._privateConstructor();

  static final UserRepository _instance = UserRepository._privateConstructor();

  static UserRepository get instance => _instance;

  Future<SignInResponse> submitSignIn(
      {required String email, required String password}) async {
    var headers = {contentType: applicationJson};

    var body = {
      "email": email,
      "password": password,
    };
    var response =
        await postMethod("/api/auth/signin", body: body, headers: headers);
    var userData = SignInResponse.fromJson(response);

    return userData;
  }

  Future<bool> handleCameraGaleryPermission() async {
    var permissions = await requestCameraGaleryPermission();

    printLog.d(permissions);

    if (permissions[Permission.camera] == PermissionStatus.granted &&
        permissions[Permission.storage] == PermissionStatus.granted) {
      printLog.d("Granted");
      return true;
    }

    printLog.d("Denied");
    return false;
  }

  Future<String?> readSecureData(String key) {
    var readData = storage.read(key: key);
    return readData;
  }

  Object writeSecureTokenData(String key, String value) {
    var writeData = storage.write(key: key, value: value);
    return writeData;
  }
}
