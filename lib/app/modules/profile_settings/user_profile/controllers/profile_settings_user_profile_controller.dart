import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:victoria_game/app/core/network/response/user_data_response.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/global/widgets/alert_dialog/single_action_dialog/single_action_dialog.dart';
import 'package:victoria_game/utils/secure_storage.dart';

import '../../../../routes/app_pages.dart';

class ProfileSettingsUserProfileController extends GetxController {
  //TODO: Implement ProfileSettingsUserProfileController

  late SecureStorage _storage;

  late UserRepository _userRepository;

  late String phoneNumber;
  late String email;

  String username = "John Doe";
  int ballance = 1000;
  int playTime = 0;

  List<int> imageByte = [];

  void intentWhatsappTopUp() async {
    final message = """
Hi, Kak. Saya ingin topup untuk bermain di Tolonto

Terima Kasih

INFORMASI :

    Nomor Handphone: $phoneNumber,
    Alamat Email : $email,
    Username : $username
    Tanggal : ${DateFormat("EEEE, dd MMMM yyyy", "id_ID").format(DateTime.now())},
    Jam : ${DateFormat("Hm", "id_ID").format(DateTime.now())}
    Saldo TopUp : {Isi Saldo},

""";

    try {
      await launchUrl(
          Uri.parse("whatsapp://send?phone=+6281217634111&text=$message"));
    } catch (e) {
      Get.dialog(SingleActionDialog(
        title: "Error",
        description: e.toString(),
      ));
    }
  }

  void intentMail() {
    // var intentPlaceName = gameCenterName.replaceAll(RegExp("\\s+"), '+');
    final intent = AndroidIntent(
        action: "android.intent.action.VIEW",
        data: Uri.encodeFull("mailto:tolontobjn43@gmail.com?subject=Issue"),
        package: "com.google.android.gm");

    intent.launch();
  }

  void signOut() async {
    String authToken = await _storage.readDataFromStrorage("token") ?? "";
    await _userRepository.sumbitSignOut(authToken);
    _storage.writeDataToStorage(key: "token", value: "");
    Get.offAllNamed(Routes.AUTH_SIGN_IN);
  }

  Future<UserDataResponse> fetchUserData() async {
    String authToken = await _storage.readDataFromStrorage("token") ?? "";

    var userData = await _userRepository.fetchUserData(authToken);

    username = userData.data?.username ?? "";
    ballance = userData.data?.ballance ?? 1;
    playTime = userData.data?.playTime ?? 1;
    phoneNumber = userData.data?.phone ?? "";
    email = userData.data?.email ?? "";

    return userData;
  }

  Future<Uint8List> fetchUserImage() async {
    String authToken = await _storage.readDataFromStrorage("token") ?? "";
    var result = await _userRepository.getMethodRaw("/api/user/image",
        headers: {_userRepository.authorization: authToken});

    imageByte = [...result.bodyBytes];

    return result.bodyBytes;
  }

  Future<void> initUserData() async {
    await fetchUserData();
    await fetchUserImage();
  }

  @override
  void onInit() async {
    _storage = SecureStorage.instance;
    _userRepository = UserRepository.instance;
    super.onInit();
  }
}
