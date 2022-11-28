import 'package:get/get.dart';
import 'package:victoria_game/app/routes/app_pages.dart';

class PaymentController extends GetxController {
//  FIXME: Receive argument to keep payment method
  var _arguments = Get.arguments;

  Map<String, dynamic> get itemData => _arguments[0];
  Map<String, dynamic>? get dateData => _arguments[1];
  Map<String, dynamic>? get paymentData => _arguments[2];
  Map<String, dynamic>? get shipmentData => _arguments[3];

  late Rxn<int> selectedIndex;

  List<Map<String, dynamic>> _paymentMethods = [
    {
      "methodTitle": "Saldo",
      "ballance": 1000000,
    },
    {"methodTitle": "Tunai"},
  ];

  List<Map<String, dynamic>> get paymentMethods => _paymentMethods;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void backWithOption() {
    Get.offNamedUntil(Routes.ORDER_DETAILS_AT_HOME, (route) => route.isFirst,
        arguments: [
          itemData,
          dateData,
          paymentMethods[selectedIndex.value ?? -1],
          shipmentData
        ]);
    // Get.back(
    //   result: {
    //     "method": paymentMethods[selectedIndex.value ?? 1]["methodTitle"],
    //     "ballance": paymentMethods[selectedIndex.value ?? 1]["ballance"],
    //   },
    // );
  }

  // TODO: checking argument for payment
  void initialPaymentMethod() {
    var paymentMethod = paymentData;

    selectedIndex.value = -1;
    if (paymentMethod != null && paymentMethod != "") {
      for (var i = 0; i < paymentMethods.length; i++) {
        if (paymentMethods[i]["methodTitle"] == paymentMethod) {
          selectedIndex.value = i;
        }
      }
    }
  }

  @override
  void onInit() {
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
