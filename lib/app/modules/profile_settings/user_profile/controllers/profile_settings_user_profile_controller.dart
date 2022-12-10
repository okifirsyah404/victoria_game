import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/core/network/response/user_data_response.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../core/services/firebase_auth_services.dart';
import '../../../../routes/app_pages.dart';

class ProfileSettingsUserProfileController extends GetxController {
  //TODO: Implement ProfileSettingsUserProfileController

  final storage = SecureStorage();

  late UserRepository userRepository;
  late String authAccessToken;

  late String phoneNumber;
  late String email;

  String username = "John Doe";
  int ballance = 1000;
  int playTime = 0;

  List<int> imageByte = [];

  void intentWhatsappTopUp() {
    final message = """
Saya ingin topup mas Popo Onichan

Terima Kasih

INFORMASI :

    Nomor Handphone: ${phoneNumber},
    Alamat Email : ${email},
    Username : ${username}
    Tanggal : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())},
    Jam : ${DateFormat("Hm", "id_ID").format(DateTime.now())}
    Saldo TopUp : {Saldo},

""";

    final intent = AndroidIntent(
        action: "android.intent.action.VIEW",
        data: Uri.encodeFull(
            "whatsapp://send?phone=+6281217634111&text=$message"),
        package: "com.whatsapp");

    intent.launch();
  }

  void signOut() async {
    String authToken = await storage.readDataFromStrorage("token") ?? "";
    await userRepository.sumbitSignOut(authToken);
    storage.writeDataToStorage(key: "token", value: "");
    Get.offAllNamed(Routes.AUTH_SIGN_IN);
  }

  Future<String> fetchUserToken() async {
    String authToken = await storage.readDataFromStrorage("token") ?? "";
    var result = await http.get(
        Uri.parse("https://49e7-118-99-121-213.ap.ngrok.io/api/user/image"),
        headers: {userRepository.authorization: authToken});
    return authToken;
  }

  Future<UserDataResponse> fetchUserData() async {
    userRepository = UserRepository.instance;
    String authToken = await storage.readDataFromStrorage("token") ?? "";

    var userData = await userRepository.fetchUserData(authToken);

    username = userData.data?.username ?? "";
    ballance = userData.data?.ballance ?? 1;
    playTime = userData.data?.playTime ?? 1;
    phoneNumber = userData.data?.phone ?? "";
    email = userData.data?.email ?? "";

    return userData;
  }

  Future<Uint8List> fetchUserImage() async {
    var result = await userRepository.getMethodRaw("/api/user/image",
        headers: {userRepository.authorization: authAccessToken});

    print(result.bodyBytes);

    result.bodyBytes.forEach((element) {
      imageByte.add(element);
    });

    return result.bodyBytes;
  }

  Future<void> initUserData() async {
    authAccessToken = await fetchUserToken();
    await fetchUserData();
    await fetchUserImage();
  }

  @override
  void onInit() async {
    userRepository = UserRepository.instance;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
