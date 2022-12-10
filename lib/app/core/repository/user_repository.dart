import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:victoria_game/app/core/network/response/auth/reset_password_res.dart';
import 'package:victoria_game/app/core/network/response/auth/sign_in_res.dart';
import 'package:victoria_game/app/core/network/response/auth/sign_out_res.dart';
import 'package:victoria_game/app/core/network/response/auth/sign_up_res.dart';
import 'package:victoria_game/app/core/network/response/auth/verify_sign_up_res.dart';
import 'package:victoria_game/app/core/network/response/multipart_profile_response.dart';
import 'package:victoria_game/app/core/network/response/user_data_response.dart';
import 'package:victoria_game/app/core/services/network_service.dart';
import 'package:victoria_game/app/core/services/permission_services.dart';
import 'package:victoria_game/utils/string_extensions.dart';

class UserRepository extends NetworkServices with PermissionServices {
  UserRepository();
  final storage = const FlutterSecureStorage();

  UserRepository._privateConstructor();

  static final UserRepository _instance = UserRepository._privateConstructor();

  static UserRepository get instance => _instance;

  Future<OtpResponse> submitVerifySignUp({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    var headers = {contentType: applicationJson};

    var body = {
      "email": email,
      "password": password,
      "username": username,
      "phone": phone,
    };

    var response = await postMethod("/api/auth/signup/verify",
        headers: headers, body: body);

    var result = OtpResponse.fromJson(response);
    return result;
  }

  Future<SignUpResponse> submitSignUp({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    var headers = {contentType: applicationJson};

    var cryptoPassword = password.convertToSHA256();

    var body = {
      "email": email,
      "password": cryptoPassword,
      "username": username,
      "phone": phone,
    };

    var response =
        await postMethod("/api/auth/signup", headers: headers, body: body);

    var result = SignUpResponse.fromJson(response);
    return result;
  }

  Future<SignInResponse> submitSignIn(
      {required String email, required String password}) async {
    var headers = {contentType: applicationJson};

    var cryptoPassword = password.convertToSHA256();

    var body = {
      "email": email,
      "password": cryptoPassword,
    };
    var response =
        await postMethod("/api/auth/signin", body: body, headers: headers);
    var userData = SignInResponse.fromJson(response);

    return userData;
  }

  Future<OtpResponse> submitForgetPassword({
    required String email,
  }) async {
    var headers = {contentType: applicationJson};

    var body = {"email": email};

    var response = await postMethod("/api/auth/forgot-password/verify",
        headers: headers, body: body);

    var result = OtpResponse.fromJson(response);
    return result;
  }

  Future<ForgetPasswordResponse> submitNewForgetPassword(
      {required String newPassword, required String email}) async {
    var headers = {contentType: applicationJson};

    var cryptoPassword = newPassword.convertToSHA256();

    var body = {"email": email, "password": cryptoPassword};

    var response = await putMethod("/api/auth/forgot-password",
        headers: headers, body: body);

    var result = ForgetPasswordResponse.fromJson(response);
    return result;
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

    var response = await getMethod(
      "/api/auth/signout",
      headers: headers,
    );
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

  Future<MultipartProfileResponse> updateUserProfile({
    required String authToken,
    required File file,
  }) async {
    var header = {contentType: applicationJson, authorization: authToken};
    var requestFile = {"file": file};

    var result = await multipartPostMethod(
      endpoint: "/api/user/image",
      files: requestFile,
      headers: header,
    );

    return MultipartProfileResponse.fromJson(result);
  }

  Future<UserDataResponse> updatePhoneNumber({
    required String authToken,
    required String newPhoneNumber,
  }) async {
    var header = {contentType: applicationJson, authorization: authToken};

    var body = {"phone": newPhoneNumber};

    var result = await putMethod(
      "/api/user/phone",
      body: body,
      headers: header,
    );

    var userData = UserDataResponse.fromJson(result);
    return userData;
  }

  Future<UserDataResponse> updateUsername({
    required String authToken,
    required String newUsername,
  }) async {
    var header = {contentType: applicationJson, authorization: authToken};

    var body = {"username": newUsername};

    var result = await putMethod(
      "/api/user/username",
      body: body,
      headers: header,
    );

    var userData = UserDataResponse.fromJson(result);
    return userData;
  }

  Future<OtpResponse> submitResetOtpPassword({
    required String authToken,
  }) async {
    var headers = {contentType: applicationJson, authorization: authToken};

    var response = await getMethod(
      "/api/user/password/verify",
      headers: headers,
    );

    var result = OtpResponse.fromJson(response);
    return result;
  }

  Future<UserDataResponse> submitResetPassword(
      {required String authToken, required String newPassword}) async {
    var headers = {contentType: applicationJson, authorization: authToken};

    var cryptoPassword = newPassword.convertToSHA256();
    var body = {"password": cryptoPassword};

    var response = await putMethod(
      "/api/user/password",
      headers: headers,
      body: body,
    );

    var result = UserDataResponse.fromJson(response);
    return result;
  }
}
