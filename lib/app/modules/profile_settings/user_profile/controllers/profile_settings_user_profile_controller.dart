import 'package:android_intent_plus/android_intent.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/firebase_auth_services.dart';
import '../../../../routes/app_pages.dart';

class ProfileSettingsUserProfileController extends GetxController {
  //TODO: Implement ProfileSettingsUserProfileController

  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

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

  void signOut() {
    firebaseAuthServices.signOutUserPasswordBased();
    Get.offAllNamed(Routes.AUTH_SIGN_IN);
  }

  @override
  void onInit() async {
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
