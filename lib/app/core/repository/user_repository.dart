import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:victoria_game/app/core/network/network_service.dart';
import 'package:victoria_game/app/core/network/response/auth/sign_in_res.dart';

class UserRepository extends NetworkServices {
  UserRepository();

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
        await postMethod("/loginApi.php", body: body, headers: headers);

    var userData = SignInResponse.fromJson(response);

    return userData;
  }
}
