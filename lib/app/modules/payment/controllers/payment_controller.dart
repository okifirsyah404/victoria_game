import 'package:get/get.dart';
import 'package:victoria_game/app/core/repository/user_repository.dart';
import 'package:victoria_game/app/routes/app_pages.dart';
import 'package:victoria_game/utils/secure_storage.dart';

class PaymentController extends GetxController {
  final _arguments = Get.arguments;

  Map<String, dynamic> get itemData => _arguments["psData"];
  Map<String, dynamic>? get paymentMethod => _arguments["previousMethod"];

  late UserRepository userRepository;
  late SecureStorage secureStorage;

  late Rxn<int> selectedIndex;
  // int userBallance = 0;

  late final List<Map<String, dynamic>> _paymentMethods = [
    {
      "method": "Saldo",
      "ballance": 0,
    },
    {
      "method": "Tunai",
    },
  ];

  List<Map<String, dynamic>> get paymentMethods => _paymentMethods;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void backWithOption() {
    Get.back(
      result: {
        "method": paymentMethods[selectedIndex.value ?? 1]["method"],
        "ballance": paymentMethods[selectedIndex.value ?? 1]["ballance"],
      },
    );
  }

  void initialPaymentMethod() {
    selectedIndex.value = -1;
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
  }

  @override
  void onInit() {
    userRepository = UserRepository.instance;
    secureStorage = SecureStorage.instance;
    selectedIndex = Rxn<int>();
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
