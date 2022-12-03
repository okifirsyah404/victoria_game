import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:victoria_game/app/core/network/response/user_data_response.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';

import '../../../../core/services/firebase_auth_services.dart';
import '../../../../routes/app_pages.dart';

class ProfileSettingsUserProfileController extends GetxController {
  //TODO: Implement ProfileSettingsUserProfileController

  var storage = const FlutterSecureStorage();

  late UserRepository userRepository;
  late String authAccessToken;

  String username = "John Doe";
  int ballance = 1000;
  int playTime = 0;

  void intentWhatsappTopUp() {
    final message = """
Saya ingin topup mas Popo Onichan

INFORMASI :

    Nomor Handphone: {Nomor Anda},
    Alamat Email : {Email Anda},
    Tanggal : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())},
    Jam : ${DateFormat("Hm", "id_ID").format(DateTime.now())}
    Saldo TopUp : {Saldo},

Terima Kasih

Cuma testing Intent WA

""";

    final intent = AndroidIntent(
        action: "android.intent.action.VIEW",
        data: Uri.encodeFull(
            "whatsapp://send?phone=+6281217634111&text=$message"),
        package: "com.whatsapp");

    intent.launch();
  }

  void signOut() async {
    String authToken = await storage.read(key: "token") ?? "";
    await userRepository.sumbitSignOut(authToken);
    await storage.write(key: "token", value: "");
    Get.offAllNamed(Routes.AUTH_SIGN_IN);
  }

  Future<String> fetchUserImage() async {
    String authToken = await storage.read(key: "token") ?? "";
    return authToken;
  }

  Future<UserDataResponse> fetchUserData() async {
    userRepository = UserRepository.instance;
    String authToken = await storage.read(key: "token") ?? "";

    var userData = await userRepository.fetchUserData(authToken);

    print(userData);
    print(userData.data);

    username = userData.data?.username ?? "";
    ballance = userData.data?.ballance ?? 1;
    playTime = userData.data?.playTime ?? 1;

    return userData;
  }

  void initUserData() async {
    authAccessToken = await fetchUserImage();
    await fetchUserData();
  }

  @override
  void onInit() async {
    userRepository = UserRepository.instance;
    initUserData();
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
