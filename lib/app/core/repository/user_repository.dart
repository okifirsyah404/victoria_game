import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:victoria_game/app/core/network/response/auth/sign_in_res.dart';
import 'package:victoria_game/app/core/network/response/auth/sign_out_res.dart';
import 'package:victoria_game/app/core/network/response/user_data_response.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/app/core/services/permission_services.dart';

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

  Future<UserDataResponse> fetchUserData(String authToken) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response = await getMethod("/api/user", headers: headers);
    var userData = UserDataResponse.fromJson(response);
    return userData;
  }

  Future<SignOutResponse> sumbitSignOut(String authToken) async {
    var headers = {
      contentType: applicationJson,
      authorization: authToken,
    };

    var response = await getMethod("/api/auth/signout", headers: headers);
    return SignOutResponse.fromJson(response);
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
}
