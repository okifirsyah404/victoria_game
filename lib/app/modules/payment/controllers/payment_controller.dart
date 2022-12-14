import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class PaymentController extends GetxController {
  final _arguments = Get.arguments;
  Map<String, dynamic>? get paymentMethod => _arguments["previousMethod"];
  int? get totalAmount => _arguments["totalAmount"];

  late UserRepository userRepository;
  late SecureStorage secureStorage;

  RxInt selectedIndex = (-1).obs;
  int userBallance = 0;

  late final List<Map<String, dynamic>> _paymentMethods = [
    {
      "method": "Saldo",
      "ballance": 0,
      "enabled": false,
    },
    {
      "method": "Tunai",
      "enabled": true,
    },
  ];

  List<Map<String, dynamic>> get paymentMethods => _paymentMethods;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void backWithOption() {
    Get.back(
      result: {
        "method": paymentMethods[selectedIndex.value]["method"],
        "ballance": paymentMethods[selectedIndex.value]["ballance"],
      },
    );
  }

  void initialPaymentMethod() async {
    // selectedIndex.value = -1;
    if (paymentMethod != null && paymentMethod?["method"] != "") {
      for (var i = 0; i < paymentMethods.length; i++) {
        if (paymentMethods[i]["method"] == paymentMethod?["method"]) {
          selectedIndex.value = i;
        }
      }
    }
  }

  Future<void> fetchUserData() async {
    String authToken = await secureStorage.readDataFromStrorage("token") ?? "";

    var userData = await userRepository.fetchUserData(authToken);
    _paymentMethods[0]['ballance'] = userData.data?.ballance ?? 0;

    if (_paymentMethods[0]['ballance'] >= totalAmount) {
      _paymentMethods[0]['enabled'] = true;
    }
  }

  @override
  void onInit() {
    userRepository = UserRepository.instance;
    secureStorage = SecureStorage.instance;
    initialPaymentMethod();
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
